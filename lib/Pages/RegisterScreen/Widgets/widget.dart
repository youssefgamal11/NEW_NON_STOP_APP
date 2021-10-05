import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast( String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 8,
      backgroundColor: Colors.white,
      textColor: Colors.white,
      fontSize: 16.0);
}