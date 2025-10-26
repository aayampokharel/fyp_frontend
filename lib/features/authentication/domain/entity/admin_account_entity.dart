class AdminAccountEntity {
  final String email;
  final String sseToken;
  final DateTime createdAt;
  //remaning fields .

  AdminAccountEntity({
    required this.email,
    required this.sseToken,
    required this.createdAt,
  });

  @override
  String toString() {
    // TODO: implement toString
    return 'AdminAccountEntity(email: $email, sseToken: $sseToken, createdAt: $createdAt)';
  }
}
