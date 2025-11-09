import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:order_management_app/core/api_support.dart';
import 'package:order_management_app/core/dio_api_client.dart';
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
      final DioApiClient dioApiClient = DioApiClient();
      final payload = {"username": event.emailId, "password": event.password};

      final response = await dioApiClient.post(ApiSupport.login, data: payload);

      if (kDebugMode) {
        log(response.data.toString(), name: "authResponse");
        log(response.statusCode.toString(), name: "authStatusCode");
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(state.copyWith(authStatus: AuthStatus.success));
      } else {
        emit(
          state.copyWith(
            authStatus: AuthStatus.error,
            errorMessage: "Something went wrong",
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          authStatus: AuthStatus.error,
          errorMessage: e.toString(),
        ),
      );
    } finally {}
  }
}
