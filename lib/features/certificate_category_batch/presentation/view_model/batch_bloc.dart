import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/usecase/category_batch_usecase.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/usecase/certificate_batch_usecase.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/usecase/individual_certificate_download_usecase.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/presentation/view_model/batch_event.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/presentation/view_model/batch_state.dart';

class BatchBloc extends Bloc<BatchEvent, BatchState> {
  CategoryBatchUseCase categoryBatchUseCase;
  CertificateBatchUseCase certificateBatchUseCase;
  IndividualCertificateDownloadPDFUseCase
  individualCertificateDownloadPDFUseCase;

  BatchBloc({
    required this.categoryBatchUseCase,
    required this.certificateBatchUseCase,
    required this.individualCertificateDownloadPDFUseCase,
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
        emit(CertificateBatchSelectLoadingState());
        final certificatesBatchList = await certificateBatchUseCase.call(
          CertificateBatchUseCaseParams(
            institutionID: event.institutionID,
            institutionFacultyID: event.institutionFacultyID,
            categoryID: event.categoryID,
          ),
        );
        certificatesBatchList.fold(
          (left) => emit(CertificateBatchSelectFailureState(left.message)),
          (right) => emit(CertificateBatchSelectSuccessState(right)),
        );
      } catch (e) {
        emit(CertificateBatchSelectFailureState(e.toString()));
      }
    });
    on<DownloadIndividualPDFButtonPressedEvent>((event, emit) async {
      try {
        //emit(CertificateBatchSelectLoadingState());
        await individualCertificateDownloadPDFUseCase.call(
          IndividualCertificateDownloadPDFUseCaseParams(
            categoryID: event.categoryID,
            categoryName: event.categoryName,
            fileID: event.fileID,
          ),
        );
        //   //! throw error notification only no success thing .
        // res.fold(
        // (left) => emit(CertificateBatchSelectFailureState(left.message)),
        // (right) => emit(CertificateBatchSelectSuccessState(right)),
        // );
      } catch (e) {
        emit(CertificateBatchSelectFailureState(e.toString()));
      }
    });
  }
}
