import 'package:Realify/backend/models/phone_euth_model.dart';
import 'package:Realify/backend/services/authentication_api_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthRepository {
  final AuthenticationApiProvider _phoneAuthFirebaseProvider;
  AuthRepository({
    @required AuthenticationApiProvider phoneAuthFirebaseProvider,
  })  : assert(phoneAuthFirebaseProvider != null),
        _phoneAuthFirebaseProvider = phoneAuthFirebaseProvider;

  Future<void> verifyPhoneNumber({
    @required String phoneNumber,
    @required onVerificationCompleted,
    @required onVerificaitonFailed,
    @required onCodeSent,
    @required onCodeAutoRetrievalTimeOut,
  }) async {
    await _phoneAuthFirebaseProvider.verifyPhoneNumber(
        onCodeAutoRetrievalTimeOut: onCodeAutoRetrievalTimeOut,
        onCodeSent: onCodeSent,
        onVerificaitonFailed: onVerificaitonFailed,
        onVerificationCompleted: onVerificationCompleted,
        mobileNumber: phoneNumber);
  }

  Future<PhoneAuthModel> verifySMSCode({
    @required String smsCode,
    @required String verificationId,
  }) async {
    final User user = await _phoneAuthFirebaseProvider.loginWithSMSVerificationCode(
        verificationId: verificationId, smsVerficationcode: smsCode);
    if (user != null) {
      return PhoneAuthModel(
        phoneAuthModelState: PhoneAuthModelState.verified,
        uid: user.uid,
      );
    } else {
      return PhoneAuthModel(phoneAuthModelState: PhoneAuthModelState.error);
    }
  }

  Future<PhoneAuthModel> verifyWithCredential({
    @required AuthCredential credential,
  }) async {
    User user = await _phoneAuthFirebaseProvider.authenticationWithCredential(
      credential: credential,
    );
    if (user != null) {
      return PhoneAuthModel(
        phoneAuthModelState: PhoneAuthModelState.verified,
        uid: user.uid,
      );
    } else {
      return PhoneAuthModel(phoneAuthModelState: PhoneAuthModelState.error);
    }
  }
}
