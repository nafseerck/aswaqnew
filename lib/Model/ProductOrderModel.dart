import 'dart:convert';

ProductOrdertModel productOrdertModelFromJson(String str) => ProductOrdertModel.fromJson(json.decode(str));

String productOrdertModelToJson(ProductOrdertModel data) => json.encode(data.toJson());

class ProductOrdertModel {
  ProductOrdertModel({
    this.items,
    this.searchCriteria,
    this.totalCount,
  });

  List<ProductOrdertModelItem> items;
  SearchCriteria searchCriteria;
  int totalCount;

  factory ProductOrdertModel.fromJson(Map<String, dynamic> json) => ProductOrdertModel(
    items: List<ProductOrdertModelItem>.from(json["items"].map((x) => ProductOrdertModelItem.fromJson(x))),
    searchCriteria: SearchCriteria.fromJson(json["search_criteria"]),
    totalCount: json["total_count"],
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "search_criteria": searchCriteria.toJson(),
    "total_count": totalCount,
  };
}

class ProductOrdertModelItem {
  ProductOrdertModelItem({
    this.baseCurrencyCode,
    this.baseDiscountAmount,
    this.baseGrandTotal,
    this.baseDiscountTaxCompensationAmount,
    this.baseShippingAmount,
    this.baseShippingDiscountAmount,
    this.baseShippingDiscountTaxCompensationAmnt,
    this.baseShippingInclTax,
    this.baseShippingTaxAmount,
    this.baseSubtotal,
    this.baseSubtotalInclTax,
    this.baseTaxAmount,
    this.baseTotalDue,
    this.baseToGlobalRate,
    this.baseToOrderRate,
    this.billingAddressId,
    this.createdAt,
    this.customerEmail,
    this.customerFirstname,
    this.customerGroupId,
    this.customerId,
    this.customerIsGuest,
    this.customerLastname,
    this.customerNoteNotify,
    this.discountAmount,
    this.emailSent,
    this.entityId,
    this.globalCurrencyCode,
    this.grandTotal,
    this.discountTaxCompensationAmount,
    this.incrementId,
    this.isVirtual,
    this.orderCurrencyCode,
    this.protectCode,
    this.quoteId,
    this.remoteIp,
    this.shippingAmount,
    this.shippingDiscountAmount,
    this.shippingDiscountTaxCompensationAmount,
    this.shippingInclTax,
    this.shippingTaxAmount,
    this.state,
    this.status,
    this.storeCurrencyCode,
    this.storeId,
    this.storeName,
    this.storeToBaseRate,
    this.storeToOrderRate,
    this.subtotal,
    this.subtotalInclTax,
    this.taxAmount,
    this.totalDue,
    this.totalItemCount,
    this.totalQtyOrdered,
    this.updatedAt,
    this.weight,
    this.items,
    this.billingAddress,
    this.payment,
    this.statusHistories,
    this.extensionAttributes,
  });

  String baseCurrencyCode;
  int baseDiscountAmount;
  double baseGrandTotal;
  int baseDiscountTaxCompensationAmount;
  int baseShippingAmount;
  int baseShippingDiscountAmount;
  int baseShippingDiscountTaxCompensationAmnt;
  int baseShippingInclTax;
  int baseShippingTaxAmount;
  double baseSubtotal;
  double baseSubtotalInclTax;
  double baseSubtotalInvoiced;
  int baseTaxAmount;
  double baseTotalDue;
  int baseToGlobalRate;
  int baseToOrderRate;
  int billingAddressId;
  DateTime createdAt;
  String customerEmail;
  String customerFirstname;
  int customerGroupId;
  int customerId;
  int customerIsGuest;
  String customerLastname;
  int customerNoteNotify;
  int discountAmount;
  int emailSent;
  int entityId;
  String globalCurrencyCode;
  double grandTotal;
  int discountTaxCompensationAmount;
  int discountTaxCompensationInvoiced;
  String incrementId;
  int isVirtual;
  String orderCurrencyCode;
  String protectCode;
  int quoteId;
  String remoteIp;
  int shippingAmount;
  int shippingDiscountAmount;
  int shippingDiscountTaxCompensationAmount;
  int shippingInclTax;
  int shippingTaxAmount;
  String state;
  String status;
  String storeCurrencyCode;
  int storeId;
  String storeName;
  int storeToBaseRate;
  int storeToOrderRate;
  double subtotal;
  double subtotalInclTax;
  int taxAmount;
  double totalDue;
  int totalItemCount;
  int totalQtyOrdered;
  DateTime updatedAt;
  int weight;
  List<ParentItemElement> items;
  BillingAddress billingAddress;
  Payment payment;
  List<dynamic> statusHistories;
  ItemExtensionAttributes extensionAttributes;

