abstract class AuthenticationEvent {}

class CreateInstitutionUserEvent extends AuthenticationEvent {
  final String institutionName;
  final int wardNumber;
  final String toleAddress;
  final String districtAddress;
  CreateInstitutionUserEvent({
    required this.institutionName,
    required this.wardNumber,
    required this.toleAddress,
    required this.districtAddress,
  });
}
