class CategoriesModel {
  String? sId;
  String? categoryName;
  String? categoryDescription;
  String? categoryStatus;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CategoriesModel(
      {this.sId,
      this.categoryName,
      this.categoryDescription,
      this.categoryStatus,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryName = json['CategoryName'];
    categoryDescription = json['CategoryDescription'];
    categoryStatus = json['CategoryStatus'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['CategoryName'] = this.categoryName;
    data['CategoryDescription'] = this.categoryDescription;
    data['CategoryStatus'] = this.categoryStatus;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}