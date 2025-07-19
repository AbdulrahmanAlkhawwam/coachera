class ChangePasswordParam {
  final String email;
  final String passkey;
  final String newPassword;

  ChangePasswordParam({
    required this.email,
    required this.passkey,
    required this.newPassword,
  });
}
