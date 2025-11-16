class AdminEvent {}

class AdminInitialEvent extends AdminEvent {}

class AdminIsActiveButtonPressedEvent extends AdminEvent {
  final String institutionID;
  final bool isActive;
  AdminIsActiveButtonPressedEvent({
    required this.institutionID,
    required this.isActive,
  });
}
