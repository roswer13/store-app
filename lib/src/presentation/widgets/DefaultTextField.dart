import 'package:flutter/material.dart';

class DefaultTextfield extends StatelessWidget {
  String label;
  String? errorText;
  IconData icon;
  Function(String text) onChanged;
  bool obscureText;

  DefaultTextfield({
    super.key,
    required this.label,
    required this.icon,
    required this.onChanged,
    this.errorText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
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
      onChanged: onChanged,
    );
  }
}
