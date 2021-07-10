import 'package:Realify/backend/models/phone_euth_model.dart';
import 'package:Realify/backend/services/authentication_api_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthRepository {
  AuthenticationApiProvider _authFirebaseProvider = AuthenticationApiProvider();

  Future<void> verifyPhoneNumber({
    @required String phoneNumber,
    @required onVerificationCompleted,
    @required onVerificaitonFailed,
    @required onCodeSent,
    @required onCodeAutoRetrievalTimeOut,
  }) async {
    await _authFirebaseProvider.verifyPhoneNumber(
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
    final User user = await _authFirebaseProvider.loginWithSMSVerificationCode(
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
    User user = await _authFirebaseProvider.authenticationWithCredential(
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

  addUserToFirebase(String name, String phone, String role) {
    _authFirebaseProvider.addUserToFirestore(name, phone, role);
  }
}
