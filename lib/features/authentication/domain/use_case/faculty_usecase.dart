// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/faculty_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/repository/faculty_repository.dart';

class FacultyUseCaseParams {
  FacultyEntity facultyEntity;
  String institutionID;
  FacultyUseCaseParams({
    required this.facultyEntity,
    required this.institutionID,
  });
}

class FacultyUseCase implements UseCase<FacultyEntity, FacultyUseCaseParams> {
  FacultyRepository _facultyRepository;
  FacultyUseCase(this._facultyRepository);

  @override
  DefaultFutureEitherType<FacultyEntity> call(params) {
    return _facultyRepository.insertFaculty(
      params.facultyEntity,
      params.institutionID,
    );
  }
}
