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
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onLoginInitialEvent(
    LoginInitialEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(formKey: formKey));
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

    Resource response = await authUseCases.login.run(
      state.email.value,
      state.password.value,
    );
    emit(state.copyWith(response: response, formKey: formKey));
    /*
    Future.delayed(const Duration(seconds: 1), () {
      emit(state.copyWith(response: Initial()));
    });
    */
    print('Login successful: ${response}');
  }

  Future<void> _onLoginFormReset(
    LoginFormReset event,
    Emitter<LoginState> emit,
  ) async {
    state.formKey?.currentState?.reset();
  }
}
