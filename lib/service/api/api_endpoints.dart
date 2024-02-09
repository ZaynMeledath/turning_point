class ApiEndpoints {
  static const baseUrl = 'https://turningpoint.ebslonserver3.com/api';
  // static const baseUrl = 'http://192.168.1.148:4023';

  static const register = '$baseUrl/users/register';
  static const login = '$baseUrl/users/login';
  static const getUser = '$baseUrl/users/getUserById';
  static const updateUserProfile = '$baseUrl/users/update-profile';
  static const updateProfileImage = '$baseUrl/users/update-profile-image';
  static const getReels = '$baseUrl/reels/getReels';
  static const getReelsPaginated = '$baseUrl/reels/getReelsPaginated';
  static const uploads = '$baseUrl/uploads';
  static const getReelLike = '$baseUrl/reelLike/getLikeCount';
  static const likeReel = '$baseUrl/reelLike/like';
  static const pointsHistory = '$baseUrl/points/points-history';
  static const getContests = '$baseUrl/contest/getContest';
}