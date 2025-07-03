import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/injection.dart';
import 'package:store_app/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:store_app/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:store_app/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:store_app/src/presentation/pages/auth/register/RegisterBlocCubit.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LoginBloc>(
    create: (context) =>
        LoginBloc(locator<AuthUseCases>())..add(LoginInitialEvent()),
  ),
  BlocProvider<RegisterBlocCubit>(
    create: (context) => RegisterBlocCubit(locator<AuthUseCases>()),
  ),
];