  factory ProductOrdertModelItem.fromJson(Map<String, dynamic> json) => ProductOrdertModelItem(
    baseCurrencyCode: json["base_currency_code"],
    baseDiscountAmount: json["base_discount_amount"],
    baseGrandTotal: json["base_grand_total"].toDouble(),
    baseDiscountTaxCompensationAmount: json["base_discount_tax_compensation_amount"],
    baseShippingAmount: json["base_shipping_amount"],
    baseShippingDiscountAmount: json["base_shipping_discount_amount"],
    baseShippingDiscountTaxCompensationAmnt: json["base_shipping_discount_tax_compensation_amnt"],
    baseShippingInclTax: json["base_shipping_incl_tax"],
    baseShippingTaxAmount: json["base_shipping_tax_amount"],
    baseSubtotal: json["base_subtotal"].toDouble(),
    baseSubtotalInclTax: json["base_subtotal_incl_tax"].toDouble(),
    baseTaxAmount: json["base_tax_amount"],
    baseTotalDue: json["base_total_due"].toDouble(),
    baseToGlobalRate: json["base_to_global_rate"],
    baseToOrderRate: json["base_to_order_rate"],
    billingAddressId: json["billing_address_id"],
    createdAt: DateTime.parse(json["created_at"]),
    customerEmail: json["customer_email"],
    customerFirstname: json["customer_firstname"],
    customerGroupId: json["customer_group_id"],
    customerId: json["customer_id"],
    customerIsGuest: json["customer_is_guest"],
    customerLastname: json["customer_lastname"],
    customerNoteNotify: json["customer_note_notify"],
    discountAmount: json["discount_amount"],
    emailSent: json["email_sent"],
    entityId: json["entity_id"],
    globalCurrencyCode: json["global_currency_code"],
    grandTotal: json["grand_total"].toDouble(),
    discountTaxCompensationAmount: json["discount_tax_compensation_amount"],
    incrementId: json["increment_id"],
    isVirtual: json["is_virtual"],
    orderCurrencyCode: json["order_currency_code"],
    protectCode: json["protect_code"],
    quoteId: json["quote_id"],
    remoteIp: json["remote_ip"],
    shippingAmount: json["shipping_amount"],
    shippingDiscountAmount: json["shipping_discount_amount"],
    shippingDiscountTaxCompensationAmount: json["shipping_discount_tax_compensation_amount"],
    shippingInclTax: json["shipping_incl_tax"],
    shippingTaxAmount: json["shipping_tax_amount"],
    state: json["state"],
    status: json["status"],
    storeCurrencyCode: json["store_currency_code"],
    storeId: json["store_id"],
    storeName: json["store_name"],
    storeToBaseRate: json["store_to_base_rate"],
    storeToOrderRate: json["store_to_order_rate"],
    subtotal: json["subtotal"].toDouble(),
    subtotalInclTax: json["subtotal_incl_tax"].toDouble(),
    taxAmount: json["tax_amount"],
    totalDue: json["total_due"].toDouble(),
    totalItemCount: json["total_item_count"],
    totalQtyOrdered: json["total_qty_ordered"],
    updatedAt: DateTime.parse(json["updated_at"]),
    weight: json["weight"],
    items: List<ParentItemElement>.from(json["items"].map((x) => ParentItemElement.fromJson(x))),
    billingAddress: BillingAddress.fromJson(json["billing_address"]),
    payment: Payment.fromJson(json["payment"]),
    statusHistories: List<dynamic>.from(json["status_histories"].map((x) => x)),
    extensionAttributes: ItemExtensionAttributes.fromJson(json["extension_attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "base_currency_code": baseCurrencyCode,
    "base_discount_amount": baseDiscountAmount,
    "base_grand_total": baseGrandTotal,
    "base_discount_tax_compensation_amount": baseDiscountTaxCompensationAmount,
    "base_shipping_amount": baseShippingAmount,
    "base_shipping_discount_amount": baseShippingDiscountAmount,
    "base_shipping_discount_tax_compensation_amnt": baseShippingDiscountTaxCompensationAmnt,
    "base_shipping_incl_tax": baseShippingInclTax,
    "base_shipping_tax_amount": baseShippingTaxAmount,
    "base_subtotal": baseSubtotal,
    "base_subtotal_incl_tax": baseSubtotalInclTax,
    "base_tax_amount": baseTaxAmount,
    "base_total_due": baseTotalDue,
    "base_to_global_rate": baseToGlobalRate,
    "base_to_order_rate": baseToOrderRate,
    "billing_address_id": billingAddressId,
    "created_at": createdAt.toIso8601String(),
    "customer_email": customerEmail,
    "customer_firstname": customerFirstname,
    "customer_group_id": customerGroupId,
    "customer_id": customerId,
    "customer_is_guest": customerIsGuest,
    "customer_lastname": customerLastname,
    "customer_note_notify": customerNoteNotify,
    "discount_amount": discountAmount,
    "email_sent": emailSent,
    "entity_id": entityId,
    "global_currency_code": globalCurrencyCode,
    "grand_total": grandTotal,
    "discount_tax_compensation_amount": discountTaxCompensationAmount,
    "discount_tax_compensation_invoiced": discountTaxCompensationInvoiced,
    "increment_id": incrementId,
    "is_virtual": isVirtual,
    "order_currency_code": orderCurrencyCode,
    "protect_code": protectCode,
    "quote_id": quoteId,
    "remote_ip": remoteIp,
    "shipping_amount": shippingAmount,
    "shipping_discount_amount": shippingDiscountAmount,
    "shipping_discount_tax_compensation_amount": shippingDiscountTaxCompensationAmount,
    "shipping_incl_tax": shippingInclTax,
    "shipping_tax_amount": shippingTaxAmount,
    "state": state,
    "status": status,
    "store_currency_code": storeCurrencyCode,
    "store_id": storeId,
    "store_name": storeName,
    "store_to_base_rate": storeToBaseRate,
    "store_to_order_rate": storeToOrderRate,
    "subtotal": subtotal,
    "subtotal_incl_tax": subtotalInclTax,
    "tax_amount": taxAmount,
    "total_due": totalDue,
    "total_item_count": totalItemCount,
    "total_qty_ordered": totalQtyOrdered,
    "updated_at": updatedAt.toIso8601String(),
    "weight": weight,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "billing_address": billingAddress.toJson(),
    "payment": payment.toJson(),
    "status_histories": List<dynamic>.from(statusHistories.map((x) => x)),
    "extension_attributes": extensionAttributes.toJson(),
  };
}

class BillingAddress {
  BillingAddress({
    this.addressType,
    this.city,
    this.countryId,
    this.email,
    this.entityId,
    this.firstname,
    this.lastname,
    this.parentId,
    this.postcode,
    this.street,
    this.telephone,
  });

  String addressType;
  String city;
  String countryId;
  String email;
  int entityId;
  String firstname;
  String lastname;
  int parentId;
  dynamic postcode;
  List<String> street;
  String telephone;

  factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
    addressType: json["address_type"],
    city: json["city"],
    countryId: json["country_id"],
    email: json["email"],
    entityId: json["entity_id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    parentId: json["parent_id"],
    postcode: json["postcode"],
    street: List<String>.from(json["street"].map((x) => x)),
    telephone: json["telephone"],
  );

  Map<String, dynamic> toJson() => {
    "address_type": addressType,
    "city": city,
    "country_id": countryId,
    "email": email,
    "entity_id": entityId,
    "firstname": firstname,
    "lastname": lastname,
    "parent_id": parentId,
    "postcode": postcode,
    "street": List<dynamic>.from(street.map((x) => x)),
    "telephone": telephone,
  };
}

class ItemExtensionAttributes {
  ItemExtensionAttributes({
    this.shippingAssignments,
    this.paymentAdditionalInfo,
    this.appliedTaxes,
    this.itemAppliedTaxes,
  });

  List<ShippingAssignment> shippingAssignments;
  List<PaymentAdditionalInfo> paymentAdditionalInfo;
  List<dynamic> appliedTaxes;
  List<dynamic> itemAppliedTaxes;

  factory ItemExtensionAttributes.fromJson(Map<String, dynamic> json) => ItemExtensionAttributes(
    shippingAssignments: List<ShippingAssignment>.from(json["shipping_assignments"].map((x) => ShippingAssignment.fromJson(x))),
    paymentAdditionalInfo: List<PaymentAdditionalInfo>.from(json["payment_additional_info"].map((x) => PaymentAdditionalInfo.fromJson(x))),
    appliedTaxes: List<dynamic>.from(json["applied_taxes"].map((x) => x)),
    itemAppliedTaxes: List<dynamic>.from(json["item_applied_taxes"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "shipping_assignments": List<dynamic>.from(shippingAssignments.map((x) => x.toJson())),
    "payment_additional_info": List<dynamic>.from(paymentAdditionalInfo.map((x) => x.toJson())),
    "applied_taxes": List<dynamic>.from(appliedTaxes.map((x) => x)),
    "item_applied_taxes": List<dynamic>.from(itemAppliedTaxes.map((x) => x)),
  };
}

class PaymentAdditionalInfo {
  PaymentAdditionalInfo({
    this.key,
    this.value,
  });

  String key;
  String value;

  factory PaymentAdditionalInfo.fromJson(Map<String, dynamic> json) => PaymentAdditionalInfo(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}

class ShippingAssignment {
  ShippingAssignment({
    this.shipping,
    this.items,
  });

  Shipping shipping;
  List<ParentItemElement> items;

  factory ShippingAssignment.fromJson(Map<String, dynamic> json) => ShippingAssignment(
    shipping: Shipping.fromJson(json["shipping"]),
    items: List<ParentItemElement>.from(json["items"].map((x) => ParentItemElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "shipping": shipping.toJson(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class ParentItemElement {
  ParentItemElement({
    this.amountRefunded,
    this.baseAmountRefunded,
    this.baseDiscountAmount,
    this.baseDiscountInvoiced,
    this.baseDiscountTaxCompensationAmount,
    this.baseDiscountTaxCompensationInvoiced,
    this.baseOriginalPrice,
    this.basePrice,
    this.basePriceInclTax,
    this.baseRowInvoiced,
    this.baseRowTotal,
    this.baseRowTotalInclTax,
    this.baseTaxAmount,
    this.baseTaxInvoiced,
    this.createdAt,
    this.discountAmount,
    this.discountInvoiced,
    this.discountPercent,
    this.freeShipping,
    this.discountTaxCompensationAmount,
    this.discountTaxCompensationInvoiced,
    this.isQtyDecimal,
    this.isVirtual,
    this.itemId,
    this.name,
    this.noDiscount,
    this.orderId,
    this.originalPrice,
    this.price,
    this.priceInclTax,
    this.productId,
    this.productType,
    this.qtyCanceled,
    this.qtyInvoiced,
    this.qtyOrdered,
    this.qtyRefunded,
    this.qtyShipped,
    this.quoteItemId,
    this.rowInvoiced,
    this.rowTotal,
    this.rowTotalInclTax,
    this.rowWeight,
    this.sku,
    this.storeId,
    this.taxAmount,
    this.taxInvoiced,
    this.taxPercent,
    this.updatedAt,
    this.weeeTaxApplied,
    this.productOption,
    this.parentItemId,
    this.parentItem,
  });

  int amountRefunded;
  int baseAmountRefunded;
  int baseDiscountAmount;
  int baseDiscountInvoiced;
  int baseDiscountTaxCompensationAmount;
  int baseDiscountTaxCompensationInvoiced;
  double baseOriginalPrice;
  double basePrice;
  double basePriceInclTax;
  double baseRowInvoiced;
  double baseRowTotal;
  double baseRowTotalInclTax;
  int baseTaxAmount;
  int baseTaxInvoiced;
  DateTime createdAt;
  int discountAmount;
  int discountInvoiced;
  int discountPercent;
  int freeShipping;
  int discountTaxCompensationAmount;
  int discountTaxCompensationInvoiced;
  int isQtyDecimal;
  int isVirtual;
  int itemId;
  String name;
  int noDiscount;
  int orderId;
  double originalPrice;
  double price;
  double priceInclTax;
  int productId;
  ProductType productType;
  int qtyCanceled;
  int qtyInvoiced;
  int qtyOrdered;
  int qtyRefunded;
  int qtyShipped;
  int quoteItemId;
  double rowInvoiced;
  double rowTotal;
  double rowTotalInclTax;
  int rowWeight;
  String sku;
  int storeId;
  int taxAmount;
  int taxInvoiced;
  int taxPercent;
  DateTime updatedAt;
  WeeeTaxApplied weeeTaxApplied;
  ProductOption productOption;
  int parentItemId;
  ParentItemElement parentItem;

  factory ParentItemElement.fromJson(Map<String, dynamic> json) => ParentItemElement(
    amountRefunded: json["amount_refunded"],
    baseAmountRefunded: json["base_amount_refunded"],
    baseDiscountAmount: json["base_discount_amount"],
    baseDiscountInvoiced: json["base_discount_invoiced"],
    baseDiscountTaxCompensationAmount: json["base_discount_tax_compensation_amount"] == null ? null : json["base_discount_tax_compensation_amount"],
    baseDiscountTaxCompensationInvoiced: json["base_discount_tax_compensation_invoiced"],
    baseOriginalPrice: json["base_original_price"] == null ? null : json["base_original_price"].toDouble(),
    basePrice: json["base_price"].toDouble(),
    basePriceInclTax: json["base_price_incl_tax"] == null ? null : json["base_price_incl_tax"].toDouble(),
    baseRowInvoiced: json["base_row_invoiced"].toDouble(),
    baseRowTotal: json["base_row_total"].toDouble(),
    baseRowTotalInclTax: json["base_row_total_incl_tax"].toDouble(),
    baseTaxAmount: json["base_tax_amount"],
    baseTaxInvoiced: json["base_tax_invoiced"],
    createdAt: DateTime.parse(json["created_at"]),
    discountAmount: json["discount_amount"],
    discountInvoiced: json["discount_invoiced"],
    discountPercent: json["discount_percent"],
    freeShipping: json["free_shipping"],
    discountTaxCompensationAmount: json["discount_tax_compensation_amount"] == null ? null : json["discount_tax_compensation_amount"],
    discountTaxCompensationInvoiced: json["discount_tax_compensation_invoiced"],
    isQtyDecimal: json["is_qty_decimal"],
    isVirtual: json["is_virtual"],
    itemId: json["item_id"],
    name: json["name"],
    noDiscount: json["no_discount"],
    orderId: json["order_id"],
    originalPrice: json["original_price"].toDouble(),
    price: json["price"].toDouble(),
    priceInclTax: json["price_incl_tax"] == null ? null : json["price_incl_tax"].toDouble(),
    productId: json["product_id"],
    productType: productTypeValues.map[json["product_type"]],
    qtyCanceled: json["qty_canceled"],
    qtyInvoiced: json["qty_invoiced"],
    qtyOrdered: json["qty_ordered"],
    qtyRefunded: json["qty_refunded"],
    qtyShipped: json["qty_shipped"],
    quoteItemId: json["quote_item_id"],
    rowInvoiced: json["row_invoiced"].toDouble(),
    rowTotal: json["row_total"].toDouble(),
    rowTotalInclTax: json["row_total_incl_tax"].toDouble(),
    rowWeight: json["row_weight"],
    sku: json["sku"],
    storeId: json["store_id"],
    taxAmount: json["tax_amount"],
    taxInvoiced: json["tax_invoiced"],
    taxPercent: json["tax_percent"],
    updatedAt: DateTime.parse(json["updated_at"]),
    weeeTaxApplied: json["weee_tax_applied"] == null ? null : weeeTaxAppliedValues.map[json["weee_tax_applied"]],
    productOption: json["product_option"] == null ? null : ProductOption.fromJson(json["product_option"]),
    parentItemId: json["parent_item_id"] == null ? null : json["parent_item_id"],
    parentItem: json["parent_item"] == null ? null : ParentItemElement.fromJson(json["parent_item"]),
  );

  Map<String, dynamic> toJson() => {
    "amount_refunded": amountRefunded,
    "base_amount_refunded": baseAmountRefunded,
    "base_discount_amount": baseDiscountAmount,
    "base_discount_invoiced": baseDiscountInvoiced,
    "base_discount_tax_compensation_amount": baseDiscountTaxCompensationAmount == null ? null : baseDiscountTaxCompensationAmount,
    "base_discount_tax_compensation_invoiced": baseDiscountTaxCompensationInvoiced,
    "base_original_price": baseOriginalPrice == null ? null : baseOriginalPrice,
    "base_price": basePrice,
    "base_price_incl_tax": basePriceInclTax == null ? null : basePriceInclTax,
    "base_row_invoiced": baseRowInvoiced,
    "base_row_total": baseRowTotal,
    "base_row_total_incl_tax": baseRowTotalInclTax,
    "base_tax_amount": baseTaxAmount,
    "base_tax_invoiced": baseTaxInvoiced,
    "created_at": createdAt.toIso8601String(),
    "discount_amount": discountAmount,
    "discount_invoiced": discountInvoiced,
    "discount_percent": discountPercent,
    "free_shipping": freeShipping,
    "discount_tax_compensation_amount": discountTaxCompensationAmount == null ? null : discountTaxCompensationAmount,
    "discount_tax_compensation_invoiced": discountTaxCompensationInvoiced,
    "is_qty_decimal": isQtyDecimal,
    "is_virtual": isVirtual,
    "item_id": itemId,
    "name": name,
    "no_discount": noDiscount,
    "order_id": orderId,
    "original_price": originalPrice,
    "price": price,
    "price_incl_tax": priceInclTax == null ? null : priceInclTax,
    "product_id": productId,
    "product_type": productTypeValues.reverse[productType],
    "qty_canceled": qtyCanceled,
    "qty_invoiced": qtyInvoiced,
    "qty_ordered": qtyOrdered,
    "qty_refunded": qtyRefunded,
    "qty_shipped": qtyShipped,
    "quote_item_id": quoteItemId,
    "row_invoiced": rowInvoiced,
    "row_total": rowTotal,
    "row_total_incl_tax": rowTotalInclTax,
    "row_weight": rowWeight,
    "sku": skuValues.reverse[sku],
    "store_id": storeId,
    "tax_amount": taxAmount,
    "tax_invoiced": taxInvoiced,
    "tax_percent": taxPercent,
    "updated_at": updatedAt.toIso8601String(),
    "weee_tax_applied": weeeTaxApplied == null ? null : weeeTaxAppliedValues.reverse[weeeTaxApplied],
    "product_option": productOption == null ? null : productOption.toJson(),
    "parent_item_id": parentItemId == null ? null : parentItemId,
    "parent_item": parentItem == null ? null : parentItem.toJson(),
  };
}

class ProductOption {
  ProductOption({
    this.extensionAttributes,
  });

  ProductOptionExtensionAttributes extensionAttributes;

  factory ProductOption.fromJson(Map<String, dynamic> json) => ProductOption(
    extensionAttributes: ProductOptionExtensionAttributes.fromJson(json["extension_attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "extension_attributes": extensionAttributes.toJson(),
  };
}

class ProductOptionExtensionAttributes {
  ProductOptionExtensionAttributes({
    this.configurableItemOptions,
  });

  List<ConfigurableItemOption> configurableItemOptions;

  factory ProductOptionExtensionAttributes.fromJson(Map<String, dynamic> json) => ProductOptionExtensionAttributes(
    configurableItemOptions: List<ConfigurableItemOption>.from(json["configurable_item_options"].map((x) => ConfigurableItemOption.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "configurable_item_options": List<dynamic>.from(configurableItemOptions.map((x) => x.toJson())),
  };
}

class ConfigurableItemOption {
  ConfigurableItemOption({
    this.optionId,
    this.optionValue,
  });

  String optionId;
  int optionValue;

  factory ConfigurableItemOption.fromJson(Map<String, dynamic> json) => ConfigurableItemOption(
    optionId: json["option_id"],
    optionValue: json["option_value"],
  );

  Map<String, dynamic> toJson() => {
    "option_id": optionId,
    "option_value": optionValue,
  };
}

enum ProductType { CONFIGURABLE, VIRTUAL }

final productTypeValues = EnumValues({
  "configurable": ProductType.CONFIGURABLE,
  "virtual": ProductType.VIRTUAL
});

enum Sku { THE_1150000148250_GM, THE_1150000148500_GM, THE_130000000215_KG }

final skuValues = EnumValues({
  "1150000148-250gm": Sku.THE_1150000148250_GM,
  "1150000148-500gm": Sku.THE_1150000148500_GM,
  "1300000002-1.5kg": Sku.THE_130000000215_KG
});

enum WeeeTaxApplied { EMPTY }

final weeeTaxAppliedValues = EnumValues({
  "[]": WeeeTaxApplied.EMPTY
});

class Shipping {
  Shipping({
    this.total,
  });

  Map<String, int> total;

  factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
    total: Map.from(json["total"]).map((k, v) => MapEntry<String, int>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "total": Map.from(total).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

class Payment {
  Payment({
    this.accountStatus,
    this.additionalInformation,
    this.amountOrdered,
    this.amountPaid,
    this.baseAmountOrdered,
    this.baseAmountPaid,
    this.baseShippingAmount,
    this.baseShippingCaptured,
    this.ccLast4,
    this.entityId,
    this.method,
    this.parentId,
    this.shippingAmount,
    this.shippingCaptured,
  });

  dynamic accountStatus;
  List<String> additionalInformation;
  double amountOrdered;
  double amountPaid;
  double baseAmountOrdered;
  double baseAmountPaid;
  int baseShippingAmount;
  int baseShippingCaptured;
  dynamic ccLast4;
  int entityId;
  String method;
  int parentId;
  int shippingAmount;
  int shippingCaptured;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    accountStatus: json["account_status"],
    additionalInformation: List<String>.from(json["additional_information"].map((x) => x)),
    amountOrdered: json["amount_ordered"].toDouble(),
    amountPaid: json["amount_paid"].toDouble(),
    baseAmountOrdered: json["base_amount_ordered"].toDouble(),
    baseAmountPaid: json["base_amount_paid"].toDouble(),
    baseShippingAmount: json["base_shipping_amount"],
    baseShippingCaptured: json["base_shipping_captured"],
    ccLast4: json["cc_last4"],
    entityId: json["entity_id"],
    method: json["method"],
    parentId: json["parent_id"],
    shippingAmount: json["shipping_amount"],
    shippingCaptured: json["shipping_captured"],
  );

  Map<String, dynamic> toJson() => {
    "account_status": accountStatus,
    "additional_information": List<dynamic>.from(additionalInformation.map((x) => x)),
    "amount_ordered": amountOrdered,
    "amount_paid": amountPaid,
    "base_amount_ordered": baseAmountOrdered,
    "base_amount_paid": baseAmountPaid,
    "base_shipping_amount": baseShippingAmount,
    "base_shipping_captured": baseShippingCaptured,
    "cc_last4": ccLast4,
    "entity_id": entityId,
    "method": method,
    "parent_id": parentId,
    "shipping_amount": shippingAmount,
    "shipping_captured": shippingCaptured,
  };
}

class SearchCriteria {
  SearchCriteria({
    this.filterGroups,
  });

  List<FilterGroup> filterGroups;

  factory SearchCriteria.fromJson(Map<String, dynamic> json) => SearchCriteria(
    filterGroups: List<FilterGroup>.from(json["filter_groups"].map((x) => FilterGroup.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "filter_groups": List<dynamic>.from(filterGroups.map((x) => x.toJson())),
  };
}

class FilterGroup {
  FilterGroup({
    this.filters,
  });

  List<Filter> filters;

  factory FilterGroup.fromJson(Map<String, dynamic> json) => FilterGroup(
    filters: List<Filter>.from(json["filters"].map((x) => Filter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "filters": List<dynamic>.from(filters.map((x) => x.toJson())),
  };
}

class Filter {
  Filter({
    this.field,
    this.value,
    this.conditionType,
  });

  String field;
  String value;
  String conditionType;

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    field: json["field"],
    value: json["value"],
    conditionType: json["condition_type"],
  );

  Map<String, dynamic> toJson() => {
    "field": field,
    "value": value,
    "condition_type": conditionType,
  };
}

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
