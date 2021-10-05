import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:new_non_stop/Helper/Colors.dart';
import 'package:new_non_stop/Helper/FlashHelper.dart';
import 'package:new_non_stop/Helper/prefs.dart';
import 'package:new_non_stop/Pages/ActiveCode/Bloc.dart';
import 'package:new_non_stop/Pages/ActiveCode/States.dart';
import 'package:new_non_stop/Pages/LoginScreen/Widgets/Widgets.dart';
import 'package:new_non_stop/Pages/RegisterScreen/Widgets/widget.dart';
import 'package:new_non_stop/Pages/Verification/View.dart';
import 'Events.dart';
import 'Widgets/widgets.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class ActiveCodeScreen extends StatefulWidget {
  final String phone;

  const ActiveCodeScreen({Key key, this.phone}) : super(key: key);

  @override
  _ActiveCodeScreenState createState() => _ActiveCodeScreenState();
}

class _ActiveCodeScreenState extends State<ActiveCodeScreen> {
  final formKey = GlobalKey<FormState>();
  String code;
  Timer timer ;
  int hours ;
  int minutes ;
  int seconds ;
  int endDate ;
  bool stop = false ;
void startCountDown(){

print('timer start');
DateTime now = new DateTime.now();
int endDate = now.add(Duration(minutes: 1)).toUtc().millisecondsSinceEpoch;
timer = Timer.periodic(Duration(milliseconds: 1000), (Timer t) {
  var now = DateTime.now().toUtc().millisecondsSinceEpoch;
  var distance = endDate - now;
  Duration remaining = Duration(milliseconds: endDate - now);

  setState(() {
    hours = remaining.inHours;
    minutes = DateTime.fromMillisecondsSinceEpoch(remaining.inMilliseconds)
        .minute;
    seconds = DateTime.fromMillisecondsSinceEpoch(remaining.inMilliseconds)
        .second;
  });
  if (distance <= 0) {
    timer.cancel();
    stop = true;
    print('finish');
  }
});
}




  ActiveCodeBloc activeCodeBloc =
      kiwi.KiwiContainer().resolve<ActiveCodeBloc>();

  activeCode() {
    if (!formKey.currentState.validate()) {
      return;
    } else {
      formKey.currentState.save();
      activeCodeBloc.add(ActiveCodeEventStart(phone: widget.phone, code: code));
    }
  }

  @override
  void initState() {
    showToast(" كود التفعيل هو :${Prefs.getInt('devMessage')}");
    startCountDown();
    super.initState();
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Color(0xFFFBFBFF),
        body: SingleChildScrollView(
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
                "تفعيل الحساب",
                style: TextStyle(
                    fontFamily: '$fontFamily',
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Color(fontColor)),
              ),
              SizedBox(
                height: h * 0.05,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "عميلنا العزيز",
                    style: TextStyle(
                        color: Color(fontColor3),
                        fontWeight: FontWeight.w900,
                        fontSize: 15),
                  ),
                  Text("من فصلك قم بادخال كود التفعيل",
                      style: TextStyle(
                          color: Color(fontColor3),
                          fontWeight: FontWeight.w900,
                          fontSize: 15)),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text("المرسل لك على رقم الجوال التالى",
                        style: TextStyle(
                            color: Color(fontColor3),
                            fontWeight: FontWeight.w900,
                            fontSize: 15)),
                  ),
                ],
              ),
              SizedBox(
                height: h * 0.01,
              ),
              Text('${widget.phone}',
                  style: TextStyle(
                      color: Color(fontColor),
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              SizedBox(
                height: h * 0.08,
              ),

              textForm(
                  isSecure: false,
                  controller: null,
                  x: 'كود التفعيل',
                  saved: (s){
                    setState(() {
                      code = s ;
                    });
                  },
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'code must not be null';
                    }
                  }),
              SizedBox(height: h * 0.1),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: gestureText(text: "اعاده ارسال كود التفعيل" ,function: (){
                  if(stop == true){
                    showToast(" كود التفعيل هو :${Prefs.getInt('devMessage')}");
                  }else {
                    showToast("  يرجي المحاوله بعد انتهار التايمر");
                  }
                } ),
              ),
              Text(
                stop ? "00:00" : "${minutes ?? 01}:${seconds ?? 00}",
                style: TextStyle(
                  fontFamily: '$fontFamily',
                  fontSize: 22,
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: h * 0.06,
              ),
          BlocConsumer(
              cubit: activeCodeBloc,
              builder: (context , state){
            if (state is ActiveCodeStateStart){
              return SpinKitThreeBounce(
                size: 20,
                color: Colors.black,
              );
            }else{
              return
                downScreenButton(
                  context: context,
                  buttonname: "انشاء حساب  ",
                  function: () {
                    activeCode();
                  });
            }
          }, listener: (context , state){

            if(state is ActiveCodeStateSuccess){
              Get.to(()=>VerificationScreen());
            }else if(state is ActiveCodeStateFailed){
              if(state.statusCode == 400){
                FlashHelper.errorBar(context, message: state.msg ?? '');
              } else if(state.statusCode == 422){
                FlashHelper.errorBar(context, message: state.msg ?? '');
              } else if(state.statusCode == 500){
                FlashHelper.errorBar(context, message: state.msg ?? '');
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
