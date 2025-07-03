import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store_app/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:store_app/src/presentation/pages/auth/login/LoginContent.dart';
import 'package:store_app/src/presentation/pages/auth/login/LoginResponse.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc? _bloc;

  @override
  void initState() {
    super.initState();

    //WidgetsBinding.instance.addPostFrameCallback((_) {
    //  _bloc?.dispose();
    //});
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<LoginBloc>(context, listen: false);

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [LoginResponse(_bloc), LoginContent(_bloc)],
        ),
      ),
    );
  }
}
