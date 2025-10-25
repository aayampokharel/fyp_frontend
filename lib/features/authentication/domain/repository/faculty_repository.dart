import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/faculty_entity.dart';

abstract interface class FacultyRepository {
  DefaultFutureEitherType<FacultyEntity> insertFaculty(
    FacultyEntity facultyEntity,
    String institutionID,
  );
}
