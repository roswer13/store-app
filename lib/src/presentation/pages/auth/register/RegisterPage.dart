import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store_app/src/domain/utils/Resource.dart';
import 'package:store_app/src/presentation/pages/auth/register/RegisterContent.dart';
import 'package:store_app/src/presentation/pages/auth/register/bloc/RegisterBloc.dart';
import 'package:store_app/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';
import 'package:store_app/src/presentation/pages/auth/register/bloc/RegisterState.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterBloc? _bloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<RegisterBloc>(context);

    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: BlocListener<RegisterBloc, RegisterState>(
            bloc: _bloc,
            listener: (context, state) {
              final responseState = state.response;

              if (responseState is Error) {
                // Show an error message if registration fails
                Fluttertoast.showToast(
                  msg: responseState.message,
                  toastLength: Toast.LENGTH_LONG,
                );
              } else if (responseState is Success) {
                _bloc?.add(RegisterFormReset());
                // Navigate to the home page on successful registration
                Fluttertoast.showToast(
                  msg: 'Register successful',
                  toastLength: Toast.LENGTH_LONG,
                );
              }
            },
            child: BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, state) {
                return RegisterContent(_bloc, state);
              },
            ),
          ),
        ),
      ),
    );
  }
}
