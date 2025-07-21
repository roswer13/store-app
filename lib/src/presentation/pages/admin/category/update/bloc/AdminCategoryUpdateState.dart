import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:store_app/src/domain/models/Category.dart';
import 'package:store_app/src/domain/utils/Resource.dart';
import 'package:store_app/src/presentation/utils/BlocFormItem.dart';

class AdminCategoryUpdateState extends Equatable {
  final int id;
  final BlocFormItem name;
  final BlocFormItem description;
  final File? file;
  final GlobalKey<FormState>? formKey;
  final Resource? response;

  const AdminCategoryUpdateState({
    this.id = 0,
    this.name = const BlocFormItem(error: "Name is required"),
    this.description = const BlocFormItem(error: "Description is required"),
    this.file,
    this.formKey,
    this.response,
  });

  toCategory() =>
      Category(id: id, name: name.value, description: description.value);

  AdminCategoryUpdateState copyWith({
    int? id,
    BlocFormItem? name,
    BlocFormItem? description,
    File? file,
    GlobalKey<FormState>? formKey,
    Resource? response,
  }) {
    return AdminCategoryUpdateState(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      file: file ?? this.file,
      formKey: formKey ?? this.formKey,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [id, name, description, file, response];
}
