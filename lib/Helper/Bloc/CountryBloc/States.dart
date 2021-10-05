import 'package:new_non_stop/Helper/Bloc/CountryBloc/Model.dart';

class GetAllCountriesStates {}
class GetAllCountriesStateStart extends GetAllCountriesStates{}
class GetAllCountriesStateSuccess extends GetAllCountriesStates{
  CountryModel allCountriesModel ;
  GetAllCountriesStateSuccess({this.allCountriesModel});
}
class GetAllCountriesStateFailed extends GetAllCountriesStates{
  int errType ;
  String msg ;
  GetAllCountriesStateFailed({this.msg , this.errType});
}