import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:store_app/src/presentation/pages/profile/update/bloc/ProfileUpdateEvent.dart';
import 'package:store_app/src/presentation/pages/profile/update/bloc/ProfileUpdateState.dart';
import 'package:store_app/src/presentation/utils/BlocFormItem.dart';

class ProfileUpdateBloc extends Bloc<ProfileUpdateEvent, ProfileUpdateState> {
  final formKey = GlobalKey<FormState>();

  ProfileUpdateBloc() : super(ProfileUpdateState()) {
    on<ProfileUpdateInitEvent>(_onProfileUpdateInitEvent);
    on<ProfileUpdateChangeName>(_onProfileUpdateChangeName);
    on<ProfileUpdateChangeLastname>(_onProfileUpdateChangeLastname);
    on<ProfileUpdateChangePhone>(_onProfileUpdateChangePhone);
    on<ProfileUpdateFormSubmit>(_onProfileUpdateFormSubmit);
    on<ProfileUpdatePickImage>(_onProfileUpdatePickImage);
    on<ProfileUpdateTakePhoto>(_onProfileUpdateTakePhoto);
  }

  Future<void> _onProfileUpdateInitEvent(
    ProfileUpdateInitEvent event,
    Emitter<ProfileUpdateState> emit,
  ) async {
    emit(state.copyWith(formKey: formKey));
  }

  Future<void> _onProfileUpdateChangeName(
    ProfileUpdateChangeName event,
    Emitter<ProfileUpdateState> emit,
  ) async {
    emit(
      state.copyWith(
        name: BlocFormItem(value: event.name.value, error: event.name.error),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onProfileUpdateChangeLastname(
    ProfileUpdateChangeLastname event,
    Emitter<ProfileUpdateState> emit,
  ) async {
    emit(
      state.copyWith(
        lastname: BlocFormItem(
          value: event.lastname.value,
          error: event.lastname.error,
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onProfileUpdateChangePhone(
    ProfileUpdateChangePhone event,
    Emitter<ProfileUpdateState> emit,
  ) async {
    emit(
      state.copyWith(
        phone: BlocFormItem(value: event.phone.value, error: event.phone.error),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onProfileUpdateFormSubmit(
    ProfileUpdateFormSubmit event,
    Emitter<ProfileUpdateState> emit,
  ) async {}

  Future<void> _onProfileUpdatePickImage(
    ProfileUpdatePickImage event,
    Emitter<ProfileUpdateState> emit,
  ) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (image != null) {
      emit(state.copyWith(image: File(image.path)));
    }
  }

  Future<void> _onProfileUpdateTakePhoto(
    ProfileUpdateTakePhoto event,
    Emitter<ProfileUpdateState> emit,
  ) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    if (image != null) {
      emit(state.copyWith(image: File(image.path)));
    }
  }
}
