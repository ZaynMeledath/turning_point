class ReelModel {
  String? message;
  List<Data>? data;
  bool? success;

  ReelModel({this.message, this.data, this.success});

  ReelModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? sId;
  String? fileUrl;
  int? displayLikeAfter;
  int? points;
  bool? isVideo;
  int? iV;
  String? createdAt;
  String? updatedAt;

  Data({
    this.sId,
    this.fileUrl,
    this.displayLikeAfter,
    this.points,
    this.isVideo,
    this.iV,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fileUrl = json['fileUrl'];
    displayLikeAfter = json['displayLikeAfter'];
    points = json['points'];
    isVideo = json['isVideo'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
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
