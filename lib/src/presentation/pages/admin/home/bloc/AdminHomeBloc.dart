import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:store_app/src/presentation/pages/admin/home/bloc/AdminHmeState.dart';
import 'package:store_app/src/presentation/pages/admin/home/bloc/AdminHomeEvent.dart';

class AdminHomeBloc extends Bloc<AdminHomeEvent, AdminHomeState> {
  AuthUseCases authUseCases;

  AdminHomeBloc(this.authUseCases) : super(const AdminHomeState()) {
    on<AdminChangeDrawerPage>(_onAdminChangeDrawerPage);
    on<AdminLogout>(_onAdminLogout);
  }

  void _onAdminChangeDrawerPage(
    AdminChangeDrawerPage event,
    Emitter<AdminHomeState> emit,
  ) {
    emit(state.copyWith(pageIndex: event.pageIndex));
  }

  void _onAdminLogout(AdminLogout event, Emitter<AdminHomeState> emit) async {
    await authUseCases.logout.run();
  }
}
