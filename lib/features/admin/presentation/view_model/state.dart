class AdminState {}

class AdminInitial extends AdminState {}

class AdminIsInstitutionButtonPressedSuccessState extends AdminState {
  String message;

  AdminIsInstitutionButtonPressedSuccessState({required this.message});
}

class AdminIsInstitutionButtonPressedFailureState extends AdminState {
  String message;

  AdminIsInstitutionButtonPressedFailureState({required this.message});
}

class AdminIsInstitutionButtonPressedLoadingState extends AdminState {}
