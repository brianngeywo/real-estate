part of 'auth_bloc_bloc.dart';

abstract class AuthBlocEvent {
  const AuthBlocEvent();

}

class AuthNumberVerified extends AuthBlocEvent {
  final String phoneNumber;
  AuthNumberVerified({
    @required this.phoneNumber,
  });

  @override
  List<Object> get props => [phoneNumber];
}

class AuthCodeVerified extends AuthBlocEvent {
  final String verificationId;
  final String smsCode;
  AuthCodeVerified({
    @required this.verificationId,
    @required this.smsCode,
  });

  @override
  List<Object> get props => [smsCode];
}

class AuthCodeAutoRetrevalTimeout extends AuthBlocEvent {
  final String verificationId;
  AuthCodeAutoRetrevalTimeout(this.verificationId);
  @override
  List<Object> get props => [verificationId];
}

class AuthCodeSent extends AuthBlocEvent {
  final String verificationId;
  final int token;
  AuthCodeSent({
    @required this.verificationId,
    @required this.token,
  });

  @override
  List<Object> get props => [verificationId, token];
}

class AuthVerificationFailed extends AuthBlocEvent {
  final String message;

  AuthVerificationFailed(this.message);
  @override
  List<Object> get props => [message];
}

class AuthVerificationCompleted extends AuthBlocEvent {
  final String uid;
  AuthVerificationCompleted(this.uid);
  @override
  List<Object> get props => [uid];
}
