import 'package:bloc/bloc.dart';
import 'package:new_non_stop/Helper/Bloc/CityBloc/Events.dart';
import 'package:new_non_stop/Helper/Bloc/CityBloc/States.dart';
import 'package:new_non_stop/Helper/Bloc/CountryBloc/Model.dart';
import 'package:new_non_stop/Helper/server_gate.dart';

class CityBloc extends Bloc<GetAllCitiesEvents, GetAllCitiesStates> {
  CityBloc() : super(GetAllCitiesStates());
  ServerGate serverGate = ServerGate();
  CountryModel allCitiesModel;
  @override
  Stream<GetAllCitiesStates> mapEventToState(GetAllCitiesEvents event) async* {
    if (event is GetAllCitiesEventStart) {
      yield GetAllCitiesStatesStart();
      CustomResponse response =
          await fetchAllCities(countryId: event.countryId);

      if (response.success) {
        allCitiesModel = CountryModel.fromJson(response.response.data);
        yield GetAllCitiesStatesSuccess(cityModel: allCitiesModel);
      } else {
        print('from map event to state show error =>');
        print(response.error.toString());
        if (response.errType == 0) {
          yield GetAllCitiesStatesFailed(errType: 0, msg: 'NetWork Error');
        } else if (response.errType == 1) {
          yield GetAllCitiesStatesFailed(
              msg: response.error['message'], errType: 1);
        } else {
          yield GetAllCitiesStatesFailed(
              errType: 2, msg: 'serer error, please try again ');
        }
      }
    }
  }

  Future<CustomResponse> fetchAllCities({int countryId}) async {
    serverGate.addInterceptors();
    CustomResponse response =
        await serverGate.getFromServer(url: 'cities/1', headers: {
      'Accept': 'application/json',
    });
    return response;
  }
}
