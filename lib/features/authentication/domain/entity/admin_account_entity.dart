class AdminAccountEntity {
  final String email;
  final DateTime createdAt;
  //remaning fields .

  AdminAccountEntity({required this.email, required this.createdAt});
  //// admin account entity: login for admin specific should be clickable only once then turn off the feature else map ma token gaera extra bascha and will cause errors for SSE .
  @override
  String toString() {
    // TODO: implement toString
    return 'AdminAccountEntity(email: $email, createdAt: $createdAt)';
  }
}
