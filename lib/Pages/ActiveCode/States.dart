
import 'Model.dart';

class ActiveCodeStates{}
class ActiveCodeStateStart extends ActiveCodeStates{}
class ActiveCodeStateSuccess extends ActiveCodeStates{
  ActiveCodeModel activeCodeModel ;
  ActiveCodeStateSuccess({this.activeCodeModel});
}
class ActiveCodeStateFailed extends ActiveCodeStates{
int errType ;
String msg ;
int statusCode ;
ActiveCodeStateFailed({this.errType , this.statusCode , this.msg});
}