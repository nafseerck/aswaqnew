import 'dart:convert';

List<CartListModel> cartListModelFromJson(String str) => List<CartListModel>.from(json.decode(str).map((x) => CartListModel.fromJson(x)));

String cartListModelToJson(List<CartListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartListModel {
  int itemId;
  String sku;
  int qty;
  String name;
  double price;
  String productType;
  String quoteId;

  CartListModel({
    this.itemId,
    this.sku,
    this.qty,
    this.name,
    this.price,
    this.productType,
    this.quoteId,
  });

  factory CartListModel.fromJson(Map<String, dynamic> json) => CartListModel(
    itemId: json["item_id"],
    sku: json["sku"],
    qty: json["qty"],
    name: json["name"],
    price: json["price"].toDouble(),
    productType: json["product_type"],
    quoteId: json["quote_id"],
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId,
    "sku": sku,
    "qty": qty,
    "name": name,
    "price": price,
    "product_type": productType,
    "quote_id": quoteId,
  };
}
