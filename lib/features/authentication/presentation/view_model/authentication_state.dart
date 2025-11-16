// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/admin_account_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/faculty_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institute_account_entity.dart';
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

class FacultySuccessState extends AuthenticationState {
  FacultyEntity facultyEntity;

  FacultySuccessState(this.facultyEntity);
}

class AdminAccountVerificationSuccessState extends AuthenticationState {
  AdminDashboardCountsEntity adminDashboardCountsEntity;
  AdminAccountVerificationSuccessState({
    required this.adminDashboardCountsEntity,
  });
}

class InstituteAccountVerificationSuccessState extends AuthenticationState {
  InstituteAccountEntity instituteAccountEntity;
  InstituteAccountVerificationSuccessState({
    required this.instituteAccountEntity,
  });
}

class InstituteAccountVerificationFailureState extends AuthenticationState {
  String errorMsg;
  InstituteAccountVerificationFailureState({required this.errorMsg});
}

class SendImageForBackgroundRemovalLoadingState extends AuthenticationState {}

class SendImageForBackgroundRemovalFailureState extends AuthenticationState {
  String errorMsg;
  SendImageForBackgroundRemovalFailureState({required this.errorMsg});
}

class SendImageForBackgroundRemovalSuccessState extends AuthenticationState {
  Uint8List imageIntList;
  SendImageForBackgroundRemovalSuccessState({required this.imageIntList});
}
