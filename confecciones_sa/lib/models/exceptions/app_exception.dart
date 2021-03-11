class AppException implements Exception {
  final int code;

  AppException([this.code]);
}

class ErrorsCode {
  static const USER_EXIST = 1001;
  static const USER_NOT_EXIST = 1002;
  static const USER_INVALID_PASSWORD = 1003;

}
