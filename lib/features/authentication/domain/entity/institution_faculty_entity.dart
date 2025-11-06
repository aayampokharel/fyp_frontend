// New entity that combines institution with its faculties
import 'package:flutter_dashboard/features/authentication/domain/entity/faculty_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';

class InstitutionWithFacultiesEntity {
  final InstitutionEntity institution;
  final List<FacultyEntity> faculties;

  InstitutionWithFacultiesEntity({
    required this.institution,
    required this.faculties,
  });

  @override
  String toString() {
    return 'InstitutionWithFacultiesEntity(institution: ${institution.institutionName}, faculties: ${faculties.length})';
  }
}
