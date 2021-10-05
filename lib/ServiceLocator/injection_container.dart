import 'package:kiwi/kiwi.dart';
import 'package:new_non_stop/Helper/Bloc/CityBloc/Bloc.dart';
import 'package:new_non_stop/Helper/Bloc/CountryBloc/Bloc.dart';
import 'package:new_non_stop/Pages/ActiveCode/Bloc.dart';
import 'package:new_non_stop/Pages/LoginScreen/Bloc.dart';
import 'package:new_non_stop/Pages/RegisterScreen/Bloc.dart';


void initKiwi() {
  KiwiContainer container = KiwiContainer();

  container.registerFactory(
    (c) => LoginBloc(),
  );
  container.registerFactory((container) => CityBloc());
  container.registerFactory((container) => GetAllCountriesBloc());
  container.registerFactory((container) => RegisterBloc());
  container.registerFactory((container) => ActiveCodeBloc());




}
