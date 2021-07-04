import 'dart:async';

import 'package:Realify/backend/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBloc() : super(AuthInitial());
  final googleSignin = GoogleSignIn();

  GoogleSignInAccount user;
  User firebaseuser;

  Future googleSignIn() async {
    final googleUser = await googleSignin.signIn();
    if (googleUser == null) return;
    user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    var box = await Hive.openBox('user');

    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      var firestore = FirebaseFirestore.instance;
      firebaseuser = FirebaseAuth.instance.currentUser;
      box.put("user id", firebaseuser.uid);
      box.put("user name", firebaseuser.displayName);
      box.put("user email", firebaseuser.email);
      firestore.collection("users").doc(firebaseuser.uid).set({
        'name': firebaseuser.displayName,
        'phone': "",
        'role': "agent",
        'id': firebaseuser.uid,
        'email': firebaseuser.email,
      });
    });
  }

  @override
  Stream<AuthBlocState> mapEventToState(
    AuthBlocEvent event,
  ) async* {
    if (event is SigninWithGoogleEvent) {
      var box = await Hive.openBox('user');
      googleSignIn();
      yield GoogleUserSignedInState(userid: box.get("user id"));
    } else if (event is CheckUserInFirestoreEvent) {
      yield* _mapCheckUserInFirestore(event);
    } else if (event is AddUserToFirestoreEvent) {
      yield* _mapAddUserToFirestore(event);
    } else if (event is SignoutOfGoogleEvent) {
      yield* _mapSignOuOfGoogleEvent(event);
    }
  }
}

Stream<AuthBlocState> _mapCheckUserInFirestore(CheckUserInFirestoreEvent event) async* {
  bool userPresent;
  AuthRepository _authRepository = AuthRepository();

  await _authRepository.checkUser().then((value) {
    userPresent = value;
    return userPresent;
  });
  yield userPresent ? UserRegisteredState() : UserNotRegisteredState();
}

Stream<AuthBlocState> _mapAddUserToFirestore(AddUserToFirestoreEvent event) async* {
  AuthRepository _authRepository = AuthRepository();

  await _authRepository.addUserToFirebase(event.name, event.phone, event.role);
  yield UserRegisteredState();
}

Stream<AuthBlocState> _mapSignOuOfGoogleEvent(SignoutOfGoogleEvent event) async* {
  var box = await Hive.openBox('user');
  await FirebaseAuth.instance.signOut();
  await box.close();
  yield GoogleUserSignedOuState();
}
