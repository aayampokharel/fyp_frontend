import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/entity/certificate_category_entity.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';

abstract interface class CategoryCreationIRepository {
  DefaultFutureEitherType<CertificateCategoryEntity> categoryCreation(
    String facultyName,
    String preferredCategoryName,
    String institutionId,
    String institutionFacultyId,
  );
}
