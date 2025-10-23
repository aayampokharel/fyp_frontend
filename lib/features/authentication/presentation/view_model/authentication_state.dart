import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';

abstract class AuthenticationState {
  const AuthenticationState();
}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationSuccessState extends AuthenticationState {
  InstitutionEntity institutionEntity;
  AuthenticationSuccessState({required this.institutionEntity});
}

class AuthenticationErrorState extends AuthenticationState {
  String displayErrorString;
  int code;
  AuthenticationErrorState({
    required this.displayErrorString,
    required this.code,
  });
}
