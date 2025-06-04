import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/src/presentation/pages/auth/login/LoginBlocCubit.dart';
import 'package:store_app/src/presentation/pages/auth/register/RegisterBlocCubit.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LoginBlocCubit>(create: (context) => LoginBlocCubit()),
  BlocProvider<RegisterBlocCubit>(create: (context) => RegisterBlocCubit()),
];
