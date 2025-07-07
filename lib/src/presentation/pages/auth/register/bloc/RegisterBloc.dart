import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:store_app/src/domain/utils/Resource.dart';
import 'package:store_app/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';
import 'package:store_app/src/presentation/pages/auth/register/bloc/RegisterState.dart';
import 'package:store_app/src/presentation/utils/BlocFormItem.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  AuthUseCases authUseCases;

  RegisterBloc(this.authUseCases) : super(const RegisterState()) {
    on<RegisterInitialEvent>(_onRegisterInitialEvent);
    on<RegisterNameChanged>(_onNameChanged);
    on<RegisterLastnameChanged>(_onLastnameChanged);
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPhoneChanged>(_onPhoneChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<RegisterFormReset>(_onRegisterFormReset);
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onRegisterInitialEvent(
    RegisterInitialEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(formKey: formKey));
  }

  Future<void> _onNameChanged(
    RegisterNameChanged event,
    Emitter<RegisterState> emit,
  ) async {
    emit(
      state.copyWith(
        name: BlocFormItem(
          value: event.name.value,
          error: event.name.value.isNotEmpty ? null : 'Ingrese su nombre',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onLastnameChanged(
    RegisterLastnameChanged event,
    Emitter<RegisterState> emit,
  ) async {
    emit(
      state.copyWith(
        lastname: BlocFormItem(
          value: event.lastname.value,
          error: event.lastname.value.isNotEmpty ? null : 'Ingrese su apellido',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) async {
    emit(
      state.copyWith(
        email: BlocFormItem(
          value: event.email.value,
          error: event.email.value.isNotEmpty
              ? null
              : 'Ingrese su correo electrónico',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onPhoneChanged(
    RegisterPhoneChanged event,
    Emitter<RegisterState> emit,
  ) async {
    emit(
      state.copyWith(
        phone: BlocFormItem(
          value: event.phone.value,
          error: event.phone.value.isNotEmpty
              ? null
              : 'Ingrese su número de teléfono',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) async {
    emit(
      state.copyWith(
        password: BlocFormItem(
          value: event.password.value,
          error:
              event.password.value.isNotEmpty &&
                  event.password.value.length >= 6
              ? null
              : 'Ingrese su contraseña',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onConfirmPasswordChanged(
    RegisterConfirmPasswordChanged event,
    Emitter<RegisterState> emit,
  ) async {
    emit(
      state.copyWith(
        confirmPassword: BlocFormItem(
          value: event.confirmPassword.value,
          error:
              event.confirmPassword.value.isNotEmpty &&
                  event.confirmPassword.value == state.password.value
              ? null
              : 'Confirme su contraseña',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onRegisterFormReset(
    RegisterFormReset event,
    Emitter<RegisterState> emit,
  ) async {
    state.formKey?.currentState?.reset();
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(response: Loading(), formKey: formKey));

    Resource response = await authUseCases.register.run(state.toUser());
    emit(state.copyWith(response: response, formKey: formKey));
    print('Register successful: ${response}');
  }
}
