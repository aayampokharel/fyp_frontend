import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';

abstract class AuthenticationState {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  InstitutionEntity institutionEntity;
  AuthenticationSuccess({required this.institutionEntity});
}

class AuthenticationError extends AuthenticationState {
  String displayErrorString;
  int code;
  AuthenticationError({required this.displayErrorString, required this.code});
}
