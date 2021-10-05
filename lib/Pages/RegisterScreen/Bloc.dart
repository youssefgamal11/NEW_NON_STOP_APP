import 'package:bloc/bloc.dart';
import 'package:new_non_stop/Helper/prefs.dart';
import 'package:new_non_stop/Helper/server_gate.dart';
import 'package:new_non_stop/Pages/RegisterScreen/Events.dart';
import 'package:new_non_stop/Pages/RegisterScreen/Model.dart';
import 'package:new_non_stop/Pages/RegisterScreen/States.dart';
import 'package:new_non_stop/Pages/RegisterScreen/view.dart';

class RegisterBloc extends Bloc<RegisterEvents, RegisterStates> {
  RegisterBloc() : super(RegisterStates());
  ServerGate serverGate = ServerGate();

  @override
  Stream<RegisterStates> mapEventToState(RegisterEvents event) async* {
    if (event is RegisterEventStart) {
      yield RegisterStateStart();
      CustomResponse response = await userRegister(userData: event.userData);
      if (response.success) {
        yield RegisterStateSuccess();
        RegisterModel userData = RegisterModel.fromJson(response.response.data);
        Prefs.setString('message', userData.message);
        Prefs.setString('status', userData.status);
        Prefs.setInt('devMessage', userData.devMessage);
        Prefs.setString('', userData.data);
      }
      else{
        print('from map event to state show error =>');
        print(response.error.toString());

        if(response.error == 0){
          yield RegisterStateFailed(
            msg: 'NETWORK ERROR',
            errType: 0 ,
          );
        }else if(response.errType ==1){
          yield RegisterStateFailed(
            errType: 1 ,
            msg: response.error['message'],
           statusCode: response.statusCode,
          );
        }else if(response.errType ==2){
          yield RegisterStateFailed(errType: 2 ,msg: 'server error , please try again');
        }
      }
    }
  }

  Future<CustomResponse> userRegister({UserData userData}) async {
    serverGate.addInterceptors();
    CustomResponse response =
        await serverGate.sendToServer(url: 'register', body: {
      'fullname': userData.fullName,
      'email': userData.email,
      'password': userData.password,
      'phone': userData.phone,
      'city_id': userData.cityId,
      'country_id': userData.countryId,
    }, headers: {
      'Accept': 'application/json',
    });
    return response;
  }
}
