class RewardsModelResponse {
  String? message;
  RewardsModel? data;
  bool? success;

  RewardsModelResponse({this.message, this.data, this.success});

  RewardsModelResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? RewardsModel.fromJson(json['data']) : null;
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

class RewardsModel {
  String? contestName;
  List<ContestPrizes>? contestPrizes;

  RewardsModel({this.contestName, this.contestPrizes});

  RewardsModel.fromJson(Map<String, dynamic> json) {
    contestName = json['contestName'];
    if (json['contestPrizes'] != null) {
      contestPrizes = <ContestPrizes>[];
      json['contestPrizes'].forEach((v) {
        contestPrizes!.add(ContestPrizes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contestName'] = contestName;
    if (contestPrizes != null) {
      data['contestPrizes'] = contestPrizes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContestPrizes {
  String? sId;
  String? name;
  String? description;
  String? image;
  String? contestId;
  int? rank;
  String? createdAt;
  String? updatedAt;
  int? iV;
  WinnerDetails? winnerDetails;

  ContestPrizes(
      {this.sId,
      this.name,
      this.description,
      this.image,
      this.contestId,
      this.rank,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.winnerDetails});

  ContestPrizes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    contestId = json['contestId'];
    rank = json['rank'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    winnerDetails = json['winnerDetails'] != null
        ? WinnerDetails.fromJson(json['winnerDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['contestId'] = contestId;
    data['rank'] = rank;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    if (winnerDetails != null) {
      data['winnerDetails'] = winnerDetails!.toJson();
    }
    return data;
  }
}

class WinnerDetails {
  String? name;
  String? image;

  WinnerDetails({this.name, this.image});

  WinnerDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
