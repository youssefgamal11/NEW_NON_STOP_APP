import 'package:new_non_stop/Pages/LoginScreen/view.dart';

 class LoginStates {}
class LoginStatesStart extends LoginStates {}

class LoginStatesSuccess extends LoginStates {
  LoginData aboutData;
  LoginStatesSuccess({this.aboutData});
}

class LoginStatesFailed extends LoginStates {
  int errType;
  String msg;
  int statusCode;
  LoginStatesFailed({this.msg, this.statusCode, this.errType});
}
