import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/injection.dart';
import 'package:store_app/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:store_app/src/presentation/pages/auth/login/LoginBlocCubit.dart';
import 'package:store_app/src/presentation/pages/auth/register/RegisterBlocCubit.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LoginBlocCubit>(
    create: (context) => LoginBlocCubit(locator<AuthUseCases>()),
  ),
  BlocProvider<RegisterBlocCubit>(
    create: (context) => RegisterBlocCubit(locator<AuthUseCases>()),
  ),
];
