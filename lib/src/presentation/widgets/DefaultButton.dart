import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  String label;
  Function() onPressed;
  Color color;

  DefaultButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: color),
        child: Text(label, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
