class CouldNotFetchUserFromApiException implements Exception {}

class CouldNotUpdateUserException implements Exception {
  final String message;
  CouldNotUpdateUserException({required this.message});
}

class CouldNotUpdateUserProfileImageException implements Exception {}

class CouldNotFetchImageFromStorageException implements Exception {}
