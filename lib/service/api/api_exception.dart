class ApiExceptions implements Exception {
  final dynamic _message;
  final dynamic _prefix;

  ApiExceptions([
    this._message,
    this._prefix,
  ]);
  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class ProfileInactiveException extends ApiExceptions {
  ProfileInactiveException([String? message])
      : super(message, 'Profile is Inactive');
}

class FetechDataException extends ApiExceptions {
  FetechDataException([String? message])
      : super(message, 'Error During Communication');
}

class BadRequestException extends ApiExceptions {
  BadRequestException([String? message]) : super(message, 'Invalid Request');
}

class NoContentException extends ApiExceptions {
  NoContentException([String? message]) : super(message, 'No Content ');
}

class UnauthorisedException extends ApiExceptions {
  UnauthorisedException([String? message])
      : super(message, 'Unauthorized Request');
}

class UnauthenticatedException extends ApiExceptions {
  UnauthenticatedException([String? message])
      : super(message, 'Unauthenticated');
}

class InvalidInputException extends ApiExceptions {
  InvalidInputException([String? message]) : super(message, 'Invalid Input');
}

class FetchDataException implements Exception {
  final String message;

  FetchDataException(this.message);

  @override
  String toString() {
    return message;
  }
}

class ForbiddenException implements Exception {
  final String message;

  ForbiddenException(this.message);

  @override
  String toString() {
    return 'ForbiddenException: $message';
  }
}

class NotFoundException implements Exception {
  final String message;

  NotFoundException(this.message);

  @override
  String toString() {
    return 'NotFoundException: $message';
  }
}

class ServerErrorException implements Exception {
  final String message;

  ServerErrorException(this.message);
  @override
  String toString() {
    return 'ServerErrorException: $message';
  }
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException(this.message);

  @override
  String toString() {
    return message;
  }
}

class CustomException implements Exception {
  final String message;

  CustomException(this.message);
  @override
  String toString() {
    return 'ServerErrorException: $message';
  }
}
