import 'package:flutter_dashboard/features/certificate_category_batch/domain/entity/certificate_category_entity.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';

abstract class BatchState {}

class BatchInitialState extends BatchState {}

class BatchLoadingState extends BatchState {}

// States for fetching list
class CategoryBatchLoadSuccessState extends BatchState {
  final List<CertificateCategoryEntity> batches; // your entity/model
  CategoryBatchLoadSuccessState(this.batches);
}

class CategoryBatchLoadFailureState extends BatchState {
  final String errorMsg;
  CategoryBatchLoadFailureState(this.errorMsg);
}

// States for selecting a batch
class CategoryBatchSelectSuccessState extends BatchState {
  final List<CertificateCategoryEntity> selectedCategoryBatch;
  CategoryBatchSelectSuccessState(this.selectedCategoryBatch);
}

class CategoryBatchSelectFailureState extends BatchState {
  final String errorMsg;
  CategoryBatchSelectFailureState(this.errorMsg);
}

class CertificateBatchSelectSuccessState extends BatchState {
  final List<CertificateDataEntity> selectedCertificateBatch;
  CertificateBatchSelectSuccessState(this.selectedCertificateBatch);
}

class CertificateBatchSelectLoadingState extends BatchState {}

class CertificateBatchSelectFailureState extends BatchState {
  final String errorMsg;
  CertificateBatchSelectFailureState(this.errorMsg);
}
