part of 'auth_bloc_bloc.dart';

@immutable
abstract class AuthBlocState {}

class AuthInitial extends AuthBlocState {}

class AuthLoading extends AuthBlocState {}

class AuthError extends AuthBlocState {}

class AuthNumberVerficationFailure extends AuthBlocState {
  final String message;
  AuthNumberVerficationFailure(this.message);
  @override
  List<Object> get props => [props];
}

class AuthNumberVerificationSuccess extends AuthBlocState {
  final String verificationId;
  AuthNumberVerificationSuccess({
    @required this.verificationId,
  });
  @override
  List<Object> get props => [verificationId];
}

class AuthCodeSentSuccess extends AuthBlocState {
  final String verificationId;
  AuthCodeSentSuccess({
    @required this.verificationId,
  });
  @override
  List<Object> get props => [verificationId];
}

class AuthCodeVerficationFailure extends AuthBlocState {
  final String message;
  final String verificationId;

  AuthCodeVerficationFailure(this.message, this.verificationId);

  @override
  List<Object> get props => [message];
}

class AuthCodeVerificationSuccess extends AuthBlocState {
  final String uid;

  AuthCodeVerificationSuccess({
    @required this.uid,
  });

  @override
  List<Object> get props => [uid];
}

class AuthCodeAutoRetrevalTimeoutComplete extends AuthBlocState {
  final String verificationId;

  AuthCodeAutoRetrevalTimeoutComplete(this.verificationId);
  @override
  List<Object> get props => [verificationId];
}
