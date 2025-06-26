import 'package:flutter/material.dart';
import 'package:store_app/src/domain/utils/Resource.dart';
import 'package:store_app/src/presentation/pages/auth/login/LoginBlocCubit.dart';

class LoginResponse extends StatelessWidget {
  final LoginBlocCubit? bloc;

  LoginResponse(this.bloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc?.responseStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state is Loading) {
          // Show a loading indicator while logging in
          return Center(child: CircularProgressIndicator());
        } else if (state is Error) {
          // Show an error message if login fails
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          });
        } else if (state is Success) {
          // Navigate to the home page on successful login
          WidgetsBinding.instance.addPostFrameCallback((_) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Login exitoso")));
            });
          });
        }
        return Container(); // Return an empty container while waiting for the stream.
      },
    );
  }
}
