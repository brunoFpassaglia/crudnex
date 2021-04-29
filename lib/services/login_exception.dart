class LoginException implements Exception {
  final String cause;

  LoginException(this.cause);

  @override
  String toString() {
    return cause;
  }
}
