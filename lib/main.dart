import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_non_stop/Pages/LoginScreen/view.dart';

import 'Helper/prefs.dart';
import 'ServiceLocator/injection_container.dart';
// @dart=2.9
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  initKiwi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}



