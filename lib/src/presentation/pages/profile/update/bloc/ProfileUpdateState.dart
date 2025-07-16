import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:store_app/src/domain/models/User.dart';

import 'package:store_app/src/presentation/utils/BlocFormItem.dart';
import 'package:store_app/src/domain/utils/Resource.dart';

class ProfileUpdateState extends Equatable {
  final int id;
  final BlocFormItem name;
  final BlocFormItem lastname;
  final BlocFormItem phone;
  final File? image;
  final String? imageUrl;
  final GlobalKey<FormState>? formKey;
  final Resource? response;

  const ProfileUpdateState({
    this.id = 0,
    this.name = const BlocFormItem(error: 'El nombre es requerido'),
    this.lastname = const BlocFormItem(error: 'El apellido es requerido'),
    this.phone = const BlocFormItem(error: 'El teléfono es requerido'),
    this.image,
    this.imageUrl,
    this.formKey,
    this.response,
  });

  toUser() => User(
    id: id,
    name: name.value,
    lastname: lastname.value,
    phone: phone.value,
  );

  ProfileUpdateState copyWith({
    int? id,
    BlocFormItem? name,
    BlocFormItem? lastname,
    BlocFormItem? phone,
    File? image,
    String? imageUrl,
    GlobalKey<FormState>? formKey,
    Resource? response,
  }) {
    return ProfileUpdateState(
      id: id ?? this.id,
      name: name ?? this.name,
      lastname: lastname ?? this.lastname,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      imageUrl: imageUrl ?? this.imageUrl,
      formKey: formKey,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    lastname,
    phone,
    image,
    response,
    imageUrl,
  ];
}
