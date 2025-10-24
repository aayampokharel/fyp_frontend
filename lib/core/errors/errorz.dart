// import 'package:equatable/equatable.dart';

class Errorz implements Exception {
  final String message;
  final int statusCode;
  const Errorz({required this.message, required this.statusCode});

  @override
  String toString() => 'Errorz(statusCode: $statusCode, message: $message)';
}

class ServerError extends Errorz {
  String? extraMsg;
  ServerError({this.extraMsg = 'Server Error'})
    : super(message: "error:${extraMsg!}", statusCode: 500);
}

class WarnError extends Errorz {
  String? extraMsg;
  WarnError({this.extraMsg = 'Warn Error'})
    : super(message: "warn:${extraMsg!}", statusCode: 400);
}
