// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:image_picker/image_picker.dart';

abstract class AuthenticationEvent {}

class CreateInstitutionUserEvent extends AuthenticationEvent {
  final String institutionName;
  final int wardNumber;
  final String toleAddress;
  final String districtAddress;
  CreateInstitutionUserEvent({
    required this.institutionName,
    required this.wardNumber,
    required this.toleAddress,
    required this.districtAddress,
  });
}

class CreateUserAccountEvent extends AuthenticationEvent {
  final String password;
  final String email;
  final String systemRole;
  final String institutionRole;
  final String institutionID;
  final String institutionLogoBase64;

  CreateUserAccountEvent({
    required this.password,
    required this.email,
    required this.systemRole,
    required this.institutionRole,
    required this.institutionID,
    required this.institutionLogoBase64,
  });
}

class CreateFacultyEvent extends AuthenticationEvent {
  String faculty;
  String institutionID;
  String principalName;
  String principalSignatureBase64;
  String facultyHodName;
  String universityAffiliation;
  String universityCollegeCode;
  String facultyHodSignatureBase64;

  CreateFacultyEvent({
    required this.faculty,
    required this.institutionID,
    required this.principalName,
    required this.principalSignatureBase64,
    required this.facultyHodName,
    required this.universityAffiliation,
    required this.universityCollegeCode,
    required this.facultyHodSignatureBase64,
  });
}

class AdminLoginEvent extends AuthenticationEvent {
  final String email;
  final String password;
  AdminLoginEvent({required this.email, required this.password});
}

class InstituteLoginEvent extends AuthenticationEvent {
  final String email;
  final String password;
  InstituteLoginEvent({required this.email, required this.password});
}

class SendImageForBackgroundRemovalEvent extends AuthenticationEvent {
  final XFile? pickerImageFile;
  SendImageForBackgroundRemovalEvent({required this.pickerImageFile});
}
