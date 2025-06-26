import 'package:flutter/material.dart';
import 'package:store_app/src/presentation/pages/auth/login/LoginBlocCubit.dart';
import 'package:store_app/src/presentation/widgets/DefaultTextField.dart';

class LoginContent extends StatelessWidget {
  LoginBlocCubit? bloc;

  LoginContent(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/img/background1.jpg',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          color: Colors.black54,
          colorBlendMode: BlendMode.darken,
        ),
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: StreamBuilder(
                  stream: bloc?.emailStream,
                  builder: (context, snapshot) {
                    return DefaultTextfield(
                      label: 'Correo electrónico',
                      icon: Icons.email,
                      errorText: snapshot.error?.toString(),
                      onChanged: (text) {
                        bloc?.setEmail(text);
                      },
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: StreamBuilder(
                  stream: bloc?.passwordStream,
                  builder: (context, snapshot) {
                    return DefaultTextfield(
                      label: 'Contraseña',
                      icon: Icons.lock,
                      errorText: snapshot.error?.toString(),
                      obscureText: true,
                      onChanged: (text) {
                        bloc?.setPassword(text);
                      },
                    );
                  },
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 55,
                margin: EdgeInsets.only(
                  left: 25,
                  right: 25,
                  top: 15,
                  bottom: 15,
                ),
                child: StreamBuilder(
                  stream: bloc?.isFormValid,
                  builder: (context, asyncSnapshot) {
                    return ElevatedButton(
                      onPressed: () {
                        if (asyncSnapshot.hasData && asyncSnapshot.data!) {
                          // If the form is valid, proceed with login
                          bloc?.login();
                        } else {
                          // Show an error message or handle invalid form state
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Por favor, completa todos los campos correctamente.',
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            asyncSnapshot.hasData && asyncSnapshot.data!
                            ? Colors.green
                            : Colors.grey,
                      ),
                      child: Text(
                        'Iniciar sesión',
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  },
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
    );
  }
}
