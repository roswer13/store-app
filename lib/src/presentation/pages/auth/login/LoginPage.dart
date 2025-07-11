import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store_app/src/domain/models/AuthResponse.dart';
import 'package:store_app/src/domain/utils/Resource.dart';

import 'package:store_app/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:store_app/src/presentation/pages/auth/login/LoginContent.dart';
import 'package:store_app/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:store_app/src/presentation/pages/auth/login/bloc/LoginState.dart';

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
    _bloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            final responseState = state.response;

            if (responseState is Error) {
              // Show an error message if login fails
              Fluttertoast.showToast(
                msg: responseState.message,
                toastLength: Toast.LENGTH_LONG,
              );
            } else if (responseState is Success) {
              _bloc?.add(
                LoginSaveUserSession(
                  response: responseState.data as AuthResponse,
                ),
              );
              //_bloc?.add(LoginFormReset());
              // Navigate to the home page on successful login
              Fluttertoast.showToast(
                msg: 'Login successful',
                toastLength: Toast.LENGTH_LONG,
              );
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  'roles',
                  (route) => false,
                );
              });
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state.response is Loading) {
                return Stack(
                  children: [
                    LoginContent(_bloc, state),
                    Center(child: CircularProgressIndicator()),
                  ],
                );
              }
              return LoginContent(_bloc, state);
            },
          ),
        ),
      ),
    );
  }
}
