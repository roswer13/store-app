import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:store_app/src/presentation/pages/auth/register/bloc/RegisterBloc.dart';
import 'package:store_app/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';
import 'package:store_app/src/presentation/pages/auth/register/bloc/RegisterState.dart';
import 'package:store_app/src/presentation/utils/BlocFormItem.dart';
import 'package:store_app/src/presentation/widgets/DefaultButton.dart';
import 'package:store_app/src/presentation/widgets/DefaultIconBack.dart';
import 'package:store_app/src/presentation/widgets/DefaultTextField.dart';

class RegisterContent extends StatelessWidget {
  RegisterBloc? bloc;
  RegisterState state;

  RegisterContent(this.bloc, this.state);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Stack(
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
                    child: DefaultTextfield(
                      label: 'Nombre',
                      icon: Icons.person,
                      onChanged: (text) {
                        bloc?.add(
                          RegisterNameChanged(name: BlocFormItem(value: text)),
                        );
                      },
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: DefaultTextfield(
                      label: 'Apellido',
                      icon: Icons.person,
                      onChanged: (text) {
                        bloc?.add(
                          RegisterLastnameChanged(
                            lastname: BlocFormItem(value: text),
                          ),
                        );
                      },
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: DefaultTextfield(
                      label: 'Email',
                      icon: Icons.email,
                      onChanged: (text) {
                        bloc?.add(
                          RegisterEmailChanged(
                            email: BlocFormItem(value: text),
                          ),
                        );
                      },
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: DefaultTextfield(
                      label: 'Teléfono',
                      icon: Icons.phone,
                      onChanged: (text) {
                        bloc?.add(
                          RegisterPhoneChanged(
                            phone: BlocFormItem(value: text),
                          ),
                        );
                      },
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: DefaultTextfield(
                      label: 'Contraseña',
                      icon: Icons.lock,
                      onChanged: (text) {
                        bloc?.add(
                          RegisterPasswordChanged(
                            password: BlocFormItem(value: text),
                          ),
                        );
                      },
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: DefaultTextfield(
                      label: 'Confirmar Contraseña',
                      icon: Icons.lock_outline,
                      onChanged: (text) {
                        bloc?.add(
                          RegisterConfirmPasswordChanged(
                            confirmPassword: BlocFormItem(value: text),
                          ),
                        );
                      },
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    child: DefaultButton(
                      label: 'Registrarse',
                      color: Colors.black,
                      onPressed: () {
                        if (state.formKey!.currentState!.validate()) {
                          bloc?.add(RegisterSubmitted());
                        } else {
                          Fluttertoast.showToast(
                            msg:
                                'Por favor, complete todos los campos correctamente.',
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
