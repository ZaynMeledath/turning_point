class ApiEndpoints {
  static const baseUrl = 'https://turningpoint.ebslonserver3.com/api';

  static const register = '$baseUrl/users/register';
  static const login = '$baseUrl/users/login';
  static const getUser = '$baseUrl/users/getUserById';
  static const updateUserProfile = '$baseUrl/users/update-profile';
  static const getReels = '$baseUrl/reels/getReels';
  static const getReelsPaginated = '$baseUrl/reels/getReelsPaginated';
  static const uploads = '$baseUrl/uploads';
  static const getReelLike = '$baseUrl/reelLike/getLikeCount';
  static const likeReel = '$baseUrl/reelLike/like';
  static const pointsHistory = '$baseUrl/points/points-history';
}
