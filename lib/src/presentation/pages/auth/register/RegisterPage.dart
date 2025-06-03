import 'package:flutter/material.dart';
import 'package:store_app/src/presentation/widgets/DefaultButton.dart';
import 'package:store_app/src/presentation/widgets/DefaultIconBack.dart';
import 'package:store_app/src/presentation/widgets/DefaultTextField.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                        child: DefaultTextfield(
                          label: 'Nombre',
                          icon: Icons.person,
                          onChanged: (text) {
                            print("Nombre: $text");
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: DefaultTextfield(
                          label: 'Apellido',
                          icon: Icons.person,
                          onChanged: (text) {
                            print("Apellido: $text");
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: DefaultTextfield(
                          label: 'Email',
                          icon: Icons.email,
                          onChanged: (text) {
                            print("Email: $text");
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: DefaultTextfield(
                          label: 'Teléfono',
                          icon: Icons.phone,
                          onChanged: (text) {
                            print("Teléfono: $text");
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: DefaultTextfield(
                          label: 'Contraseña',
                          icon: Icons.lock,
                          onChanged: (text) {
                            print("Contraseña: $text");
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: DefaultTextfield(
                          label: 'Confirmar Contraseña',
                          icon: Icons.lock_outline,
                          onChanged: (text) {
                            print("Confirmar Contraseña: $text");
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 20,
                        ),
                        child: DefaultButton(
                          label: 'Registrarse',
                          onPressed: () {},
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
