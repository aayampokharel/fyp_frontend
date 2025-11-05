import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard/features/authentication/domain/use_case/faculty_usecase.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/usecase/certificate_upload_use_case.dart';
import 'package:flutter_dashboard/features/csv_upload/presentation/view_model/upload_event.dart';
import 'package:flutter_dashboard/features/csv_upload/presentation/view_model/upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final CertificateUploadUseCase _certificateUploadUseCase;
  final FacultyUseCase _facultyUseCase;
  UploadBloc(this._certificateUploadUseCase, this._facultyUseCase)
    : super(UploadPageInitialState()) {
    on<UploadPageStartedEvent>((event, emit) async {
      emit(UploadPageLoadingState());
      final response = await _facultyUseCase.call(
        FacultyUseCaseParams(
          facultyEntity: event.facultyEntity,
          institutionID: event.institutionID,
        ),
      );
      response.fold(
        (left) => emit(UploadPageStartFailureState(message: left.message)),
        (right) => emit(UploadPageStartSuccessState(facultyEntity: right)),
      );
    });
    on<UploadCsvFileEvent>((event, emit) {
      emit(UploadPageLoadingState());
    });
  }
}
