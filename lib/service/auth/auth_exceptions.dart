// Sign in Exceptions

class UserNotFoundAuthException implements Exception {}

// Sign up Exceptions

class MobileNumberAlreadyInUseAuthException implements Exception {}

class InvalidMobileNumberAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}

class CouldNotSignUpUserAuthException implements Exception {}

// Generic Exceptions

class NetworkRequestFailedAuthException implements Exception {}

class GenericAuthException implements Exception {}
