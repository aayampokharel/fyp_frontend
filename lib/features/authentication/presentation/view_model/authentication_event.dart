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

class CreateUserAccountEvent extends AuthenticationEvent {
  final String password;
  final String email;
  final String systemRole;
  final String institutionRole;
  final String institutionID;
  final String institutionLogoBase64;

  CreateUserAccountEvent({
    required this.password,
    required this.email,
    required this.systemRole,
    required this.institutionRole,
    required this.institutionID,
    required this.institutionLogoBase64,
  });
}
