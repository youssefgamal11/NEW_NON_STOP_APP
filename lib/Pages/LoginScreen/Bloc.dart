import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:new_non_stop/Helper/prefs.dart';
import 'package:new_non_stop/Helper/server_gate.dart';
import 'package:new_non_stop/Pages/LoginScreen/Events.dart';
import 'package:new_non_stop/Pages/LoginScreen/Model.dart';
import 'package:new_non_stop/Pages/LoginScreen/view.dart';
import 'States.dart';

class LoginBloc extends Bloc<LoginEvent, LoginStates> {
  LoginBloc() : super(LoginStates());

  ServerGate serverGate = ServerGate();
  Future<CustomResponse> login(LoginData contactData) async {
    serverGate.addInterceptors();
    CustomResponse response =
        await serverGate.sendToServer(url: 'login', headers: {
      "Accept": 'application/json',
    }, body: {
      'username': contactData.phone,
      'password': contactData.password,
     'device_token': Prefs.getString('token'),
      'type': Platform.isIOS ? "ios" : "android",
    });
    return response;
  }

  @override
  Stream<LoginStates> mapEventToState(LoginEvent event) async*{
    if(event is LoginEventStart)
      {
        yield LoginStatesStart();
        CustomResponse response = await login(event.contactData);

        if (response.success) {
          LoginModel userData =LoginModel.fromJson(response.response.data);
          Prefs.setString('fullname', userData.data.fullname);
          Prefs.setString('user Token', userData.data.token);
          Prefs.setString('email', userData.data.email);
          Prefs.setString('phone', userData.data.phone);
          yield(LoginStatesSuccess());
        }  else {
          print("from map event to state show error => ");
          print(response.errType.toString());

          if (response.errType == 0) {
            yield LoginStatesFailed(
              errType: 0,
              msg: "Network error ",
            );
          } else if (response.errType == 1) {
            print("HEre=======${response.statusCode}========>>>>>>>>");
            if (response.statusCode == 400) {
              yield LoginStatesFailed(
                  errType: 1,
                  msg: response.error['message'],
                  statusCode: response.statusCode);
            } else {
              yield LoginStatesFailed(
                  errType: 1,
                  msg: response.error['message'],
                  statusCode: response.statusCode);
            }
          } else {
            yield LoginStatesFailed(
                errType: 2,
                msg: "Server error , please try again",
                statusCode: response.statusCode??500);
          }
        }



      }




  }
}
