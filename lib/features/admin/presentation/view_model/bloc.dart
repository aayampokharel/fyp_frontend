import 'package:bloc/bloc.dart';
import 'package:flutter_dashboard/features/admin/domain/usecase/update_institution_is_active_status.dart';
import 'package:flutter_dashboard/features/admin/presentation/view_model/event.dart';
import 'package:flutter_dashboard/features/admin/presentation/view_model/state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminInstitutionUseCase adminInstitutionUsecase;

  AdminBloc({required this.adminInstitutionUsecase}) : super(AdminInitial()) {
    on<AdminIsActiveButtonPressedEvent>((event, emit) async {
      emit(AdminIsInstitutionButtonPressedLoadingState());
      final result = await adminInstitutionUsecase.call(
        UpdateInstitutionIsActiveStatusUseCaseParams(
          institutionID: event.institutionID,
          isActive: event.isActive,
        ),
      );
      result.fold(
        (left) => emit(
          AdminIsInstitutionButtonPressedFailureState(message: left.message),
        ),
        (right) =>
            emit(AdminIsInstitutionButtonPressedSuccessState(message: right)),
      );
    });
  }
}
