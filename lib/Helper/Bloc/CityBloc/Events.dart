class GetAllCitiesEvents {}

class GetAllCitiesEventStart extends GetAllCitiesEvents {
  int countryId;
  GetAllCitiesEventStart({this.countryId});
}

class GetAllCitiesEventSuccess extends GetAllCitiesEvents {}

class GetAllCitiesEventFailed extends GetAllCitiesEvents {}
