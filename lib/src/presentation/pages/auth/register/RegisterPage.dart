import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/src/presentation/pages/auth/register/RegisterBlocCubit.dart';
import 'package:store_app/src/presentation/widgets/DefaultButton.dart';
import 'package:store_app/src/presentation/widgets/DefaultIconBack.dart';
import 'package:store_app/src/presentation/widgets/DefaultTextField.dart';

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
                          stream: _registerBlocCubit?.nameStream,
                          builder: (context, asyncSnapshot) {
                            return DefaultTextfield(
                              label: 'Nombre',
                              errorText: asyncSnapshot.error?.toString(),
                              icon: Icons.person,
                              onChanged: (text) {
                                _registerBlocCubit?.setName(text);
                              },
                            );
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: StreamBuilder(
                          stream: _registerBlocCubit?.lastnameStream,
                          builder: (context, asyncSnapshot) {
                            return DefaultTextfield(
                              label: 'Apellido',
                              errorText: asyncSnapshot.error?.toString(),
                              icon: Icons.person,
                              onChanged: (text) {
                                _registerBlocCubit?.setLastname(text);
                              },
                            );
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: StreamBuilder(
                          stream: _registerBlocCubit?.emailStream,
                          builder: (context, asyncSnapshot) {
                            return DefaultTextfield(
                              label: 'Email',
                              errorText: asyncSnapshot.error?.toString(),
                              icon: Icons.email,
                              onChanged: (text) {
                                _registerBlocCubit?.setEmail(text);
                              },
                            );
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: StreamBuilder(
                          stream: _registerBlocCubit?.phoneStream,
                          builder: (context, asyncSnapshot) {
                            return DefaultTextfield(
                              label: 'Teléfono',
                              errorText: asyncSnapshot.error?.toString(),
                              icon: Icons.phone,
                              onChanged: (text) {
                                _registerBlocCubit?.setPhone(text);
                              },
                            );
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: StreamBuilder(
                          stream: _registerBlocCubit?.passwordStream,
                          builder: (context, asyncSnapshot) {
                            return DefaultTextfield(
                              label: 'Contraseña',
                              errorText: asyncSnapshot.error?.toString(),
                              icon: Icons.lock,
                              onChanged: (text) {
                                _registerBlocCubit?.setPassword(text);
                              },
                            );
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: StreamBuilder(
                          stream: _registerBlocCubit?.confirmPasswordStream,
                          builder: (context, asyncSnapshot) {
                            return DefaultTextfield(
                              label: 'Confirmar Contraseña',
                              errorText: asyncSnapshot.error?.toString(),
                              icon: Icons.lock_outline,
                              onChanged: (text) {
                                _registerBlocCubit?.setConfirmPassword(text);
                              },
                            );
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 20,
                        ),
                        child: StreamBuilder(
                          stream: _registerBlocCubit?.isFormValid,
                          builder: (context, asyncSnapshot) {
                            return DefaultButton(
                              label: 'Registrarse',
                              color:
                                  asyncSnapshot.hasData && asyncSnapshot.data!
                                  ? Colors.black
                                  : Colors.grey,
                              onPressed: () {
                                if (asyncSnapshot.hasData &&
                                    asyncSnapshot.data!) {
                                  _registerBlocCubit?.register();
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
          ),
        ),
      ),
    );
  }
}
