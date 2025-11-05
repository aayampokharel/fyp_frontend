import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/usecase/category_batch_use_case.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/usecase/certificate_batch_use_case.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/presentation/view_model/batch_event.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/presentation/view_model/batch_state.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/usecase/certificate_upload_use_case.dart';

class BatchBloc extends Bloc<BatchEvent, BatchState> {
  CategoryBatchUseCase _categoryBatchUseCase;
  CertificateBatchUseCase _certificateBatchUseCase;

  BatchBloc(this._categoryBatchUseCase, this._certificateBatchUseCase)
    : super(BatchInitialState()) {
    on<GetCategoryBatchListEvent>((event, emit) async {
      try {
        emit(BatchLoadingState());
        final categoryBatchList = await _categoryBatchUseCase.call(
          CategoryBatchUseCaseParams(
            institutionID: event.institutionID,
            institutionFacultyID: event.institutionFacultyID,
          ),
        );
        categoryBatchList.fold(
          (left) => emit(CategoryBatchLoadFailureState(left.message)),
          (right) => emit(CategoryBatchLoadSuccessState(right)),
        );
      } catch (e) {
        emit(CategoryBatchLoadFailureState(e.toString()));
      }
    });
    on<GetCertificatesBatchListEvent>((event, emit) async {
      try {
        final certificatesBatchList = await _certificateBatchUseCase.call(
          CertificateBatchUseCaseParams(
            institutionID: event.institutionID,
            institutionFacultyID: event.institutionFacultyID,
            categoryID: event.categoryID,
          ),
        );
        certificatesBatchList.fold(
          (left) => emit(CategoryBatchLoadFailureState(left.message)),
          (right) => emit(CategoryBatchSelectSuccessState(right)),
        );
      } catch (e) {
        emit(CategoryBatchLoadFailureState(e.toString()));
      }
    });
  }
}
