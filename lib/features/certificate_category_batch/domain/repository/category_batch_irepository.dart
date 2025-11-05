import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/entity/certificate_category_entity.dart';

abstract interface class CategoryBatchIrepository {
  DefaultFutureEitherType<List<CertificateCategoryEntity>> getCategoryBatch(
    String institutionID,
    String institutionFacultyID,
  );
}
