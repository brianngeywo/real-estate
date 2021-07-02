import 'dart:async';

import 'package:Realify/backend/models/phone_euth_model.dart';
import 'package:Realify/backend/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
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

    await FirebaseAuth.instance.signInWithCredential(credential);
    firebaseuser = FirebaseAuth.instance.currentUser;
    var box = await Hive.openBox('user');
    if (firebaseuser.uid != null) {
      box.put("user id", firebaseuser.uid);
      box.put("user name", firebaseuser.displayName);
      box.put("user email", firebaseuser.email);
    }
  }

  @override
  Stream<AuthBlocState> mapEventToState(
    AuthBlocEvent event,
  ) async* {
    if (event is SigninWithGoogleEvent) {
    var box = await Hive.openBox('user');

      googleSignIn().then((value) => null);
      if (box.get("user id") != null) {
        yield GoogleUserSignedInState(userid: box.get("user id"));
      } else if (box.get("user id") == null) {
        yield AuthErrorState();
      }
    }
  }
}
