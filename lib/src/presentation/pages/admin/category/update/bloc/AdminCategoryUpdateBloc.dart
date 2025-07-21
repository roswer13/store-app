import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:store_app/src/domain/useCases/categories/CategoriesUseCases.dart';
import 'package:store_app/src/domain/utils/Resource.dart';
import 'package:store_app/src/presentation/pages/admin/category/update/bloc/AdminCategoryUpdateEvent.dart';
import 'package:store_app/src/presentation/pages/admin/category/update/bloc/AdminCategoryUpdateState.dart';
import 'package:store_app/src/presentation/utils/BlocFormItem.dart';

class AdminCategoryUpdateBloc
    extends Bloc<AdminCategoryUpdateEvent, AdminCategoryUpdateState> {
  CategoriesUseCases categoriesUseCases;
  final formKey = GlobalKey<FormState>();

  AdminCategoryUpdateBloc(this.categoriesUseCases)
    : super(const AdminCategoryUpdateState()) {
    on<AdminCategoryUpdateInitEvent>(_onInit);
    on<AdminCategoryUpdateNameChanged>(_onNameChanged);
    on<AdminCategoryUpdateDescriptionChanged>(_onDescriptionChanged);
    on<AdminCategoryUpdateFormSubmitted>(_onFormSubmitted);
    on<AdminCategoryUpdatePickImage>(_onPickImage);
    on<AdminCategoryUpdateTakePhoto>(_onTakePhoto);
    on<AdminCategoryUpdateResetForm>(_onResetForm);
  }

  Future<void> _onInit(
    AdminCategoryUpdateInitEvent event,
    Emitter<AdminCategoryUpdateState> emit,
  ) async {
    emit(
      state.copyWith(
        id: event.category?.id,
        name: BlocFormItem(value: event.category?.name ?? ''),
        description: BlocFormItem(value: event.category?.description ?? ''),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onNameChanged(
    AdminCategoryUpdateNameChanged event,
    Emitter<AdminCategoryUpdateState> emit,
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
    AdminCategoryUpdateDescriptionChanged event,
    Emitter<AdminCategoryUpdateState> emit,
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
    AdminCategoryUpdateFormSubmitted event,
    Emitter<AdminCategoryUpdateState> emit,
  ) async {
    emit(state.copyWith(response: Loading(), formKey: formKey));

    Resource response = await categoriesUseCases.update.run(
      state.id,
      state.toCategory(),
      state.file,
    );

    emit(state.copyWith(response: response, formKey: formKey));
  }

  Future<void> _onResetForm(
    AdminCategoryUpdateResetForm event,
    Emitter<AdminCategoryUpdateState> emit,
  ) async {
    emit(state.resetForm());
  }

  Future<void> _onPickImage(
    AdminCategoryUpdatePickImage event,
    Emitter<AdminCategoryUpdateState> emit,
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
    AdminCategoryUpdateTakePhoto event,
    Emitter<AdminCategoryUpdateState> emit,
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
