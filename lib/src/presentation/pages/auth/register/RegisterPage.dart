import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/src/presentation/pages/auth/register/RegisterBlocCubit.dart';
import 'package:store_app/src/presentation/pages/auth/register/RegisterContent.dart';
import 'package:store_app/src/presentation/pages/auth/register/RegisterResponse.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterBlocCubit? _registerBlocCubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _registerBlocCubit?.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    _registerBlocCubit = BlocProvider.of<RegisterBlocCubit>(
      context,
      listen: false,
    );

    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              RegisterContent(_registerBlocCubit),
              RegisterResponse(_registerBlocCubit),
            ],
          ),
        ),
      ),
    );
  }
}
