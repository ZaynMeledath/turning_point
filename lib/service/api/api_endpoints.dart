class ApiEndpoints {
  // static const baseUrl = 'https://turningpoint.ebslonserver3.com/api';
  static const baseUrl = 'http://192.168.1.153:4023';
  // static const baseUrl = 'http://13.126.184.197';
  // static const baseUrl = 'http://api.turningpointvapi.com';

  static const register = '$baseUrl/users/register';
  // static const login = '$baseUrl/users/login';
  static const googleSignIn = '$baseUrl/users/google-signIn';
  static const checkPhoneNumber = '$baseUrl/users/checkPhoneNumber';
  static const getUser = '$baseUrl/users/getUserById';
  static const getContractors = '$baseUrl/users/getContractors';
  static const updateUserProfile = '$baseUrl/users/update-profile';
  static const updateProfileImage = '$baseUrl/users/update-profile-image';
  static const getReels = '$baseUrl/reels/getReels';
  static const getReelsPaginated = '$baseUrl/reels/getReelsPaginated';
  static const uploads = '$baseUrl/uploads';
  static const getReelLike = '$baseUrl/reelLike/getLikeCount';
  static const likeReel = '$baseUrl/reelLike/like';
  static const pointsHistory = '$baseUrl/points/points-history-mobile';
  static const getContests = '$baseUrl/contest/getContest';
  static const getContestCoupons = '$baseUrl/contest/getContestCoupons';
  static const getCurrentContest = '$baseUrl/contest/getCurrentContest';
  static const currentContestRewards = '$baseUrl/contest/currentContestRewards';
  static const previousContestRewards =
      '$baseUrl/contest/previousContestRewards';
  static const joinContest = '$baseUrl/contest/joinContest';
  static const applyCoupon = '$baseUrl/coupon/applyCoupon';
  static const redeemPoints = '$baseUrl/points/redeem';
  static const generateCoupon = '$baseUrl/coupon/generateCoupon';
  static const monitorLocation = '$baseUrl/users/monitor-location';
}
