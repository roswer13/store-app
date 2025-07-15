import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:store_app/src/presentation/utils/BlocFormItem.dart';

class ProfileUpdateState extends Equatable {
  final BlocFormItem name;
  final BlocFormItem lastname;
  final BlocFormItem phone;
  final File? image;
  final GlobalKey<FormState>? formKey;

  const ProfileUpdateState({
    this.name = const BlocFormItem(error: 'El nombre es requerido'),
    this.lastname = const BlocFormItem(error: 'El apellido es requerido'),
    this.phone = const BlocFormItem(error: 'El teléfono es requerido'),
    this.image,
    this.formKey,
  });

  ProfileUpdateState copyWith({
    BlocFormItem? name,
    BlocFormItem? lastname,
    BlocFormItem? phone,
    File? image,
    GlobalKey<FormState>? formKey,
  }) {
    return ProfileUpdateState(
      name: name ?? this.name,
      lastname: lastname ?? this.lastname,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      formKey: formKey,
    );
  }

  @override
  List<Object?> get props => [name, lastname, phone, image];
}
