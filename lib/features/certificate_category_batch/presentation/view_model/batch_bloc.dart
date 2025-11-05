import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/usecase/category_batch_usecase.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/usecase/certificate_batch_usecase.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/presentation/view_model/batch_event.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/presentation/view_model/batch_state.dart';

class BatchBloc extends Bloc<BatchEvent, BatchState> {
  CategoryBatchUseCase categoryBatchUseCase;
  CertificateBatchUseCase certificateBatchUseCase;

  BatchBloc({
    required this.categoryBatchUseCase,
    required this.certificateBatchUseCase,
  }) : super(BatchInitialState()) {
    on<GetCategoryBatchListEvent>((event, emit) async {
      try {
        emit(BatchLoadingState());
        final categoryBatchList = await categoryBatchUseCase.call(
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
        final certificatesBatchList = await certificateBatchUseCase.call(
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
