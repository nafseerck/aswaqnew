// To parse this JSON data, do
//
//     final popularModel = popularModelFromJson(jsonString);

import 'dart:convert';

PopularModel popularModelFromJson(String str) => PopularModel.fromJson(json.decode(str));

String popularModelToJson(PopularModel data) => json.encode(data.toJson());

class PopularModel {
  PopularModel({
    this.items,
    this.searchCriteria,
    this.totalCount,
  });

  List<Item> items;
  dynamic searchCriteria;
  int totalCount;

  factory PopularModel.fromJson(Map<String, dynamic> json) => PopularModel(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    searchCriteria: json["search_criteria"],
    totalCount: json["total_count"],
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "search_criteria": searchCriteria,
    "total_count": totalCount,
  };
}

class Item {
  Item({
    this.id,
    this.sku,
    this.name,
    this.attributeSetId,
    this.price,
    this.status,
    this.visibility,
    this.typeId,
    this.createdAt,
    this.updatedAt,
    this.productLinks,
    this.tierPrices,
    this.customAttributes,
  });

  int id;
  String sku;
  String name;
  int attributeSetId;
  double price;
  int status;
  int visibility;
  TypeId typeId;
  DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> productLinks;
  List<dynamic> tierPrices;
  List<CustomAttribute> customAttributes;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    sku: json["sku"],
    name: json["name"],
    attributeSetId: json["attribute_set_id"],
    price: json["price"].toDouble(),
    status: json["status"],
    visibility: json["visibility"],
    typeId: typeIdValues.map[json["type_id"]],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    productLinks: List<dynamic>.from(json["product_links"].map((x) => x)),
    tierPrices: List<dynamic>.from(json["tier_prices"].map((x) => x)),
    customAttributes: List<CustomAttribute>.from(json["custom_attributes"].map((x) => CustomAttribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sku": sku,
    "name": name,
    "attribute_set_id": attributeSetId,
    "price": price,
    "status": status,
    "visibility": visibility,
    "type_id": typeIdValues.reverse[typeId],
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "product_links": List<dynamic>.from(productLinks.map((x) => x)),
    "tier_prices": List<dynamic>.from(tierPrices.map((x) => x)),
    "custom_attributes": List<dynamic>.from(customAttributes.map((x) => x.toJson())),
  };
}

class CustomAttribute {
  CustomAttribute({
    this.attributeCode,
    this.value,
  });

  String attributeCode;
  dynamic value;

  factory CustomAttribute.fromJson(Map<String, dynamic> json) => CustomAttribute(
    attributeCode: json["attribute_code"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "attribute_code": attributeCode,
    "value": value,
  };
}

enum TypeId { SIMPLE }

final typeIdValues = EnumValues({
  "simple": TypeId.SIMPLE
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
