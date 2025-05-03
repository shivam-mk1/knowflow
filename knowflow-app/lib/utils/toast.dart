import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastWidget {
  final String message;
  final int status;
  ToastWidget(this.message, this.status);
  void showToast() {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: status == 0 ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
