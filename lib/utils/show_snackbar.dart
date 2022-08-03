import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Color.fromRGBO(75, 181, 67, 1),
      content: Text(
        text,
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
