import 'package:new_non_stop/Pages/LoginScreen/view.dart';

class LoginEvent {}
class LoginEventStart extends LoginEvent{
final LoginData contactData ;
LoginEventStart(this.contactData);
}