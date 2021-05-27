// To parse this JSON data, do
//
//     final totalModel = totalModelFromJson(jsonString);

import 'dart:convert';

TotalModel totalModelFromJson(String str) => TotalModel.fromJson(json.decode(str));

String totalModelToJson(TotalModel data) => json.encode(data.toJson());

class TotalModel {
  double grandTotal;
  double baseGrandTotal;
  double subtotal;
  double baseSubtotal;
  int discountAmount;
  int baseDiscountAmount;
  double subtotalWithDiscount;
  double baseSubtotalWithDiscount;
  int shippingAmount;
  int baseShippingAmount;
  int shippingDiscountAmount;
  int baseShippingDiscountAmount;
  int taxAmount;
  int baseTaxAmount;
  dynamic weeeTaxAppliedAmount;
  int shippingTaxAmount;
  int baseShippingTaxAmount;
  double subtotalInclTax;
  int shippingInclTax;
  int baseShippingInclTax;
  String baseCurrencyCode;
  String quoteCurrencyCode;
  int itemsQty;
  List<Item> items;
  List<TotalSegment> totalSegments;

  TotalModel({
    this.grandTotal,
    this.baseGrandTotal,
    this.subtotal,
    this.baseSubtotal,
    this.discountAmount,
    this.baseDiscountAmount,
    this.subtotalWithDiscount,
    this.baseSubtotalWithDiscount,
    this.shippingAmount,
    this.baseShippingAmount,
    this.shippingDiscountAmount,
    this.baseShippingDiscountAmount,
    this.taxAmount,
    this.baseTaxAmount,
    this.weeeTaxAppliedAmount,
    this.shippingTaxAmount,
    this.baseShippingTaxAmount,
    this.subtotalInclTax,
    this.shippingInclTax,
    this.baseShippingInclTax,
    this.baseCurrencyCode,
    this.quoteCurrencyCode,
    this.itemsQty,
    this.items,
    this.totalSegments,
  });

