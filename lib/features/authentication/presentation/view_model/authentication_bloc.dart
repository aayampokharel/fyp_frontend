import 'package:bloc/bloc.dart';
import 'package:flutter_dashboard/core/constants/enum.dart';
import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/user_account_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/use_case/institution_usecase.dart';
import 'package:flutter_dashboard/features/authentication/domain/use_case/user_account_usecase.dart';
import 'package:flutter_dashboard/features/authentication/presentation/view_model/authentication_event.dart';
import 'package:flutter_dashboard/features/authentication/presentation/view_model/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  InstitutionUseCase institutionUsecase;
  UserAccountUseCase userAccountUsecase;

  AuthenticationBloc({
    required this.institutionUsecase,
    required this.userAccountUsecase,
  }) : super(AuthenticationInitialState()) {
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
  }
}
