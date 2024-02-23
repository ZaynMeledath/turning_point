class CouponModel {
  String? message;
  bool? success;
  int? points;

  CouponModel({this.message, this.success, this.points});

  CouponModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['success'] = success;
    data['points'] = points;
    return data;
  }
}
