class CouponModel {
  String? message;
  int? points;

  CouponModel({this.message, this.points});

  CouponModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['points'] = points;
    return data;
  }
}
