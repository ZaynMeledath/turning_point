class CarpentersListModelResponse {
  CarpentersListModel? data;

  CarpentersListModelResponse({this.data});

  CarpentersListModelResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? CarpentersListModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CarpentersListModel {
  String? contractorName;
  String? businessName;
  List<CarpenterModel>? allCarpenters;
  int? allCarpentersTotal;

  CarpentersListModel(
      {this.contractorName,
      this.businessName,
      this.allCarpenters,
      this.allCarpentersTotal});

  CarpentersListModel.fromJson(Map<String, dynamic> json) {
    contractorName = json['name'];
    businessName = json['businessName'];
    allCarpenters = <CarpenterModel>[];
    if (json['allCarpenters'] != null) {
      json['allCarpenters'].forEach((v) {
        allCarpenters!.add(CarpenterModel.fromJson(v));
      });
    }
    allCarpentersTotal = json['allCarpentersTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = contractorName;
    data['businessName'] = businessName;
    if (allCarpenters != null) {
      data['allCarpenters'] = allCarpenters!.map((v) => v.toJson()).toList();
    }
    data['allCarpentersTotal'] = allCarpentersTotal;
    return data;
  }
}

class CarpenterModel {
  String? name;
  String? image;
  int? points;

  CarpenterModel({this.name, this.image, this.points});

  CarpenterModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['points'] = points;
    return data;
  }
}
