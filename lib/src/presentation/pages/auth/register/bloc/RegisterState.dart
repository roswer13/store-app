import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:store_app/src/domain/models/User.dart';
import 'package:store_app/src/domain/utils/Resource.dart';
import 'package:store_app/src/presentation/utils/BlocFormItem.dart';

class RegisterState extends Equatable {
  final BlocFormItem name;
  final BlocFormItem lastname;
  final BlocFormItem email;
  final BlocFormItem phone;
  final BlocFormItem password;
  final BlocFormItem confirmPassword;
  final GlobalKey<FormState>? formKey;
  final Resource? response;

  const RegisterState({
    this.name = const BlocFormItem(error: 'Ingrese su nombre'),
    this.lastname = const BlocFormItem(error: 'Ingrese su apellido'),
    this.email = const BlocFormItem(error: 'Ingrese su correo electrónico'),
    this.phone = const BlocFormItem(error: 'Ingrese su número de teléfono'),
    this.password = const BlocFormItem(error: 'Ingrese su contraseña'),
    this.confirmPassword = const BlocFormItem(error: 'Confirme su contraseña'),
    this.formKey,
    this.response,
  });

  toUser() => User(
    name: name.value,
    lastname: lastname.value,
    email: email.value,
    phone: phone.value,
    password: password.value,
  );

  RegisterState copyWith({
    BlocFormItem? name,
    BlocFormItem? lastname,
    BlocFormItem? email,
    BlocFormItem? phone,
    BlocFormItem? password,
    BlocFormItem? confirmPassword,
    GlobalKey<FormState>? formKey,
    Resource? response,
  }) {
    return RegisterState(
      name: name ?? this.name,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      formKey: formKey ?? this.formKey,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [
    name,
    lastname,
    email,
    phone,
    password,
    confirmPassword,
    response,
  ];
}
