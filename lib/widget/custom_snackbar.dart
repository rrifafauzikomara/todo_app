import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showError(String error, BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(error),
      backgroundColor: Colors.red,
    ));
  }

  static void showSuccess(String message, BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    ));
  }
}