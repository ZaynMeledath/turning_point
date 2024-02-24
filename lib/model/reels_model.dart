class ReelsModelResponse {
  String? message;
  List<ReelsModel>? data;
  bool? success;

  ReelsModelResponse({this.message, this.data, this.success});

  ReelsModelResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <ReelsModel>[];
      json['data'].forEach((v) {
        data!.add(ReelsModel.fromJson(v));
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

class ReelsModel {
  String? id;
  String? fileUrl;
  int? displayLikeAfter;
  int? points;
  bool? isVideo;
  bool? isLiked;
  bool isLikeButtonActive = false;
  int? iV;
  String? createdAt;
  String? updatedAt;

  ReelsModel({
    this.id,
    this.fileUrl,
    this.displayLikeAfter,
    this.points,
    this.isVideo,
    this.isLiked,
    this.iV,
    this.createdAt,
    this.updatedAt,
  });

  ReelsModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    fileUrl = json['fileUrl'];
    displayLikeAfter = json['displayLikeAfter'];
    points = json['points'];
    isVideo = json['isVideo'];
    // isLiked = json['likedByCurrentUser'] != null ? true : false;
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['fileUrl'] = fileUrl;
    data['displayLikeAfter'] = displayLikeAfter;
    data['points'] = points;
    data['isVideo'] = isVideo;
    data['__v'] = iV;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
