class ContractorModel {
  String? message;
  List<Data>? data;
  bool? success;

  ContractorModel({this.message, this.data, this.success});

  ContractorModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? shopName;

  Data({this.name, this.shopName});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    shopName = json['shopName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['shopName'] = shopName;
    return data;
  }
}
