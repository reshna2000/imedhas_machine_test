part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class UserLoginEvent extends AuthEvent {
  final String emailId;
  final String password;

  const UserLoginEvent({required this.emailId, required this.password});

  @override
  List<Object?> get props => [emailId, password];
}
