import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:new_non_stop/Helper/prefs.dart';
import 'package:new_non_stop/Helper/server_gate.dart';
import 'package:new_non_stop/Pages/ActiveCode/States.dart';
import 'Events.dart';
import 'Model.dart';

class ActiveCodeBloc extends Bloc<ActiveCodeEvents, ActiveCodeStates> {
  ActiveCodeBloc() : super(ActiveCodeStates());
  ServerGate serverGate = ServerGate();
  @override
  Stream<ActiveCodeStates> mapEventToState(ActiveCodeEvents event) async* {
    if (event is ActiveCodeEventStart) {
      yield ActiveCodeStateStart();
      CustomResponse response = await verify(event.code, event.phone);
      if (response.success) {
        ActiveCodeModel activeCodeModel =
        ActiveCodeModel.fromJson(response.response.data);
        yield ActiveCodeStateSuccess(activeCodeModel: activeCodeModel);
        Prefs.setString('token', activeCodeModel.data.token);
      } else {
        print("from map event to state show error => ");
        print(response.errType.toString());

        if (response.errType == 0) {
          yield ActiveCodeStateFailed(
            errType: 0,
            msg: "Network error ",
          );
        } else if (response.errType == 1) {
          if (response.statusCode == 400) {
            yield ActiveCodeStateFailed(
                errType: 1,
                msg: response.error['message'],
                statusCode: response.statusCode);
          } else {
            yield ActiveCodeStateFailed(
                errType: 1,
                msg: response.error['message'],
                statusCode: response.statusCode);
          }
        } else {
          yield ActiveCodeStateFailed(
              errType: 2,
              msg: "Server error , please try again",
              statusCode: response.statusCode);
        }
      }
    }
  }

  Future<CustomResponse> verify(String code, String phone) async {
    serverGate.addInterceptors();
    print("${code}");
    CustomResponse response =
        await serverGate.sendToServer(url: 'verify', body: {
      'code': code,
      'phone': phone,
      'device_token': 7485996,
      'type': Platform.isIOS ? 'ios' : 'android',
    }, headers: {
      "Accept": "application/json",
    });
    return response;
  }
}
