import 'package:bloc/bloc.dart';
import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/use_case/institution_usecase.dart';
import 'package:flutter_dashboard/features/authentication/presentation/view_model/authentication_event.dart';
import 'package:flutter_dashboard/features/authentication/presentation/view_model/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  InstitutionUsecase institutionUsecase;

  AuthenticationBloc({required this.institutionUsecase})
    : super(AuthenticationInitial()) {
    on<CreateInstitutionUserEvent>((event, emit) async {
      emit(AuthenticationLoading());
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
          AuthenticationError(
            displayErrorString: left.message,
            code: left.code,
          ),
        ),
        (right) => emit(AuthenticationSuccess(institutionEntity: right)),
      );
    });
  }
}
