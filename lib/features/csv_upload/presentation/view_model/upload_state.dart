// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_dashboard/features/authentication/domain/entity/faculty_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';

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

class UploadCsvFileSuccessState extends UploadState {}

class UploadCsvFileFailureState extends UploadState {}

class InstitutionCheckSuccessState extends UploadState {
  InstitutionEntity institutionEntity;
  InstitutionCheckSuccessState({required this.institutionEntity});
}

class InstitutionCheckFailureState extends UploadState {
  String message;
  InstitutionCheckFailureState({required this.message});
}
