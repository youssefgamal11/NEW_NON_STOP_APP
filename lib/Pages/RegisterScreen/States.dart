import 'package:new_non_stop/Pages/RegisterScreen/Model.dart';
import 'package:new_non_stop/Pages/RegisterScreen/view.dart';

class RegisterStates {}

class RegisterStateStart extends RegisterStates {}

class RegisterStateSuccess extends RegisterStates {
  RegisterModel aboutData;
  RegisterStateSuccess({
    this.aboutData,
  });
}

class RegisterStateFailed extends RegisterStates {
  int errType;
  String msg;
  int statusCode;
  Map<String, dynamic> error;
  RegisterStateFailed({this.errType , this.statusCode , this.error , this.msg});
}
