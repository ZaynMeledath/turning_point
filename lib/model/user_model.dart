import 'package:turning_point/model/contractor_model.dart';

class UserModelResponse {
  String? message;
  UserModel? data;
  bool? success;

  UserModelResponse({this.message, this.data, this.success});

  UserModelResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? UserModel.fromJson(json['data']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = success;
    return data;
  }
}

class UserModel {
  String? id;
  String? uid;
  String? email;
  String? phone;
  String? name;
  String? businessName;
  String? pincode;
  String? actualAddress;
  int? points;
  bool? isActive;
  String? role;
  ContractorModel? contractor;
  String? kycStatus;
  List<BankDetails>? bankDetails;
  List? shopImageArr;
  String? createdAt;
  String? updatedAt;
  String? image;
  String? idBackImage;
  String? idFrontImage;
  String? selfie;
  List<CouponModel>? coupons;
  int? contestParticipationCount;
  int? contestsParticipatedInCount;
  int? contestWonCount;
  int? contestUniqueWonCount;
  // List<dynamic>? address;

  UserModel({
    this.id,
    this.uid,
    this.email,
    this.phone,
    this.name,
    this.businessName,
    this.points,
    this.pincode,
    this.actualAddress,
    this.isActive,
    this.role,
    this.contractor,
    this.bankDetails,
    this.shopImageArr,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.idBackImage,
    this.idFrontImage,
    this.selfie,
    this.kycStatus,
    this.coupons,
    this.contestParticipationCount,
    this.contestsParticipatedInCount,
    this.contestWonCount,
    this.contestUniqueWonCount,
    // this.address,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    uid = json['uid'];
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    businessName = json['businessName'];
    pincode = json['pincode'];
    actualAddress = json['actualAddress'];
    points = json['points'];
    isActive = json['isActive'];
    role = json['role'];
    kycStatus = json['kycStatus'];
    contractor = json['contractor'] != null
        ? ContractorModel.fromJson(json['contractor'])
        : null;
    if (json['bankDetails'] != null) {
      bankDetails = <BankDetails>[];
      json['bankDetails'].forEach((v) {
        bankDetails!.add(BankDetails.fromJson(v));
      });
    }

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    // image = '${ApiEndpoints.uploads}/${json['image']}';
    image = json['image'];
    idBackImage = json['idBackImage'];
    idFrontImage = json['idFrontImage'];
    selfie = json['selfie'];
    coupons = json['coupons'];
    contestParticipationCount = json['contestParticipationCount'];
    contestsParticipatedInCount = json['contestsParticipatedInCount'];
    contestWonCount = json['contestWonCount'];
    contestUniqueWonCount = json['contestUniqueWonCount'];
    // address = json['address']['coordinates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['uid'] = uid;
    data['email'] = email;
    data['phone'] = phone;
    data['name'] = name;
    data['businessName'] = businessName;
    data['pincode'] = pincode;
    data['actualAddress'] = actualAddress;
    data['points'] = points;
    data['isActive'] = isActive;
    data['role'] = role;
    if (contractor != null) {
      data['contractor'] = contractor!.toJson();
    }

    if (bankDetails != null) {
      data['bankDetails'] = bankDetails!.map((item) => item.toJson()).toList();
    }

    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['image'] = image;
    data['kycStatus'] = kycStatus;
    data['idBackImage'] = idBackImage;
    data['idFrontImage'] = idFrontImage;
    data['selfie'] = selfie;
    data['coupons'] = coupons;
    data['contestParticipationCount'] = contestParticipationCount;
    data['contestsParticipatedInCount'] = contestsParticipatedInCount;
    data['contestWonCount'] = contestWonCount;
    data['contestUniqueWonCount'] = contestUniqueWonCount;
    // data['address']['coordinates'] = address?.map((e) => double.parse(e));
    return data;
  }
}

class BankDetails {
  String? banktype;
  String? accountName;
  String? accountNo;
  String? ifsc;
  String? bank;
  bool? isActive;
  String? sId;

  BankDetails(
      {this.banktype,
      this.accountName,
      this.accountNo,
      this.ifsc,
      this.bank,
      this.isActive,
      this.sId});

  BankDetails.fromJson(Map<String, dynamic> json) {
    banktype = json['banktype'];
    accountName = json['accountName'];
    accountNo = json['accountNo'];
    ifsc = json['ifsc'];
    bank = json['bank'];
    isActive = json['isActive'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['banktype'] = banktype;
    data['accountName'] = accountName;
    data['accountNo'] = accountNo;
    data['ifsc'] = ifsc;
    data['bank'] = bank;
    data['isActive'] = isActive;
    data['_id'] = sId;
    return data;
  }
}

class CouponModel {
  String? couponName;
  int? count;

  CouponModel(
    this.couponName,
    this.count,
  );

  CouponModel.fromJson(Map<String, dynamic> json) {
    couponName = json['couponName'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['couponName'] = couponName;
    data['count'] = count;
    return data;
  }
}
