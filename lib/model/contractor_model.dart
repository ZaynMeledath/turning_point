class ContractorModelResponse {
  String? message;
  List<ContractorModel>? data;
  bool? success;

  ContractorModelResponse({this.message, this.data, this.success});

  ContractorModelResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <ContractorModel>[];
      json['data'].forEach((v) {
        data!.add(ContractorModel.fromJson(v));
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

class ContractorModel {
  String? name;
  String? businessName;

  ContractorModel({this.name, this.businessName});

  ContractorModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    businessName = json['businessName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['businessName'] = businessName;
    return data;
  }
}
