import 'package:flutter/material.dart';
import 'package:new_non_stop/Helper/Colors.dart';

Widget gestureText({String text , Function function}) {
  return GestureDetector(
    onTap: (){
      function();
    },
    child: Text(
      "$text",
      style: TextStyle(
        fontFamily: '$fontFamily',
        color: Colors.red.shade700,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.underline,
      ),
    ),
  );
}
