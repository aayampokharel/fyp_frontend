// import 'package:equatable/equatable.dart';

class Errorz implements Exception {
  final String message;
  final int code;
  const Errorz({required this.message, required this.code});

  @override
  String toString() => 'Errorz(code: $code, message: $message)';
}

class ServerError extends Errorz {
  String? extraMsg;
  ServerError({this.extraMsg = 'Server Error'})
    : super(message: "error:" + extraMsg!, code: 500);
}

class WarnError extends Errorz {
  String? extraMsg;
  WarnError({this.extraMsg = 'Warn Error'})
    : super(message: "warn:" + extraMsg!, code: 400);
}
