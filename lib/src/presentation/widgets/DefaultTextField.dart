import 'package:flutter/material.dart';

class DefaultTextfield extends StatelessWidget {
  String label;
  String? errorText;
  IconData icon;
  Function(String text) onChanged;
  String? Function(String?)? validator;
  bool obscureText;

  DefaultTextfield({
    Key? key,
    required this.label,
    required this.icon,
    required this.onChanged,
    this.errorText,
    this.validator,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        label: Text(label, style: TextStyle(color: Colors.white)),
        errorText: errorText,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        prefixIcon: Icon(icon, color: Colors.white),
      ),
      style: TextStyle(color: Colors.white),
      onChanged: (text) {
        onChanged(text);
      },
    );
  }
}
