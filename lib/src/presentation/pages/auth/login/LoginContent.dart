import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store_app/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:store_app/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:store_app/src/presentation/pages/auth/login/bloc/LoginState.dart';
import 'package:store_app/src/presentation/utils/BlocFormItem.dart';
import 'package:store_app/src/presentation/widgets/DefaultTextField.dart';

class LoginContent extends StatelessWidget {
  LoginBloc? bloc;
  LoginState state;

  LoginContent(this.bloc, this.state);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _imageBackground(context),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.3),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.person, size: 125, color: Colors.white),
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                _textFieldEmail(context),
                _textFieldPassword(context),

                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 55,
                  margin: EdgeInsets.only(
                    left: 25,
                    right: 25,
                    top: 15,
                    bottom: 15,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (state.formKey!.currentState!.validate()) {
                        bloc?.add(LoginSubmitted());
                      } else {
                        Fluttertoast.showToast(
                          msg: 'El formulario no es válido',
                          toastLength: Toast.LENGTH_SHORT,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text(
                      'Iniciar sesión',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 65,
                      height: 1,
                      color: Colors.white,
                      margin: EdgeInsets.only(right: 5),
                    ),
                    Text(
                      '¿No tienes cuenta?',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    Container(
                      width: 65,
                      height: 1,
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 5),
                    ),
                  ],
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 55,
                  margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'register');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
                      'Regístrate aquí',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _textFieldEmail(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: DefaultTextfield(
        label: 'Correo electrónico',
        icon: Icons.email,
        //errorText: snapshot.error?.toString(),
        onChanged: (text) {
          bloc?.add(EmailChanged(email: BlocFormItem(value: text)));
        },
        validator: (value) {
          return state.email.error;
        },
      ),
    );
  }

  Widget _textFieldPassword(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: DefaultTextfield(
        label: 'Contraseña',
        icon: Icons.lock,
        obscureText: true,
        onChanged: (text) {
          bloc?.add(PasswordChanged(password: BlocFormItem(value: text)));
        },
        validator: (value) {
          return state.password.error;
        },
      ),
    );
  }

  Widget _imageBackground(BuildContext context) {
    return Image.asset(
      'assets/img/background1.jpg',
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      color: Colors.black54,
      colorBlendMode: BlendMode.darken,
    );
  }
}
