import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_non_stop/Helper/Colors.dart';
import 'package:new_non_stop/Helper/FlashHelper.dart';
import 'package:new_non_stop/Helper/prefs.dart';
import 'package:new_non_stop/Pages/FirstPage/view.dart';
import 'package:new_non_stop/Pages/LoginScreen/Events.dart';
import 'package:new_non_stop/Pages/LoginScreen/States.dart';
import 'package:new_non_stop/Pages/LoginScreen/Widgets/Widgets.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:new_non_stop/Pages/RegisterScreen/view.dart';
import 'Bloc.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  LoginData loginData = LoginData();

  LoginBloc loginBloc = kiwi.KiwiContainer().resolve<LoginBloc>();
  sendDataToServer() {
    if (!formKey.currentState.validate()) {
      return;
    } else {
      formKey.currentState.save();
      loginBloc.add(LoginEventStart(loginData));
    }
  }

  bool isSecure = true;
  void toggle() {
    setState(() {
      isSecure = !isSecure;
    });
  }

  @override
  void initState() {
    loginData = LoginData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFFBFBFF),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: h * 0.03,
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
                ),
              ),
              SizedBox(height: h * 0.03),
              Text(
                "تسجيل الدخول",
                style: TextStyle(
                    fontFamily: '$fontFamily',
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Color(fontColor)),
              ),
              SizedBox(
                height: h * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Text(
                      "انشاء حساب",
                      style: TextStyle(
                          fontFamily: ("$fontFamily"),
                          fontWeight: FontWeight.w900,
                          color: Color(fontColor)),
                    ),
                    onTap: () {
                      Get.to(RegisterScreen());
                    },
                  ),
                  SizedBox(width: w * 0.02),
                  Text(
                    "ليس لديك حساب؟",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontFamily: '$fontFamily',
                        color: Color(fontColor2)),
                  ),
                ],
              ),
              SizedBox(
                height: h * 0.08,
              ),
              textForm(
                  y: Icon(Icons.phone),
                  x: "رقم الجوال",
                  isSecure: false,
                  controller: null,
                  saved: (s) {
                    setState(() {
                      loginData.phone = s;
                    });
                  },
                  validate: (s) {
                    if (s.isEmpty) {
                      return 'برحاء ادخال قيمه الجوال';
                    }
                  }),
              SizedBox(height: h * 0.05),
              textForm(
                  isSecure: isSecure,
                  x: "كلمه المرور",
                  controller: null,
                  y: InkWell(
                    onTap: () {
                      toggle();
                    },
                    child: isSecure
                        ? Icon(
                            Icons.remove_red_eye,
                          )
                        : Icon(
                            Icons.lock,
                          ),
                  ),
                  saved: (s) {
                    setState(() {
                      loginData.password = s;
                    });
                  },
                  validate: (String s) {
                    if (s.isEmpty) {
                      return 'برجاء ادخال قيمه الرقم السري';
                    }
                  }),
              SizedBox(height: h * 0.1),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "نسيت كلمه المرور",
                  style: TextStyle(
                    fontFamily: '$fontFamily',
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.1,
              ),
              BlocConsumer(
                cubit: loginBloc,
                  builder: (context, state) {
                    if (state is LoginStatesStart) {
                      return SpinKitThreeBounce(
                        size: 20,
                        color: Colors.black,
                      );
                    } else {
                      return downScreenButton(
                          buttonname: "تسجيل الدخول",
                          function: () {
                            Get.to(sendDataToServer());
                          });
                    }
                  },
                  listener: (context, state) {
                  if(state is LoginStatesSuccess){
                    Get.to(FirstPage());
                  } else if (state is LoginStatesFailed) {
                    if (state.errType == 0) {
                      FlashHelper.errorBar(context,
                          message: "خطأ فى الإتصال بالانترنت");
                    } else if (state.errType == 1) {
                      FlashHelper.errorBar(context, message: state.msg ?? "");
                    } else if (state.errType == 2) {
                      FlashHelper.errorBar(context, message: state.msg ?? "");
                    } else {
                      FlashHelper.errorBar(context, message: state.msg ?? "");
                    }
                  }



                  })
            ],
          ),
        ),
      ),
    );
  }
}

class LoginData {
  String password;
  String phone;

  LoginData({this.phone, this.password});
}
