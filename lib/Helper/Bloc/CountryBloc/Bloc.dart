import 'package:bloc/bloc.dart';
import 'package:new_non_stop/Helper/Bloc/CountryBloc/Events.dart';
import 'package:new_non_stop/Helper/Bloc/CountryBloc/Model.dart';
import 'package:new_non_stop/Helper/Bloc/CountryBloc/States.dart';
import 'package:new_non_stop/Helper/server_gate.dart';

class GetAllCountriesBloc
    extends Bloc<GetAllCountriesEvents, GetAllCountriesStates> {
  GetAllCountriesBloc() : super(GetAllCountriesStates());

  ServerGate serverGate = ServerGate();
  @override
  Stream<GetAllCountriesStates> mapEventToState(
      GetAllCountriesEvents event) async* {
    if (event is GetAllCountriesStart) {
      yield GetAllCountriesStateStart();
    }

    CustomResponse response = await fetchAllCountries();
    if (response.success) {
      CountryModel allCountries = CountryModel.fromJson(response.response.data);
      yield GetAllCountriesStateSuccess(allCountriesModel: allCountries);
    } else {
      print('from map event to state show error =>');
      print(response.error.toString());
      if (response.errType == 0) {
        yield GetAllCountriesStateFailed(
          errType: 0,
          msg: 'network error',
        );
      } else if (response.errType == 1) {
        yield GetAllCountriesStateFailed(
          msg: response.error['message'],
          errType: 1,
        );
      } else {
        yield GetAllCountriesStateFailed(
          errType: 2,
          msg: 'server error , please try again',
        );
      }
    }
  }

  Future<CustomResponse> fetchAllCountries() async {
    serverGate.addInterceptors();
    CustomResponse response =
        await serverGate.getFromServer(url: 'countries', headers: {
      'Accept': 'application/json',
    });
    return response;
  }
}
