import 'package:new_non_stop/Helper/Bloc/CountryBloc/Model.dart';

class GetAllCountriesEvents {}
class GetAllCountriesStart extends GetAllCountriesEvents{}
class GetAllCountriesSuccess extends GetAllCountriesEvents{
}
class GetAllCountriesFailed extends GetAllCountriesEvents{}