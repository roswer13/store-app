import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:store_app/src/domain/models/Category.dart';
import 'package:store_app/src/domain/utils/Resource.dart';
import 'package:store_app/src/presentation/utils/BlocFormItem.dart';

class AdminCategoryCreateState extends Equatable {
  final BlocFormItem name;
  final BlocFormItem description;
  final File? file;
  final GlobalKey<FormState>? formKey;
  final Resource? response;

  const AdminCategoryCreateState({
    this.name = const BlocFormItem(error: "Name is required"),
    this.description = const BlocFormItem(error: "Description is required"),
    this.file,
    this.formKey,
    this.response,
  });

  toCategory() => Category(name: name.value, description: description.value);

  AdminCategoryCreateState resetForm() {
    return AdminCategoryCreateState(
      name: const BlocFormItem(error: "Name is required"),
      description: const BlocFormItem(error: "Description is required"),
    );
  }

  AdminCategoryCreateState copyWith({
    BlocFormItem? name,
    BlocFormItem? description,
    File? file,
    GlobalKey<FormState>? formKey,
    Resource? response,
  }) {
    return AdminCategoryCreateState(
      name: name ?? this.name,
      description: description ?? this.description,
      file: file ?? this.file,
      formKey: formKey ?? this.formKey,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [name, description, file, response];
}
