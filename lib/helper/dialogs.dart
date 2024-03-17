import 'package:flutter/material.dart';

class Dialogs {
  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
      ),
      backgroundColor: const Color.fromARGB(255, 226, 18, 4).withOpacity(0.8),
      behavior: SnackBarBehavior.floating,
    ));
  }

  static void showSuccess(BuildContext context, String msg1) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg1,
        style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
      ),
      backgroundColor: Colors.green.withOpacity(0.8),
      behavior: SnackBarBehavior.floating,
    ));
  }

  static void showProgressBar(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => Center(child: CircularProgressIndicator()));
  }
}
