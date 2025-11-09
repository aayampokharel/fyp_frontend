class AuthorityEntity {
  final String authorityName;
  final String signatureImageBase64;
  AuthorityEntity(this.authorityName, this.signatureImageBase64);

  Map<String, String> toJSON() => {
    "authority_name": authorityName,
    "signature_image_base64": signatureImageBase64,
  };
}
