import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthenticationApiProvider {
  final FirebaseAuth _firebaseAuth;
  AuthenticationApiProvider({
    FirebaseAuth firebaseAuth,
  })  : assert(firebaseAuth != null),
        _firebaseAuth = firebaseAuth;

  Future<void> verifyPhoneNumber({
    @required String mobileNumber,
    @required onVerificationCompleted,
    @required onVerificaitonFailed,
    @required onCodeSent,
    @required onCodeAutoRetrievalTimeOut,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: mobileNumber,
      verificationCompleted: onVerificationCompleted,
      verificationFailed: onVerificaitonFailed,
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeOut,
      timeout: Duration(seconds: 5),
    );
  }

  Future<User> loginWithSMSVerificationCode(
      {@required String verificationId, @required String smsVerficationcode}) async {
    final AuthCredential credential =
        _getAuthCredentialFromVerificationCode(verificationId: verificationId, verificationCode: smsVerficationcode);
    return await authenticationWithCredential(credential: credential);
  }

  Future<User> authenticationWithCredential({@required AuthCredential credential}) async {
    UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
    return userCredential.user;
  }

  AuthCredential _getAuthCredentialFromVerificationCode(
      {@required String verificationId, @required String verificationCode}) {
    return PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: verificationCode,
    );
  }

  Future<bool> checkUser() async {
    var box = await Hive.openBox('user');

    bool userPresent;
    if (box.isOpen) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          userPresent = true;
          return userPresent;
        } else {
          userPresent = false;
        }
      });
    }

    return userPresent;
  }

  addUserToFirestore(String name, String phone, String role) {
    var user = FirebaseAuth.instance.currentUser;
    var userid = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance.collection("users").doc(userid).set({
      "phone": phone,
      "user id": userid,
      "name": name,
      "role": role,
      "email": user.email,
    });
  }
}
