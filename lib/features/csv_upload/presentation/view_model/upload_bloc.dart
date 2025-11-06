import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/core/service/csv_to_certificate_data_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/use_case/faculty_usecase.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/entity/certificate_category_entity.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/usecase/category_creation_usecase.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/usecase/certificate_upload_usecase.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/usecase/check_institution_is_active_usecase.dart';
import 'package:flutter_dashboard/features/csv_upload/presentation/view_model/upload_event.dart';
import 'package:flutter_dashboard/features/csv_upload/presentation/view_model/upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final CertificateUploadUseCase certificateUploadUseCase;
  final FacultyUseCase facultyUseCase;

  final CategoryCreationUseCase categoryCreationUseCase;
  final CheckInstitutionIsActiveUsecase checkInstitutionIsActiveUsecase;
  UploadBloc({
    required this.certificateUploadUseCase,
    required this.facultyUseCase,
    required this.checkInstitutionIsActiveUsecase,
    required this.categoryCreationUseCase,
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
        (right) => emit(
          InstitutionCheckSuccessState(institutionWithFacultiesEntity: right),
        ),
      );
    });

    on<UploadCsvFileEvent>((event, emit) async {
      try {
        AppLogger.info("Started CSV upload process");

        if (event.platformFile == null) {
          emit(UploadCsvFileFailureState(message: "No file selected"));
          return;
        }

        final categoryResult = await categoryCreationUseCase.call(
          CertificateCategoryCreationUseCaseParams(
            facultyName: event.institutionFacultyName,
            preferredCategoryName: event.categoryName,
            institutionId: event.institutionID,
            institutionFacultyId: event.institutionFacultyID,
          ),
        );

        if (categoryResult.isLeft()) {
          emit(
            UploadCsvFileFailureState(
              message: categoryResult.fold((l) => l.message, (r) => ""),
            ),
          );
          return;
        }

        final right = categoryResult.getRight().toNullable()!;
        final institutionFacultyID = right.institutionFacultyID;
        final pdfCategoryID = right.categoryID;

        final csvContent = await getCsvContent(event.platformFile!);
        AppLogger.info("CSV file loaded: ${event.platformFile!.name}");

        final certificates = await parseCsvFileInBackground(
          csvContent,
          event.institutionID,
          institutionFacultyID,
          pdfCategoryID,
          event.facultyPublicKey,
        );
        AppLogger.info("Parsed ${certificates.length} certificates");

        // Upload to server
        final uploadResult = await certificateUploadUseCase.call(
          CertificateUseCaseParams(
            certificateDataList: certificates,
            instituitonID: event.institutionID,
            institutionFacultyID: institutionFacultyID,
            institutionFacultyName: event.institutionFacultyName,
            categoryID: pdfCategoryID,
            categoryName: event.categoryName,
          ),
        );

        uploadResult.fold(
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
