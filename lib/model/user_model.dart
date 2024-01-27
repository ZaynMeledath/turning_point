import 'package:turning_point/service/api/api_endpoints.dart';

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
  String? email;
  String? phone;
  String? name;
  String? shopName;
  int? points;
  bool? isActive;
  String? role;
  List<BankDetails>? bankDetails;
  List? shopImageArr;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? image;
  String? idBackImage;
  String? idFrontImage;
  int? contestParticipationCount;
  int? contestsParticipatedInCount;
  int? contestWonCount;
  int? contestUniqueWonCount;

  UserModel(
      {this.id,
      this.email,
      this.phone,
      this.name,
      this.shopName,
      this.points,
      this.isActive,
      this.role,
      this.bankDetails,
      this.shopImageArr,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.image,
      this.idBackImage,
      this.idFrontImage,
      this.contestParticipationCount,
      this.contestsParticipatedInCount,
      this.contestWonCount,
      this.contestUniqueWonCount});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    shopName = json['shopName'];
    points = json['points'];
    isActive = json['isActive'];
    role = json['role'];
    if (json['bankDetails'] != null) {
      bankDetails = <BankDetails>[];
      json['bankDetails'].forEach((v) {
        bankDetails!.add(BankDetails.fromJson(v));
      });
    }

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    image = '${ApiEndpoints.uploads}/${json['image']}';
    idBackImage = json['idBackImage'];
    idFrontImage = json['idFrontImage'];
    contestParticipationCount = json['contestParticipationCount'];
    contestsParticipatedInCount = json['contestsParticipatedInCount'];
    contestWonCount = json['contestWonCount'];
    contestUniqueWonCount = json['contestUniqueWonCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['email'] = email;
    data['phone'] = phone;
    data['name'] = name;
    data['shopName'] = shopName;
    data['points'] = points;
    data['isActive'] = isActive;
    data['role'] = role;
    if (bankDetails != null) {
      data['bankDetails'] = bankDetails!.map((v) => v.toJson()).toList();
    }

    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['image'] = image;
    data['idBackImage'] = idBackImage;
    data['idFrontImage'] = idFrontImage;
    data['contestParticipationCount'] = contestParticipationCount;
    data['contestsParticipatedInCount'] = contestsParticipatedInCount;
    data['contestWonCount'] = contestWonCount;
    data['contestUniqueWonCount'] = contestUniqueWonCount;
    return data;
  }
}

class BankDetails {
  String? banktype;
  String? accountName;
  int? accountNo;
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
