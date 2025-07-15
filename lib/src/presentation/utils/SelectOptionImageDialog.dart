import 'package:flutter/material.dart';

SelectOptionImageDialog(
  BuildContext context,
  Function() pickImage,
  Function() takePhoto,
) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Selecciona una opción'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              pickImage();
            },
            child: Text('Galería', style: TextStyle(color: Colors.black)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              takePhoto();
            },
            child: Text('Cámara', style: TextStyle(color: Colors.black)),
          ),
        ],
      );
    },
  );
}
