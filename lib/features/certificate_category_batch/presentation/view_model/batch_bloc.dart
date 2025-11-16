import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/usecase/category_batch_usecase.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/usecase/certificate_batch_usecase.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/usecase/certificate_html_preview_usecase.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/usecase/certificate_download_usecase.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/presentation/view_model/batch_event.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/presentation/view_model/batch_state.dart';

class BatchBloc extends Bloc<BatchEvent, BatchState> {
  CategoryBatchUseCase categoryBatchUseCase;
  CertificateBatchUseCase certificateBatchUseCase;
  CertificateDownloadPDFUseCase certificateDownloadPDFUseCase;
  CertificateHTMLPreviewUseCase certificateHTMLPreviewUseCase;

  BatchBloc({
    required this.categoryBatchUseCase,
    required this.certificateBatchUseCase,
    required this.certificateDownloadPDFUseCase,
    required this.certificateHTMLPreviewUseCase,
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
    on<DownloadPDFButtonPressedEvent>((event, emit) async {
      try {
        //emit(CertificateBatchSelectLoadingState());
        if (event.fileID == "") {
          event.fileID = "0";
        }
        await certificateDownloadPDFUseCase.call(
          CertificateDownloadPDFUseCaseParams(
            categoryID: event.categoryID,
            categoryName: event.categoryName,
            fileID: event.fileID,
            isDownloadAll: event.downloadAll,
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
    on<PreviewCertificateHTMLButtonPressedEvent>((event, emit) async {
      try {
        await certificateHTMLPreviewUseCase.call(
          CertificateHTMLPreviewUseCaseParams(
            id: event.id,
            certificateHash: event.certificateHash,
          ),
        );
        //   //! throw error notification only no success thing .
      } catch (e) {
        emit(CertificateBatchSelectFailureState(e.toString()));
      }
    });
  }
}
