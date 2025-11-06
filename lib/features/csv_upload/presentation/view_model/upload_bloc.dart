import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/core/service/csv_to_certificate_data_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/use_case/faculty_usecase.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';
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

    on<UploadCsvFileEvent>((event, emit) async {
      emit(UploadCsvFileLoadingState());
      AppLogger.info("Started CSV upload process");

      try {
        if (event.platformFile == null) {
          throw Exception("No file selected");
        }

        // Get CSV content from PlatformFile
        final csvContent = await getCsvContent(event.platformFile!);
        AppLogger.info("CSV file loaded: ${event.platformFile!.name}");

        final certificates = await parseCsvFileInBackground(
          csvContent,
          event.institutionID,
          "144c483c-5a39-49", // institutionFacultyId
          "451c55a1-3673-4b", // pdfCategoryId
          event.facultyPublicKey ?? "",
        );

        AppLogger.info("Parsed ${certificates.length} certificates");

        final res = await certificateUploadUseCase.call(
          CertificateUseCaseParams(
            certificateDataList: certificates,
            instituitonID: event.institutionID,
            institutionFacultyID: "144c483c-5a39-49",
            institutionFacultyName: "csit",
            categoryID: "451c55a1-3673-4b",
            categoryName: event.categoryName,
          ),
        );

        res.fold(
          (left) => emit(UploadCsvFileFailureState(message: left.message)),
          (right) => emit(UploadCsvFileSuccessState(message: right)),
        );
      } catch (e) {
        AppLogger.error("Upload error: $e");
        emit(UploadCsvFileFailureState(message: e.toString()));
      }
    });
  }
}
