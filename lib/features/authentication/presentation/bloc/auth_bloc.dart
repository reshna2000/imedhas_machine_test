import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:order_management_app/core/enums.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<UserLoginEvent>(_userLogin);
  }

  FutureOr<void> _userLogin(
      UserLoginEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: event.emailId,
        password: event.password,
      );

      emit(state.copyWith(authStatus: AuthStatus.success));
    } on FirebaseAuthException catch (e, st) {
      print("🔥 FirebaseAuthException: ${e.code} - ${e.message}");
      print("📌 StackTrace: $st");

      String message;
      switch (e.code) {
        case "invalid-email":
          message = "Invalid email format";
          break;
        case "user-not-found":
          message = "No user found with this email";
          break;
        case "wrong-password":
          message = "Incorrect password";
          break;
        case "user-disabled":
          message = "This user account is disabled";
          break;
        case "network-request-failed":
          message = "Check your internet connection";
          break;
        case "too-many-requests":
          message = "Too many attempts, try again later";
          break;
        case "invalid-credential":
          message = "Invalid login credentials";
          break;
        case "captcha-check-failed":
          message = "Security check failed, try again";
          break;
        default:
          message = e.message ?? "Login failed";
      }

      emit(state.copyWith(
        authStatus: AuthStatus.error,
        errorMessage: message,
      ));
    } catch (e, st) {
      print("🔥 Unexpected error: $e");
      print("📌 StackTrace: $st");

      emit(state.copyWith(
        authStatus: AuthStatus.error,
        errorMessage: "Unexpected error: ${e.toString()}",
      ));
    }
  }

}
