enum SystemRole { admin, institute, user }

String systemRoletoString(SystemRole role) {
  switch (role) {
    case SystemRole.admin:
      return "ADMIN";
    case SystemRole.institute:
      return "INSTITUTE";
    default:
      return "USER";
  }
}

SystemRole stringtoSystemRole(String role) {
  String roleUpper = role.toUpperCase();
  switch (roleUpper) {
    case "ADMIN":
      return SystemRole.admin;
    case "INSTITUTE":
      return SystemRole.institute;
    default:
      return SystemRole.user;
  }
}

enum SSEType {
  sseSingleForm('SSESINGLEFORM'),
  sseApproval('SSEAPPROVAL');

  const SSEType(this.value);
  final String value;

  // Convert from string
  static SSEType fromString(String value) {
    switch (value) {
      case 'SSESINGLEFORM':
        return SSEType.sseSingleForm;
      case 'SSEAPPROVAL':
        return SSEType.sseApproval;
      default:
        throw ArgumentError('Unknown SSEType: $value');
    }
  }

  // Convert to string
  @override
  String toString() => value;
}
