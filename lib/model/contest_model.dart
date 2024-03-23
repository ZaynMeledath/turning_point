class ContestModelResponse {
  String? message;
  List<ContestModel>? data;
  bool? success;

  ContestModelResponse({this.message, this.data, this.success});

  ContestModelResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <ContestModel>[];
      json['data'].forEach((v) {
        data!.add(ContestModel.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    return data;
  }
}

class ContestModel {
  String? id;
  String? name;
  String? contestId;
  String? subtitle;
  String? image;
  int? points;
  String? description;
  List<String>? rulesArr;
  int? userJoinedCount;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? status;
  int? userJoin;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? combinedStartDateTime;
  String? combinedEndDateTime;
  List<PrizeArr>? prizeArr;

  ContestModel(
      {this.id,
      this.name,
      this.contestId,
      this.subtitle,
      this.image,
      this.points,
      this.description,
      this.userJoinedCount,
      this.rulesArr,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.status,
      this.userJoin,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.combinedStartDateTime,
      this.combinedEndDateTime,
      this.prizeArr});

  ContestModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    contestId = json['contestId'];
    subtitle = json['subtitle'];
    image = json['image'];
    points = json['points'];
    description = json['description'];
    userJoinedCount = json['userJoinCount'];
    rulesArr = json['rulesArr'].cast<String>();
    startDate = json['startDate'];
    endDate = json['endDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    status = json['status'];
    userJoin = json['userJoin'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    combinedStartDateTime = json['combinedStartDateTime'];
    combinedEndDateTime = json['combinedEndDateTime'];
    if (json['prizeArr'] != null) {
      prizeArr = <PrizeArr>[];
      json['prizeArr'].forEach((v) {
        prizeArr!.add(PrizeArr.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['contestId'] = contestId;
    data['subtitle'] = subtitle;
    data['image'] = image;
    data['points'] = points;
    data['description'] = description;
    data['userJoinCount'] = userJoinedCount;
    data['rulesArr'] = rulesArr;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['status'] = status;
    data['userJoin'] = userJoin;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['combinedStartDateTime'] = combinedStartDateTime;
    data['combinedEndDateTime'] = combinedEndDateTime;
    if (prizeArr != null) {
      data['prizeArr'] = prizeArr!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PrizeArr {
  String? id;
  String? name;
  String? description;
  String? contestId;
  String? image;
  int? rank;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PrizeArr(
      {this.id,
      this.name,
      this.description,
      this.contestId,
      this.image,
      this.rank,
      this.createdAt,
      this.updatedAt,
      this.iV});

  PrizeArr.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    description = json['description'];
    contestId = json['contestId'];
    rank = json['rank'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['contestId'] = contestId;
    data['rank'] = rank;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
