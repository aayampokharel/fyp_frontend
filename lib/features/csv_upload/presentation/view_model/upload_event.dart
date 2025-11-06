import 'package:file_picker/file_picker.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/faculty_entity.dart';

abstract class UploadEvent {}

class UploadPageStartedEvent extends UploadEvent {
  FacultyEntity facultyEntity;
  String institutionID;

  UploadPageStartedEvent({
    required this.facultyEntity,
    required this.institutionID,
  });
}

class InstitutionCheckEvent extends UploadEvent {
  String institutionID;

  InstitutionCheckEvent({required this.institutionID});
}

class UploadCsvFileEvent extends UploadEvent {
  String institutionID;
  String categoryName;
  PlatformFile? platformFile;
  String? facultyPublicKey;
  String? pdfCategoryID;
  String? institutionFacultyID;

  UploadCsvFileEvent({
    required this.institutionID,
    required this.categoryName,
    this.platformFile,
  });
}
