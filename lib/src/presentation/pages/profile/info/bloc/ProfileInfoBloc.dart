import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/src/domain/models/AuthResponse.dart';

import 'package:store_app/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:store_app/src/presentation/pages/profile/info/bloc/ProfileInfoEvent.dart';
import 'package:store_app/src/presentation/pages/profile/info/bloc/ProfileInfoState.dart';

class ProfileInfoBloc extends Bloc<ProfileInfoEvent, ProfileInfoState> {
  AuthUseCases authUseCases;

  ProfileInfoBloc({required this.authUseCases})
    : super(const ProfileInfoState()) {
    on<ProfileInfoGetUser>(_onProfileIngoGetUser);
  }

  Future<void> _onProfileIngoGetUser(
    ProfileInfoGetUser event,
    Emitter<ProfileInfoState> emit,
  ) async {
    AuthResponse? authResponse = await authUseCases.getUserSession.run();
    emit(state.copyWith(user: authResponse?.user));
  }
}
