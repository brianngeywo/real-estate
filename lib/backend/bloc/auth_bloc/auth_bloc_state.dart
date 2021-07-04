part of 'auth_bloc_bloc.dart';

@immutable
abstract class AuthBlocState {}

class AuthInitial extends AuthBlocState {}

class AuthLoading extends AuthBlocState {}

class AuthErrorState extends AuthBlocState {}

class GoogleUserSignedInState extends AuthBlocState {
  final String userid;
  GoogleUserSignedInState({
    this.userid = '',
  });
}

class UserRegisteredState extends AuthBlocState {}

class UserNotRegisteredState extends AuthBlocState {}

class GoogleUserSignedOuState extends AuthBlocState {}
