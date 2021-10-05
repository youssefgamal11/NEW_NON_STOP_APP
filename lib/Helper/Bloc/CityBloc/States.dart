import 'package:new_non_stop/Helper/Bloc/CountryBloc/Model.dart';

class GetAllCitiesStates{}
class GetAllCitiesStatesStart extends GetAllCitiesStates {}
class GetAllCitiesStatesSuccess extends GetAllCitiesStates{
  CountryModel cityModel ;
  GetAllCitiesStatesSuccess({this.cityModel});
}
class GetAllCitiesStatesFailed extends GetAllCitiesStates{
  int errType ;
  String msg ;
  GetAllCitiesStatesFailed({this.errType , this.msg});
}