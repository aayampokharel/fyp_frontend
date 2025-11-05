import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard/features/authentication/domain/use_case/faculty_usecase.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/usecase/certificate_upload_usecase.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/usecase/check_institution_is_active_usecase.dart';
import 'package:flutter_dashboard/features/csv_upload/presentation/view_model/upload_event.dart';
import 'package:flutter_dashboard/features/csv_upload/presentation/view_model/upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final CertificateUploadUseCase certificateUploadUseCase;
  final FacultyUseCase facultyUseCase;
  final CheckInstitutionIsActiveUsecase checkInstitutionIsActiveUsecase;
  UploadBloc({
    required this.certificateUploadUseCase,
    required this.facultyUseCase,
    required this.checkInstitutionIsActiveUsecase,
  }) : super(UploadPageInitialState()) {
    on<UploadPageStartedEvent>((event, emit) async {
      emit(UploadPageLoadingState());
      final response = await facultyUseCase.call(
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
    on<InstitutionCheckEvent>((event, emit) async {
      emit(UploadPageLoadingState());
      var institutionEntity = await checkInstitutionIsActiveUsecase.call(
        event.institutionID,
      );
      institutionEntity.fold(
        (left) => emit(InstitutionCheckFailureState(message: left.message)),
        (right) => emit(InstitutionCheckSuccessState(institutionEntity: right)),
      );
    });
  }
}
