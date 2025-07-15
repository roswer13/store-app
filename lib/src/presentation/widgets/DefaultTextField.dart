import 'package:flutter/material.dart';

class DefaultTextfield extends StatelessWidget {
  String label;
  String? initialValue;
  String? errorText;
  IconData icon;
  Color? color;
  Function(String text) onChanged;
  String? Function(String?)? validator;
  bool obscureText;

  DefaultTextfield({
    Key? key,
    required this.label,
    this.initialValue,
    required this.icon,
    this.color = Colors.white,
    required this.onChanged,
    this.errorText,
    this.validator,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        label: Text(label, style: TextStyle(color: color)),
        errorText: errorText,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: color!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: color!),
        ),
        prefixIcon: Icon(icon, color: color!),
      ),
      style: TextStyle(color: color!),
      onChanged: (text) {
        onChanged(text);
      },
    );
  }
}
