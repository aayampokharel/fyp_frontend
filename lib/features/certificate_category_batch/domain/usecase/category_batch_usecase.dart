import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/entity/certificate_category_entity.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/repository/category_batch_irepository.dart';

class CategoryBatchUseCaseParams {
  String institutionID;
  String institutionFacultyID;

  CategoryBatchUseCaseParams({
    required this.institutionID,
    required this.institutionFacultyID,
  });
}

class CategoryBatchUseCase
    implements
        UseCase<List<CertificateCategoryEntity>, CategoryBatchUseCaseParams> {
  CategoryBatchIrepository _categoryBatchIrepository;
  CategoryBatchUseCase(this._categoryBatchIrepository);
  @override
  DefaultFutureEitherType<List<CertificateCategoryEntity>> call(
    CategoryBatchUseCaseParams params,
  ) {
    return _categoryBatchIrepository.getCategoryBatch(
      params.institutionID,
      params.institutionFacultyID,
    );
  }
}
