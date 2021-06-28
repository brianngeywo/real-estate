import 'dart:async';

import 'package:Realify/backend/models/phone_euth_model.dart';
import 'package:Realify/backend/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';


class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final AuthRepository _phoneAuthRepository;
  AuthBloc({@required AuthRepository phoneAuthRepository})
      : assert(phoneAuthRepository != null),
        _phoneAuthRepository = phoneAuthRepository,
        super(AuthInitial());

  @override
  Stream<AuthBlocState> mapEventToState(
    AuthBlocEvent event,
  ) async* {
    if (event is AuthNumberVerified) {
      yield* _phoneAuthNumberVerifiedToState(event);
    } else if (event is AuthCodeAutoRetrevalTimeout) {
      yield AuthCodeAutoRetrevalTimeoutComplete(event.verificationId);
    } else if (event is AuthCodeSent) {
      yield AuthNumberVerificationSuccess(verificationId: event.verificationId);
    } else if (event is AuthVerificationFailed) {
      yield AuthNumberVerficationFailure(event.message);
    } else if (event is AuthVerificationCompleted) {
      yield AuthCodeVerificationSuccess(uid: event.uid);
    } else if (event is AuthCodeVerified) {
      yield* _phoneAuthCodeVerifiedToState(event);
    }
  }

  Stream<AuthBlocState> _phoneAuthNumberVerifiedToState(AuthNumberVerified event) async* {
    try {
      yield AuthLoading();
      await _phoneAuthRepository.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        onCodeAutoRetrievalTimeOut: _onCodeAutoRetrievalTimeout,
        onCodeSent: _onCodeSent,
        onVerificaitonFailed: _onVerificationFailed,
        onVerificationCompleted: _onVerificationCompleted,
      );
    } on Exception catch (e) {
      print('Exception occured while verifying phone number ${e.toString()}');
      yield AuthNumberVerficationFailure(e.toString());
    }
  }

  Stream<AuthBlocState> _phoneAuthCodeVerifiedToState(AuthCodeVerified event) async* {
    try {
      yield AuthLoading();
      PhoneAuthModel phoneAuthModel =
          await _phoneAuthRepository.verifySMSCode(smsCode: event.smsCode, verificationId: event.verificationId);
      yield AuthCodeVerificationSuccess(uid: phoneAuthModel.uid);
    } on Exception catch (e) {
      print('Excpetion occured while verifying OTP code ${e.toString()}');
      yield AuthCodeVerficationFailure(e.toString(), event.verificationId);
    }
  }

  void _onVerificationCompleted(AuthCredential credential) async {
    final PhoneAuthModel phoneAuthModel = await _phoneAuthRepository.verifyWithCredential(credential: credential);
    if (phoneAuthModel.phoneAuthModelState == PhoneAuthModelState.verified) {
      add(AuthVerificationCompleted(phoneAuthModel.uid));
    }
  }

  void _onVerificationFailed(FirebaseException exception) {
    print('Exception has occured while verifying phone number: ${exception.toString()}');
    add(AuthVerificationFailed(exception.toString()));
  }

  void _onCodeSent(String verificationId, int token) {
    print('Print code is successfully sent with verification id $verificationId and token $token');

    add(AuthCodeSent(
      token: token,
      verificationId: verificationId,
    ));
  }

  void _onCodeAutoRetrievalTimeout(String verificationId) {
    print('Auto retrieval has timed out for verification ID $verificationId');
    add(AuthCodeAutoRetrevalTimeout(verificationId));
  }
}
