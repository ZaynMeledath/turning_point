class UserAlreadyRegisteredAuthException implements Exception {}

class UserNotFoundAuthException implements Exception {}

class MobileNumberAlreadyInUseAuthException implements Exception {}

class InvalidMobileNumberAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}

class CouldNotSignUpUserAuthException implements Exception {}

class CouldNotSignInUserAuthException implements Exception {
  final String errorMessage;

  CouldNotSignInUserAuthException({required this.errorMessage});
}

class CouldNotFetchIdTokenAuthException implements Exception {}

// Generic Exceptions

class NetworkRequestFailedAuthException implements Exception {}

class GenericAuthException implements Exception {}
