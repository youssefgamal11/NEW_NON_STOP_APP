import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:new_non_stop/Helper/Bloc/CityBloc/Bloc.dart';
import 'package:new_non_stop/Helper/Bloc/CityBloc/Events.dart';
import 'package:new_non_stop/Helper/Bloc/CityBloc/States.dart';
import 'package:new_non_stop/Helper/Bloc/CountryBloc/Bloc.dart';
import 'package:new_non_stop/Helper/Bloc/CountryBloc/Events.dart';
import 'package:new_non_stop/Helper/Bloc/CountryBloc/Model.dart';
import 'package:new_non_stop/Helper/Bloc/CountryBloc/States.dart';
import 'package:new_non_stop/Helper/Colors.dart';
import 'package:new_non_stop/Helper/FlashHelper.dart';
import 'package:new_non_stop/Helper/prefs.dart';
import 'package:new_non_stop/Pages/ActiveCode/View.dart';
  import 'package:new_non_stop/Pages/LoginScreen/Widgets/Widgets.dart';
import 'package:new_non_stop/Pages/LoginScreen/view.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:new_non_stop/Pages/RegisterScreen/Events.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_non_stop/Pages/RegisterScreen/States.dart';
import 'package:new_non_stop/Pages/RegisterScreen/Widgets/widget.dart';
import 'Bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  UserData userData = UserData();
  CityBloc getAllCitiesBloc = kiwi.KiwiContainer().resolve<CityBloc>();
  GetAllCountriesBloc getAllCountriesBloc =
      kiwi.KiwiContainer().resolve<GetAllCountriesBloc>();
  RegisterBloc registerBloc = kiwi.KiwiContainer().resolve<RegisterBloc>();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  @override
  void initState() {
    userData = UserData();
    getAllCountriesBloc.add(GetAllCountriesStart());
    super.initState();
  }

  submit(BuildContext context) {
    if (!formKey.currentState.validate()) {
      return;
    } else if (password.text != confirmPassword.text) {
      return FlashHelper.errorBar(context, message: 'كلمه المرور غير متطابقه');
    } else if (userData.citiesName == null) {
      return FlashHelper.errorBar(context, message: "يجب اختيار المدينه اولا");
    } else if (userData.countryName == null) {
      return FlashHelper.errorBar(context, message: 'يجب اختيار الدوله اولا');
    } else {
      formKey.currentState.save();
      registerBloc.add(RegisterEventStart(userData: userData));
    }
  }

  @override
  void dispose() {
    getAllCountriesBloc.close();
    super.dispose();
  }

  bool isSecure = true;
  toggle() {
    setState(() {
      isSecure = !isSecure;
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFFBFBFF),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: h * 0.02,
              ),
              Center(
                child: Container(
                  width: 160,
                  height: 130,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(
                      "images/logo.png",
                    ),
                  )),
                ),
              ),
              SizedBox(height: h * 0.02),
              Text(
                "انشاء حساب العميل",
                style: TextStyle(
                    fontFamily: '$fontFamily',
                    fontWeight: FontWeight.w900,
                    fontSize: 17,
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
                      "تسجيل الدخول",
                      style: TextStyle(
                          fontFamily: ("$fontFamily"),
                          fontWeight: FontWeight.w900,
                          color: Color(fontColor)),
                    ),
                    onTap: () {
                      Get.to(LoginScreen());
                    },
                  ),
                  SizedBox(width: w * 0.02),
                  Text(
                    "هل لديك حساب بالفعل ؟",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontFamily: '$fontFamily',
                        color: Color(fontColor2)),
                  ),
                ],
              ),
              SizedBox(
                height: h * 0.04,
              ),
              textForm(
                  x: "الاسم",
                  isSecure: false,
                  controller: null,
                  saved: (s) {
                    setState(() {
                      userData.fullName = s;
                    });
                  },
                  validate: (String value) {
                    if (value.isEmpty) {
                      return "name must not be empty";
                    }
                  }),
              SizedBox(height: h * 0.03),
              textForm(
                  x: "رقم الجوال",
                  controller: null,
                  isSecure: false,
                  saved: (s) {
                    setState(() {
                      userData.phone = s;
                    });
                  },
                  validate: (String value) {
                    if (value.isEmpty) {
                      return "phone must not be empty";
                    }
                  }),
              SizedBox(height: h * 0.03),
              textForm(
                  x: "البريد الالكترونى ",
                  isSecure: false,
                  controller: null,
                  saved: (s) {
                    userData.email = s;
                  },
                  validate: (String value) {
                    Pattern pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = new RegExp(pattern);
                    if (value.isEmpty) {
                      return "email must not be empty";
                    }
                  }),
              SizedBox(height: h * 0.03),









              BlocBuilder<GetAllCountriesBloc, GetAllCountriesStates>(
                  cubit: getAllCountriesBloc,
                  builder: (context, state) {
                    if (state is GetAllCountriesStateStart) {
                      return SpinKitThreeBounce(
                        color: Colors.black,
                        size: 20,
                      );}
                    else if (state is GetAllCountriesStateSuccess) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(right: 30  ,left: 30 ),
                        child: InkWell(
                          onTap: () {
                            displayCountriesBottomSheet(
                                type: "country" ,
                                context: context,
                                countries: state.allCountriesModel.data);
                          },
                          child: Container(
                            height: 48,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color:Color(formFieldColor),
                                border:
                                    Border.all(color:Colors.grey.shade700, width: 1 )),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:120.0),
                                      child: Text(
                                          userData.countryName == null
                                              ? "الدوله"
                                              : userData.countryName,
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: userData.countryName == null
                                                ? Colors.grey.shade700
                                                : Colors.black,
                                          )),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: 40,
                                      color: Colors.black,
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
              userData.countryName == null
                  ? Container()
                  : BlocBuilder<CityBloc, GetAllCitiesStates>(
                      cubit: getAllCitiesBloc,
                      builder: (context, state) {
                        if (state is GetAllCitiesStatesStart) {
                          return SpinKitThreeBounce(
                            size: 20,
                            color: Colors.black,
                          );
                        } else if (state is GetAllCitiesStatesSuccess) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 30, left: 30, top: 20, bottom: 5),
                            child: InkWell(
                              onTap: () {
                                displayCountriesBottomSheet(
                                    context: context,
                                    countries: state.cityModel.data);
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color(formFieldColor),
                                    border: Border.all(
                                        color: Colors.grey.shade700, width: 1)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 120.0),
                                        child: Text(
                                          userData.citiesName == null
                                              ? "المدينة"
                                              : userData.citiesName,
                                          style: TextStyle(
                                              color: userData.citiesName == null
                                                  ? Colors.black
                                                  : Colors.black),
                                        ),
                                      ),
                                      Icon(Icons.arrow_drop_down,
                                          size: 40, color: Colors.black),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),












              SizedBox(height: h * 0.03),
              textForm(
                  x: "كلمه المرور",
                  y: InkWell(
                    child: isSecure
                        ? Icon(Icons.lock)
                        : Icon(Icons.remove_red_eye_rounded),
                    onTap: () {
                      toggle();
                    },
                  ),
                  controller: password,
                  isSecure: isSecure,
                  saved: (s) {
                    setState(() {
                      userData.password = s;
                    });
                  },
                  validate: (String value) {
                    if (value.isEmpty) {
                      return "password must not be empty";
                    }
                  }),
              SizedBox(height: h * 0.03),
              textForm(
                  isSecure: isSecure,
                  x: "تاكيد المرور",
                  saved: (s) {
                    setState(() {
                      userData.confirmPassword = s;
                    });
                  },
                  y: InkWell(
                    child: isSecure
                        ? Icon(Icons.lock)
                        : Icon(Icons.remove_red_eye_rounded),
                    onTap: () {
                      toggle();
                    },
                  ),
                  controller: confirmPassword,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return "password must not be empty";
                    }
                  }),
              SizedBox(
                height: h * 0.04,
              ),
              BlocConsumer(
                cubit: registerBloc,
                builder: (context, state) {
                  if (state is RegisterStateStart) {
                    return SpinKitThreeBounce(
                      color: Colors.black,
                      size: 20,
                    );
                  } else {
                    return downScreenButton(
                        pagename: "/Activation",
                        context: context,
                        buttonname: "انشاء حساب  ",
                        function: () {
                          submit(context);
                        });
                  }
                },
                listener: (context, state)  async {
                  if (state is RegisterStateSuccess) {
                    Get.to(()=>ActiveCodeScreen(
                      phone:userData.phone ,
                    ));
                    // print(state.aboutData.message);
                    // await FlashHelper.successBar (context, message: " رمز التفعيل هو ${state.aboutData.message}");
                  } else if (state is RegisterStateFailed) {
                    if (state.errType == 0) {
                      FlashHelper.errorBar(context,
                          message: "هناك مشكلة فى الانترنت");
                    } else if (state.errType == 1) {
                      if (state.statusCode == 400) {
                        FlashHelper.errorBar(context, message: state.msg ?? "");
                      } else if (state.statusCode == 500) {
                        return FlashHelper.errorBar(this.context,
                            message: "Server error , please try again");
                      }
                    } else {}
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void displayCountriesBottomSheet(
      {BuildContext context, List<CountryData> countries, String type}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            width: double.infinity,
            height: 400,
            padding: EdgeInsets.all(9),
            child: Column(
              children: [
                (() {
                  if (type == "country") {
                    return Text("من فضلك قم باختيار الدولة ");
                  } else {
                    return Text("من فضلك قم باختيار المدينه ");
                  }
                }()),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: countries.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              if (type == "country") {
                                userData.countryName = countries[index].name;
                                userData.countryId = countries[index].id;
                                getAllCitiesBloc.add(GetAllCitiesEventStart(
                                    countryId: userData.countryId));
                                userData.citiesName = null;
                              } else {
                                userData.citiesName = countries[index].name;
                                userData.cityId = countries[index].id;
                              }
                            });
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                countries[index].name ?? "",
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          );
        });
  }
}

class UserData {
  String fullName;
  String email;
  String password;
  String confirmPassword;
  String phone;
  String countryName;
  String citiesName;
  int cityId;
  int countryId;
  String deviceToken;
  File image;
  String deviceType;
  UserData(
      {this.phone,
      this.password,
      this.email,
      this.fullName,
      this.citiesName,
      this.cityId,
      this.confirmPassword,
      this.countryId,
      this.countryName,
      this.deviceToken,
      this.deviceType,
      this.image});
}
