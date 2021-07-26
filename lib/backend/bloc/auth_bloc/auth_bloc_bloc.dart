import 'dart:async';

import 'package:Realify/backend/repositories/auth_repository.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:Realify/presentation/widget/progress_dialog/main.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthBlocState> mapEventToState(AuthBlocEvent event) async* {
    if (event is SigninWithGoogleEvent) {
      yield* _mapSignIntoGoogleAccount(event, event.context);
    } else if (event is AddUserToFirestoreEvent) {
      yield* _mapAddUserToFirestore(event);
    } else if (event is SignoutOfGoogleEvent) {
      yield* _mapSignOuOfGoogleEvent(event);
    }
  }
}

Stream<AuthBlocState> _mapSignIntoGoogleAccount(SigninWithGoogleEvent event, BuildContext context) async* {
  AuthRepository _authRepository = AuthRepository();
  showMyDialogBox(context, "Signing in");
  var documents = await _authRepository.signInAndGetUser();
  if (documents.length > 0) {
    yield UserRegisteredState();
    Navigator.of(context).pop();
  } else if (documents.length <= 0 || documents.length == null) {
    yield UserNotRegisteredState();
    Navigator.of(context).pop();
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
