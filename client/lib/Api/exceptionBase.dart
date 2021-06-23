class AppException {
  final _message;
  final _prefix;

  AppException(this._message, this._prefix);
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException(String message)
      : super(message, "Error During communication: ");
}
