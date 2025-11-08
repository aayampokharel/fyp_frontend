import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dashboard/core/constants/enum.dart';
import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/admin_account_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/faculty_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institute_account_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/user_account_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/use_case/admin_account_usecase.dart';
import 'package:flutter_dashboard/features/authentication/domain/use_case/faculty_usecase.dart';
import 'package:flutter_dashboard/features/authentication/domain/use_case/institute_login_usecase.dart';
import 'package:flutter_dashboard/features/authentication/domain/use_case/institution_usecase.dart';
import 'package:flutter_dashboard/features/authentication/domain/use_case/remove_background_usecase.dart';
import 'package:flutter_dashboard/features/authentication/domain/use_case/user_account_usecase.dart';
import 'package:flutter_dashboard/features/authentication/presentation/view_model/authentication_event.dart';
import 'package:flutter_dashboard/features/authentication/presentation/view_model/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  InstitutionUseCase institutionUsecase;
  InstituteAccountUseCase instituteAccountUsecase;
  UserAccountUseCase userAccountUsecase;
  FacultyUseCase facultyUsecase;
  RemoveBackgroundUseCase removeBackgroundUsecase;

  AdminAccountUseCase adminAccountUsecase;

  AuthenticationBloc({
    required this.institutionUsecase,
    required this.userAccountUsecase,
    required this.facultyUsecase,
    required this.adminAccountUsecase,
    required this.instituteAccountUsecase,
    required this.removeBackgroundUsecase,
  }) : super(AuthenticationInitialState()) {
    on<CreateFacultyEvent>((event, emit) async {
      emit(AuthenticationLoadingState());
      FacultyUseCaseParams facultyParams = FacultyUseCaseParams(
        facultyEntity: FacultyEntity(
          facultyPublicKey: "",
          institutionFacultyID: "",
          institutionID: event.institutionID,
          facultyName: "event.faculty",
          //! to include the signature in a map and things
          facultyAuthorityWithSignatures: [],
          universityAffiliation: "event.universityAffiliation",
          universityCollegeCode: "001",
        ),
        institutionID: event.institutionID,
      );

      DefaultEitherType<FacultyEntity> facultyEntityResponse =
          await facultyUsecase.call(facultyParams);

      facultyEntityResponse.fold(
        (left) => emit(
          AuthenticationErrorState(
            displayErrorString: left.message,
            code: left.statusCode,
          ),
        ),
        (right) => emit(FacultySuccessState(right)),
      );
    });

    on<CreateInstitutionUserEvent>((event, emit) async {
      emit(AuthenticationLoadingState());
      InstitutionUseCaseParams params = InstitutionUseCaseParams(
        institutionName: event.institutionName,
        wardNumber: event.wardNumber,
        toleAddress: event.toleAddress,
        districtAddress: event.districtAddress,
      );
      DefaultEitherType<InstitutionEntity> response = await institutionUsecase
          .call(params);
      response.fold<void>(
        (left) => emit(
          AuthenticationErrorState(
            displayErrorString: left.message,
            code: left.statusCode,
          ),
        ),
        (right) => emit(AuthenticationSuccessState(institutionEntity: right)),
      );
    });

    on<AdminLoginEvent>((event, emit) async {
      emit(AuthenticationLoadingState());
      AdminAccountUseCaseParams params = AdminAccountUseCaseParams(
        email: event.email,
        password: event.password,
      );
      DefaultEitherType<AdminAccountEntity> response = await adminAccountUsecase
          .call(params);

      response.fold<void>(
        (left) => emit(
          AuthenticationErrorState(
            displayErrorString: left.message,
            code: left.statusCode,
          ),
        ),
        (right) {
          AppLogger.info(right.toString());
          emit(AdminAccountVerificationSuccessState(adminAccountEntity: right));
        },
      );
    });

    on<InstituteLoginEvent>((event, emit) async {
      emit(AuthenticationLoadingState());
      var params = InstituteAccountUseCaseParams(
        email: event.email,
        password: event.password,
      );

      DefaultEitherType<InstituteAccountEntity> response =
          await instituteAccountUsecase.call(params);

      response.fold<void>(
        (left) => emit(
          InstituteAccountVerificationFailureState(errorMsg: left.message),
        ),
        (right) {
          AppLogger.info(right.toString());
          emit(
            InstituteAccountVerificationSuccessState(
              instituteAccountEntity: right,
            ),
          );
        },
      );
    });

    on<CreateUserAccountEvent>((event, emit) async {
      emit(AuthenticationLoadingState());
      UserAccountEntityParams params = UserAccountEntityParams(
        institutionID: event.institutionID,
        password: event.password,
        institutionRole: event.institutionRole,
        systemRole: stringtoSystemRole(event.systemRole),
        institutionLogoBase64: event.institutionLogoBase64,
        email: event.email,
      );
      final res = await userAccountUsecase.call(params);
      res.fold(
        (left) => emit(
          AuthenticationErrorState(
            code: left.statusCode,
            displayErrorString: left.message,
          ),
        ),
        (right) => emit(UserAccountSuccessState(userAccountEntity: right)),
      );
    });
    on<SendImageForBackgroundRemovalEvent>((event, emit) async {
      emit(SendImageForBackgroundRemovalLoadingState());

      Uint8List imageIntList = event.pickerImageFile.bytes!;
      final response = await removeBackgroundUsecase.call(imageIntList);
      response.fold(
        (left) => emit(
          SendImageForBackgroundRemovalFailureState(errorMsg: left.message),
        ),
        (right) => emit(
          SendImageForBackgroundRemovalSuccessState(imageIntList: right),
        ),
      );
    });
  }
}
