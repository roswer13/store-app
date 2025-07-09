import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/src/domain/models/AuthResponse.dart';
import 'package:store_app/src/domain/useCases/auth/AuthUseCases.dart';

import 'package:store_app/src/domain/utils/Resource.dart';
import 'package:store_app/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:store_app/src/presentation/pages/auth/login/bloc/LoginState.dart';
import 'package:store_app/src/presentation/utils/BlocFormItem.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthUseCases authUseCases;

  LoginBloc(this.authUseCases) : super(LoginState()) {
    on<LoginInitialEvent>(_onLoginInitialEvent);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoginFormReset>(_onLoginFormReset);
    on<LoginSaveUserSession>(_onLoginSaveUserSession);
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onLoginInitialEvent(
    LoginInitialEvent event,
    Emitter<LoginState> emit,
  ) async {
    AuthResponse? authResponse = await authUseCases.getUserSession.run();
    print('User session retrieved: ${authResponse?.toJson()}');
    emit(state.copyWith(formKey: formKey));

    if (authResponse != null) {
      print('User session exists, navigating to roles page');
      emit(state.copyWith(response: Success(authResponse), formKey: formKey));
    }
  }

  Future<void> _onEmailChanged(
    EmailChanged event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(
        email: BlocFormItem(
          value: event.email.value,
          error: event.email.value.isNotEmpty ? null : 'Email cannot be empty',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onPasswordChanged(
    PasswordChanged event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(
        password: BlocFormItem(
          value: event.password.value,
          error:
              event.password.value.isNotEmpty &&
                  event.password.value.length >= 6
              ? null
              : 'Password cannot be empty',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(response: Loading(), formKey: formKey));

    print(
      'Submitting login with email: ${state.email.value} and password: ${state.password.value}',
    );
    Resource response = await authUseCases.login.run(
      state.email.value,
      state.password.value,
    );
    emit(state.copyWith(response: response, formKey: formKey));

    print('Login successful: ${response}');
  }

  Future<void> _onLoginFormReset(
    LoginFormReset event,
    Emitter<LoginState> emit,
  ) async {
    state.formKey?.currentState?.reset();
  }

  Future<void> _onLoginSaveUserSession(
    LoginSaveUserSession event,
    Emitter<LoginState> emit,
  ) async {
    await authUseCases.saveUserSession.run(event.response);
  }
}
