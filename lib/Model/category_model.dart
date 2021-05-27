import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    this.id,
    this.parentId,
    this.name,
    this.isActive,
    this.position,
    this.level,
    this.productCount,
    this.childrenData,
  });

  int id;
  int parentId;
  String name;
  bool isActive;
  int position;
  int level;
  int productCount;
  List<CategoryModel> childrenData;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    parentId: json["parent_id"],
    name: json["name"],
    isActive: json["is_active"],
    position: json["position"],
    level: json["level"],
    productCount: json["product_count"],
    childrenData: List<CategoryModel>.from(json["children_data"].map((x) => CategoryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "name": name,
    "is_active": isActive,
    "position": position,
    "level": level,
    "product_count": productCount,
    "children_data": List<dynamic>.from(childrenData.map((x) => x.toJson())),
  };
}
