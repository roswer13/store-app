import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/injection.dart';

import 'package:store_app/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:store_app/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:store_app/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:store_app/src/presentation/pages/auth/register/bloc/RegisterBloc.dart';
import 'package:store_app/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';
import 'package:store_app/src/presentation/pages/roles/bloc/RolesBloc.dart';
import 'package:store_app/src/presentation/pages/roles/bloc/RolesEvent.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LoginBloc>(
    create: (context) =>
        LoginBloc(locator<AuthUseCases>())..add(LoginInitialEvent()),
  ),
  BlocProvider<RegisterBloc>(
    create: (context) =>
        RegisterBloc(locator<AuthUseCases>())..add(RegisterInitialEvent()),
  ),
  BlocProvider<RolesBloc>(
    create: (context) =>
        RolesBloc(locator<AuthUseCases>())..add(GetRolesList()),
  ),
];
