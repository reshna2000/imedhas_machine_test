part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final String? errorMessage;
  const AuthState({this.authStatus = AuthStatus.initial, this.errorMessage});

  @override
  List<Object?> get props => [authStatus, errorMessage];

  AuthState copyWith({AuthStatus? authStatus, String? errorMessage}) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
