class ReferralModelResponse {
  ReferralModel? data;

  ReferralModelResponse({this.data});

  ReferralModelResponse.fromJson(Map<String, dynamic> json) {
    data = json['user'] != null ? ReferralModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['user'] = this.data!.toJson();
    }
    return data;
  }
}

class ReferralModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  List<Referrals>? referrals;
  List<ReferralRewards>? referralRewards;
  int? totalReferrals;
  int? totalRewardPointsEarned;

  ReferralModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.referrals,
      this.referralRewards,
      this.totalReferrals,
      this.totalRewardPointsEarned});

  ReferralModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    if (json['referrals'] != null) {
      referrals = <Referrals>[];
      json['referrals'].forEach((v) {
        referrals!.add(Referrals.fromJson(v));
      });
    }
    if (json['referralRewards'] != null) {
      referralRewards = <ReferralRewards>[];
      json['referralRewards'].forEach((v) {
        referralRewards!.add(ReferralRewards.fromJson(v));
      });
    }
    totalReferrals = json['totalReferrals'];
    totalRewardPointsEarned = json['totalRewardPointsEarned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    if (referrals != null) {
      data['referrals'] = referrals!.map((v) => v.toJson()).toList();
    }
    if (referralRewards != null) {
      data['referralRewards'] =
          referralRewards!.map((v) => v.toJson()).toList();
    }
    data['totalReferrals'] = totalReferrals;
    data['totalRewardPointsEarned'] = totalRewardPointsEarned;
    return data;
  }
}

class Referrals {
  String? sId;
  String? name;

  Referrals({this.sId, this.name});

  Referrals.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    return data;
  }
}

class ReferralRewards {
  String? id;
  String? userId;
  String? name;
  int? value;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ReferralRewards(
      {this.id,
      this.userId,
      this.name,
      this.value,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ReferralRewards.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    name = json['name'];
    value = json['value'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['userId'] = userId;
    data['name'] = name;
    data['value'] = value;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
