import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:store_app/src/domain/useCases/categories/CategoriesUseCases.dart';
import 'package:store_app/src/domain/utils/Resource.dart';
import 'package:store_app/src/presentation/pages/admin/category/create/bloc/AdminCategoryCreateEvent.dart';
import 'package:store_app/src/presentation/pages/admin/category/create/bloc/AdminCategoryCreateState.dart';
import 'package:store_app/src/presentation/utils/BlocFormItem.dart';

class AdminCategoryCreateBloc
    extends Bloc<AdminCategoryCreateEvent, AdminCategoryCreateState> {
  CategoriesUseCases categoriesUseCases;
  final formKey = GlobalKey<FormState>();

  AdminCategoryCreateBloc(this.categoriesUseCases)
    : super(const AdminCategoryCreateState()) {
    on<AdminCategoryCreateInitEvent>(_onInit);
    on<AdminCategoryCreateNameChanged>(_onNameChanged);
    on<AdminCategoryCreateDescriptionChanged>(_onDescriptionChanged);
    on<AdminCategoryCreateFormSubmitted>(_onFormSubmitted);
    on<AdminCategoryCreateResetForm>(_onResetForm);
    on<AdminCategoryCreatePickImage>(_onPickImage);
    on<AdminCategoryCreateTakePhoto>(_onTakePhoto);
  }

  Future<void> _onInit(
    AdminCategoryCreateInitEvent event,
    Emitter<AdminCategoryCreateState> emit,
  ) async {
    emit(state.copyWith(formKey: formKey));
  }

  Future<void> _onNameChanged(
    AdminCategoryCreateNameChanged event,
    Emitter<AdminCategoryCreateState> emit,
  ) async {
    emit(
      state.copyWith(
        name: BlocFormItem(
          value: event.name.value,
          error: event.name.value.isEmpty ? "Name is required" : null,
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onDescriptionChanged(
    AdminCategoryCreateDescriptionChanged event,
    Emitter<AdminCategoryCreateState> emit,
  ) async {
    emit(
      state.copyWith(
        description: BlocFormItem(
          value: event.description.value,
          error: event.description.value.isEmpty
              ? "Description is required"
              : null,
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onFormSubmitted(
    AdminCategoryCreateFormSubmitted event,
    Emitter<AdminCategoryCreateState> emit,
  ) async {
    emit(state.copyWith(response: Loading(), formKey: formKey));

    Resource response = await categoriesUseCases.create.run(
      state.toCategory(),
      state.file!,
    );

    emit(state.copyWith(response: response, formKey: formKey));
  }

  Future<void> _onResetForm(
    AdminCategoryCreateResetForm event,
    Emitter<AdminCategoryCreateState> emit,
  ) async {
    //state.formKey?.currentState?.reset();
    emit(state.resetForm());
  }

  Future<void> _onPickImage(
    AdminCategoryCreatePickImage event,
    Emitter<AdminCategoryCreateState> emit,
  ) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (image != null) {
      emit(state.copyWith(file: File(image.path), formKey: formKey));
    }
  }

  Future<void> _onTakePhoto(
    AdminCategoryCreateTakePhoto event,
    Emitter<AdminCategoryCreateState> emit,
  ) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    if (image != null) {
      emit(state.copyWith(file: File(image.path), formKey: formKey));
    }
  }
}
