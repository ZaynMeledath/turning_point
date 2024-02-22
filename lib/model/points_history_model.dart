class PointsHistoryModelResponse {
  String? message;
  List<PointsHistoryModel>? data;
  int? limit;
  int? page;
  bool? success;

  PointsHistoryModelResponse(
      {this.message, this.data, this.limit, this.page, this.success});

  PointsHistoryModelResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <PointsHistoryModel>[];
      json['data'].forEach((v) {
        data!.add(PointsHistoryModel.fromJson(v));
      });
    }
    limit = json['limit'];
    page = json['page'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['limit'] = limit;
    data['page'] = page;
    data['success'] = success;
    return data;
  }
}

class PointsHistoryModel {
  String? id;
  String? transactionId;
  String? userId;
  int? amount;
  String? description;
  String? mobileDescription;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? origionalId;
  User? user;

  PointsHistoryModel({
    this.id,
    this.transactionId,
    this.userId,
    this.amount,
    this.description,
    this.mobileDescription,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.origionalId,
    this.user,
  });

  PointsHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    transactionId = json['transactionId'];
    userId = json['userId'];
    amount = json['amount'];
    description = json['description'];
    mobileDescription = json['mobileDescription'];
    type = json['type'];
    status = json['status'];
    createdAt = json['createdAt'].split('T')[0];
    updatedAt = json['updatedAt'];
    origionalId = json['origionalId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['transactionId'] = transactionId;
    data['userId'] = userId;
    data['amount'] = amount;
    data['description'] = description;
    data['mobileDescription'] = description;
    data['type'] = type;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['origionalId'] = origionalId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? email;
  String? phone;
  String? name;
  String? shopName;
  String? password;
  int? points;
  bool? isActive;
  String? role;

  User({
    this.sId,
    this.email,
    this.phone,
    this.name,
    this.shopName,
    this.password,
    this.points,
    this.isActive,
    this.role,
  });

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    shopName = json['shopName'];
    password = json['password'];
    points = json['points'];
    isActive = json['isActive'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['phone'] = phone;
    data['name'] = name;
    data['shopName'] = shopName;
    data['password'] = password;
    data['points'] = points;
    data['isActive'] = isActive;
    data['role'] = role;

    return data;
  }
}
