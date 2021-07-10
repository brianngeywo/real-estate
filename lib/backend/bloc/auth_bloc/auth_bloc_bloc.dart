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
  var auth = FirebaseAuth.instance;
  final CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
  GoogleSignInAccount user;
  User firebaseuser;
  @override
  Stream<AuthBlocState> mapEventToState(
    AuthBlocEvent event,
  ) async* {
    if (event is SigninWithGoogleEvent) {
      yield* _mapSignIntoGoogleAccount(event);
    }  else if (event is AddUserToFirestoreEvent) {
      yield* _mapAddUserToFirestore(event);
    } else if (event is SignoutOfGoogleEvent) {
      yield* _mapSignOuOfGoogleEvent(event);
    }
  }
}

Stream<AuthBlocState> _mapSignIntoGoogleAccount(SigninWithGoogleEvent event) async* {
  var box = await Hive.openBox('user');
  final googleSignin = GoogleSignIn();
  var auth = FirebaseAuth.instance;
  final CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
  GoogleSignInAccount user;
  User firebaseuser;
  final googleUser = await googleSignin.signIn();
  if (googleUser == null) return;
  user = googleUser;

  final googleAuth = await googleUser.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
    firebaseuser = FirebaseAuth.instance.currentUser;
    box.put("user id", firebaseuser.uid);
    box.put("user name", firebaseuser.displayName);
    box.put("user email", firebaseuser.email);
  });
  // var firestore = FirebaseFirestore.instance;

  final QuerySnapshot result =
      await FirebaseFirestore.instance.collection('users').where('id', isEqualTo: auth.currentUser.uid).get();
  final List<DocumentSnapshot> documents = result.docs;
  if (documents.length > 0) {
    // DocumentSnapshot documentSnapshot = await usersRef.doc(auth.currentUser.uid).get();
    yield UserRegisteredState();
  } else if (documents.length <= 0 || documents.length == null) {
    yield UserNotRegisteredState();
  }
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
