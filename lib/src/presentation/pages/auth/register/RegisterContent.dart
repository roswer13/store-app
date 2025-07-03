import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:store_app/src/presentation/pages/auth/register/RegisterBlocCubit.dart';
import 'package:store_app/src/presentation/widgets/DefaultButton.dart';
import 'package:store_app/src/presentation/widgets/DefaultIconBack.dart';
import 'package:store_app/src/presentation/widgets/DefaultTextField.dart';

class RegisterContent extends StatelessWidget {
  RegisterBlocCubit? bloc;

  RegisterContent(this.bloc);

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

        DefaultIconBack(left: 20, top: 30),

        Container(
          height: MediaQuery.of(context).size.height * 0.62,
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.3),
            borderRadius: BorderRadius.circular(25),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Icon(Icons.person, size: 125, color: Colors.white),
                Text(
                  'Registro',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: StreamBuilder(
                    stream: bloc?.nameStream,
                    builder: (context, asyncSnapshot) {
                      return DefaultTextfield(
                        label: 'Nombre',
                        errorText: asyncSnapshot.error?.toString(),
                        icon: Icons.person,
                        onChanged: (text) {
                          bloc?.setName(text);
                        },
                      );
                    },
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: StreamBuilder(
                    stream: bloc?.lastnameStream,
                    builder: (context, asyncSnapshot) {
                      return DefaultTextfield(
                        label: 'Apellido',
                        errorText: asyncSnapshot.error?.toString(),
                        icon: Icons.person,
                        onChanged: (text) {
                          bloc?.setLastname(text);
                        },
                      );
                    },
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: StreamBuilder(
                    stream: bloc?.emailStream,
                    builder: (context, asyncSnapshot) {
                      return DefaultTextfield(
                        label: 'Email',
                        errorText: asyncSnapshot.error?.toString(),
                        icon: Icons.email,
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
                    stream: bloc?.phoneStream,
                    builder: (context, asyncSnapshot) {
                      return DefaultTextfield(
                        label: 'Teléfono',
                        errorText: asyncSnapshot.error?.toString(),
                        icon: Icons.phone,
                        onChanged: (text) {
                          bloc?.setPhone(text);
                        },
                      );
                    },
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: StreamBuilder(
                    stream: bloc?.passwordStream,
                    builder: (context, asyncSnapshot) {
                      return DefaultTextfield(
                        label: 'Contraseña',
                        errorText: asyncSnapshot.error?.toString(),
                        icon: Icons.lock,
                        onChanged: (text) {
                          bloc?.setPassword(text);
                        },
                      );
                    },
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: StreamBuilder(
                    stream: bloc?.confirmPasswordStream,
                    builder: (context, asyncSnapshot) {
                      return DefaultTextfield(
                        label: 'Confirmar Contraseña',
                        errorText: asyncSnapshot.error?.toString(),
                        icon: Icons.lock_outline,
                        onChanged: (text) {
                          bloc?.setConfirmPassword(text);
                        },
                      );
                    },
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: StreamBuilder(
                    stream: bloc?.isFormValid,
                    builder: (context, asyncSnapshot) {
                      return DefaultButton(
                        label: 'Registrarse',
                        color: asyncSnapshot.hasData && asyncSnapshot.data!
                            ? Colors.black
                            : Colors.grey,
                        onPressed: () {
                          if (asyncSnapshot.hasData && asyncSnapshot.data!) {
                            bloc?.register();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Por favor, complete todos los campos correctamente.',
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