  factory TotalModel.fromJson(Map<String, dynamic> json) => TotalModel(
    grandTotal: json["grand_total"].toDouble(),
    baseGrandTotal: json["base_grand_total"].toDouble(),
    subtotal: json["subtotal"].toDouble(),
    baseSubtotal: json["base_subtotal"].toDouble(),
    discountAmount: json["discount_amount"],
    baseDiscountAmount: json["base_discount_amount"],
    subtotalWithDiscount: json["subtotal_with_discount"].toDouble(),
    baseSubtotalWithDiscount: json["base_subtotal_with_discount"].toDouble(),
    shippingAmount: json["shipping_amount"],
    baseShippingAmount: json["base_shipping_amount"],
    shippingDiscountAmount: json["shipping_discount_amount"],
    baseShippingDiscountAmount: json["base_shipping_discount_amount"],
    taxAmount: json["tax_amount"],
    baseTaxAmount: json["base_tax_amount"],
    weeeTaxAppliedAmount: json["weee_tax_applied_amount"],
    shippingTaxAmount: json["shipping_tax_amount"],
    baseShippingTaxAmount: json["base_shipping_tax_amount"],
    subtotalInclTax: json["subtotal_incl_tax"].toDouble(),
    shippingInclTax: json["shipping_incl_tax"],
    baseShippingInclTax: json["base_shipping_incl_tax"],
    baseCurrencyCode: json["base_currency_code"],
    quoteCurrencyCode: json["quote_currency_code"],
    itemsQty: json["items_qty"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    totalSegments: List<TotalSegment>.from(json["total_segments"].map((x) => TotalSegment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "grand_total": grandTotal,
    "base_grand_total": baseGrandTotal,
    "subtotal": subtotal,
    "base_subtotal": baseSubtotal,
    "discount_amount": discountAmount,
    "base_discount_amount": baseDiscountAmount,
    "subtotal_with_discount": subtotalWithDiscount,
    "base_subtotal_with_discount": baseSubtotalWithDiscount,
    "shipping_amount": shippingAmount,
    "base_shipping_amount": baseShippingAmount,
    "shipping_discount_amount": shippingDiscountAmount,
    "base_shipping_discount_amount": baseShippingDiscountAmount,
    "tax_amount": taxAmount,
    "base_tax_amount": baseTaxAmount,
    "weee_tax_applied_amount": weeeTaxAppliedAmount,
    "shipping_tax_amount": shippingTaxAmount,
    "base_shipping_tax_amount": baseShippingTaxAmount,
    "subtotal_incl_tax": subtotalInclTax,
    "shipping_incl_tax": shippingInclTax,
    "base_shipping_incl_tax": baseShippingInclTax,
    "base_currency_code": baseCurrencyCode,
    "quote_currency_code": quoteCurrencyCode,
    "items_qty": itemsQty,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "total_segments": List<dynamic>.from(totalSegments.map((x) => x.toJson())),
  };
}

class Item {
  int itemId;
  double price;
  double basePrice;
  int qty;
  double rowTotal;
  double baseRowTotal;
  int rowTotalWithDiscount;
  int taxAmount;
  int baseTaxAmount;
  int taxPercent;
  int discountAmount;
  int baseDiscountAmount;
  int discountPercent;
  double priceInclTax;
  double basePriceInclTax;
  double rowTotalInclTax;
  double baseRowTotalInclTax;
  String options;
  dynamic weeeTaxAppliedAmount;
  dynamic weeeTaxApplied;
  String name;

  Item({
    this.itemId,
    this.price,
    this.basePrice,
    this.qty,
    this.rowTotal,
    this.baseRowTotal,
    this.rowTotalWithDiscount,
    this.taxAmount,
    this.baseTaxAmount,
    this.taxPercent,
    this.discountAmount,
    this.baseDiscountAmount,
    this.discountPercent,
    this.priceInclTax,
    this.basePriceInclTax,
    this.rowTotalInclTax,
    this.baseRowTotalInclTax,
    this.options,
    this.weeeTaxAppliedAmount,
    this.weeeTaxApplied,
    this.name,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    itemId: json["item_id"],
    price: json["price"].toDouble(),
    basePrice: json["base_price"].toDouble(),
    qty: json["qty"],
    rowTotal: json["row_total"].toDouble(),
    baseRowTotal: json["base_row_total"].toDouble(),
    rowTotalWithDiscount: json["row_total_with_discount"],
    taxAmount: json["tax_amount"],
    baseTaxAmount: json["base_tax_amount"],
    taxPercent: json["tax_percent"],
    discountAmount: json["discount_amount"],
    baseDiscountAmount: json["base_discount_amount"],
    discountPercent: json["discount_percent"],
    priceInclTax: json["price_incl_tax"].toDouble(),
    basePriceInclTax: json["base_price_incl_tax"].toDouble(),
    rowTotalInclTax: json["row_total_incl_tax"].toDouble(),
    baseRowTotalInclTax: json["base_row_total_incl_tax"].toDouble(),
    options: json["options"],
    weeeTaxAppliedAmount: json["weee_tax_applied_amount"],
    weeeTaxApplied: json["weee_tax_applied"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId,
    "price": price,
    "base_price": basePrice,
    "qty": qty,
    "row_total": rowTotal,
    "base_row_total": baseRowTotal,
    "row_total_with_discount": rowTotalWithDiscount,
    "tax_amount": taxAmount,
    "base_tax_amount": baseTaxAmount,
    "tax_percent": taxPercent,
    "discount_amount": discountAmount,
    "base_discount_amount": baseDiscountAmount,
    "discount_percent": discountPercent,
    "price_incl_tax": priceInclTax,
    "base_price_incl_tax": basePriceInclTax,
    "row_total_incl_tax": rowTotalInclTax,
    "base_row_total_incl_tax": baseRowTotalInclTax,
    "options": options,
    "weee_tax_applied_amount": weeeTaxAppliedAmount,
    "weee_tax_applied": weeeTaxApplied,
    "name": name,
  };
}

class TotalSegment {
  String code;
  String title;
  double value;
  ExtensionAttributes extensionAttributes;
  String area;

  TotalSegment({
    this.code,
    this.title,
    this.value,
    this.extensionAttributes,
    this.area,
  });

  factory TotalSegment.fromJson(Map<String, dynamic> json) => TotalSegment(
    code: json["code"],
    title: json["title"],
    value: json["value"].toDouble(),
    extensionAttributes: json["extension_attributes"] == null ? null : ExtensionAttributes.fromJson(json["extension_attributes"]),
    area: json["area"] == null ? null : json["area"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "title": title,
    "value": value,
    "extension_attributes": extensionAttributes == null ? null : extensionAttributes.toJson(),
    "area": area == null ? null : area,
  };
}

class ExtensionAttributes {
  List<dynamic> taxGrandtotalDetails;

  ExtensionAttributes({
    this.taxGrandtotalDetails,
  });

  factory ExtensionAttributes.fromJson(Map<String, dynamic> json) => ExtensionAttributes(
    taxGrandtotalDetails: List<dynamic>.from(json["tax_grandtotal_details"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "tax_grandtotal_details": List<dynamic>.from(taxGrandtotalDetails.map((x) => x)),
  };
}
