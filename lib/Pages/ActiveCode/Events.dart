class ActiveCodeEvents{}
class ActiveCodeEventStart extends ActiveCodeEvents{
  final String code ;
  final String phone ;
  ActiveCodeEventStart({this.phone , this.code});
}