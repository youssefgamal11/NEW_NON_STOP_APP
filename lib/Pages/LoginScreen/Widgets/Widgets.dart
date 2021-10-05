import 'package:flutter/material.dart';
import 'package:new_non_stop/Helper/Colors.dart';

Widget textForm(
    {String x,
    Widget y,
    @required TextEditingController controller,
    Function(String) saved,
    bool isSecure,
    Function validate,
    Function onSubmit}) {
  return Padding(
    padding: const EdgeInsets.only(left: 30, right: 30),
    child: TextFormField(
      textAlign: TextAlign.center,
      obscureText: isSecure,
      controller: controller,
      onSaved: saved,
      validator: validate,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(formFieldColor),
        suffixIcon: y,
        hintText: "$x ",
        contentPadding: const EdgeInsets.only(left: 30, right: 30),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  );
}

Widget downScreenButton(
    {String pagename,
    BuildContext context,
    String buttonname,
    Function function}) {
  return Container(
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(25), boxShadow: [
      BoxShadow(
        color: Color(fontColor),
        blurRadius: 5,
        offset: Offset(2, 2),
      )
    ]),
    width: 350,
    height: 50,
    child: RaisedButton(
      splashColor: Color(fontColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      onPressed: () {
        // Navigator.of(context).pushNamed("$pagename");
        function();
      },
      color: Color(fontColor),
      child: Text(
        " $buttonname",
        style: TextStyle(
            fontFamily: '$fontFamily',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17),
      ),
    ),
  );
}
