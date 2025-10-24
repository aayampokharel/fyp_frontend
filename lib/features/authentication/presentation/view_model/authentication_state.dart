import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/user_account_entity.dart';

abstract class AuthenticationState {
  const AuthenticationState();
}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationSuccessState extends AuthenticationState {
  InstitutionEntity institutionEntity;
  AuthenticationSuccessState({required this.institutionEntity});
}

class UserAccountSuccessState extends AuthenticationState {
  UserAccountEntity userAccountEntity;
  UserAccountSuccessState({required this.userAccountEntity});
}

class AuthenticationErrorState extends AuthenticationState {
  String displayErrorString;
  int code;
  AuthenticationErrorState({
    required this.displayErrorString,
    required this.code,
  });
}
