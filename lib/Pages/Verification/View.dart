import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_non_stop/Helper/Colors.dart';
import 'package:new_non_stop/Pages/FirstPage/view.dart';
import 'package:new_non_stop/Pages/LoginScreen/Widgets/Widgets.dart';

class VerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFFBFBFF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: h * 0.04,
            ),
            Center(
                child: Container(
              width: 180,
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  "images/logo.png",
                ),
              )),
            )),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/logo11.png"), fit: BoxFit.fill),
              ),
            ),
            SizedBox(height: h * 0.1),
            Text(
              " تم انشاء وتفعيل الحساب بنجاح",
              style: TextStyle(
                  fontFamily: '$fontFamily',
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Color(fontColor)),
            ),
            SizedBox(
              height: h * 0.07,
            ),

            downScreenButton(
                function: () {
                  Get.to(()=> FirstPage());
                }, context: context, buttonname: "استمرار")
          ],
        ),
      ),
    );
  }
}
