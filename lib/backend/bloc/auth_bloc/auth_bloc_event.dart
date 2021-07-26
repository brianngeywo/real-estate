part of 'auth_bloc_bloc.dart';

abstract class AuthBlocEvent {}

class SigninWithGoogleEvent extends AuthBlocEvent {
  BuildContext context;
  SigninWithGoogleEvent({
    @required this.context,
  });

}

class AddUserToFirestoreEvent extends AuthBlocEvent {
  final String name;
  final String phone;
  final String role;
  AddUserToFirestoreEvent({
    @required this.name,
    @required this.phone,
    @required this.role,
  });
}

class SignoutOfGoogleEvent extends AuthBlocEvent {}
