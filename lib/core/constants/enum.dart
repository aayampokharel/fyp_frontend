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
