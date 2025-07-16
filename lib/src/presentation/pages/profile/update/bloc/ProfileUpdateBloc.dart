import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_app/src/domain/models/AuthResponse.dart';
import 'package:store_app/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:store_app/src/domain/useCases/users/UsersUseCases.dart';
import 'package:store_app/src/domain/utils/Resource.dart';

import 'package:store_app/src/presentation/pages/profile/update/bloc/ProfileUpdateEvent.dart';
import 'package:store_app/src/presentation/pages/profile/update/bloc/ProfileUpdateState.dart';
import 'package:store_app/src/presentation/utils/BlocFormItem.dart';

class ProfileUpdateBloc extends Bloc<ProfileUpdateEvent, ProfileUpdateState> {
  UsersUseCases usersUseCases;
  AuthUseCases authUseCases;

  final formKey = GlobalKey<FormState>();

  ProfileUpdateBloc(this.usersUseCases, this.authUseCases)
    : super(ProfileUpdateState()) {
    on<ProfileUpdateInitEvent>(_onProfileUpdateInitEvent);
    on<ProfileUpdateChangeName>(_onProfileUpdateChangeName);
    on<ProfileUpdateChangeLastname>(_onProfileUpdateChangeLastname);
    on<ProfileUpdateChangePhone>(_onProfileUpdateChangePhone);
    on<ProfileUpdateFormSubmit>(_onProfileUpdateFormSubmit);
    on<ProfileUpdatePickImage>(_onProfileUpdatePickImage);
    on<ProfileUpdateTakePhoto>(_onProfileUpdateTakePhoto);
    on<ProfileUpdateUpdateUserSession>(_onProfileUpdateUpdateUserSession);
  }

  Future<void> _onProfileUpdateInitEvent(
    ProfileUpdateInitEvent event,
    Emitter<ProfileUpdateState> emit,
  ) async {
    emit(
      state.copyWith(
        id: event.user?.id,
        name: BlocFormItem(value: event.user?.name ?? ''),
        lastname: BlocFormItem(value: event.user?.lastname ?? ''),
        phone: BlocFormItem(value: event.user?.phone ?? ''),
        imageUrl: event.user?.image,
        formKey: formKey,
      ),
    );
  }

  Future<void> _onProfileUpdateUpdateUserSession(
    ProfileUpdateUpdateUserSession event,
    Emitter<ProfileUpdateState> emit,
  ) async {
    AuthResponse? authResponse = await authUseCases.getUserSession.run();

    if (authResponse == null) return;

    authResponse.user.name = event.user.name;
    authResponse.user.lastname = event.user.lastname;
    authResponse.user.phone = event.user.phone;
    authResponse.user.image = event.user.image;

    await authUseCases.saveUserSession.run(authResponse);
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
  ) async {
    emit(state.copyWith(response: Loading(), formKey: formKey));

    Resource response = await usersUseCases.updateUserUseCase.run(
      state.id,
      state.toUser(),
      state.image,
    );

    emit(state.copyWith(response: response, formKey: formKey));
  }

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
      emit(state.copyWith(image: File(image.path), formKey: formKey));
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
      emit(state.copyWith(image: File(image.path), formKey: formKey));
    }
  }
}
