import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/src/domain/models/AuthResponse.dart';
import 'package:store_app/src/domain/useCases/auth/AuthUseCases.dart';

import 'package:store_app/src/presentation/pages/roles/bloc/RolesEvent.dart';
import 'package:store_app/src/presentation/pages/roles/bloc/RolesState.dart';

class RolesBloc extends Bloc<RolesEvent, RolesState> {
  AuthUseCases authUseCases;

  RolesBloc(this.authUseCases) : super(RolesState()) {
    on<GetRolesList>(_onGetRolesList);
  }

  Future<void> _onGetRolesList(
    GetRolesList event,
    Emitter<RolesState> emit,
  ) async {
    AuthResponse? authResponse = await authUseCases.getUserSession.run();
    emit(state.copyWith(roles: authResponse?.user.roles));
  }
}
