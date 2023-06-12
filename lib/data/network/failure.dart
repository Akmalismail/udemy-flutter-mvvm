import 'package:udemy_flutter_mvvm/data/network/error_handler.dart';

class Failure {
  int code; // http status code
  String message; // http error mesage

  Failure(this.code, this.message);
}

class DefaultFailure extends Failure {
  DefaultFailure() : super(ResponseCode.unknown, ResponseMessage.unknown);
}
