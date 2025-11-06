// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_dashboard/features/authentication/domain/entity/faculty_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_faculty_entity.dart';

abstract class UploadState {}

class UploadPageInitialState extends UploadState {}

class UploadPageLoadingState extends UploadState {
  UploadPageLoadingState();
}

class UploadPageStartSuccessState extends UploadState {
  FacultyEntity facultyEntity;
  UploadPageStartSuccessState({required this.facultyEntity});
}

class UploadPageStartFailureState extends UploadState {
  String message;
  UploadPageStartFailureState({required this.message});
}

class UploadCsvFileLoadingState extends UploadState {}

class UploadCsvFileSuccessState extends UploadState {
  String message;
  UploadCsvFileSuccessState({required this.message});
}

class UploadCsvFileFailureState extends UploadState {
  String message;
  UploadCsvFileFailureState({required this.message});
}

class InstitutionCheckSuccessState extends UploadState {
  InstitutionWithFacultiesEntity institutionWithFacultiesEntity;
  InstitutionCheckSuccessState({required this.institutionWithFacultiesEntity});
}

class InstitutionCheckFailureState extends UploadState {
  String message;
  InstitutionCheckFailureState({required this.message});
}
