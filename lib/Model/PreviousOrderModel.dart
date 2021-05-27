
import 'dart:convert';

PeviousOrderModel peviousOrderModelFromJson(String str) => PeviousOrderModel.fromJson(json.decode(str));

String peviousOrderModelToJson(PeviousOrderModel data) => json.encode(data.toJson());

class PeviousOrderModel {
  PeviousOrderModel({
    this.items,
    this.searchCriteria,
    this.totalCount,
  });

  List<PeviousOrderModelItem> items;
  SearchCriteria searchCriteria;
  int totalCount;

  factory PeviousOrderModel.fromJson(Map<String, dynamic> json) => PeviousOrderModel(
    items: List<PeviousOrderModelItem>.from(json["items"].map((x) => PeviousOrderModelItem.fromJson(x))),
    searchCriteria: SearchCriteria.fromJson(json["search_criteria"]),
    totalCount: json["total_count"],
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "search_criteria": searchCriteria.toJson(),
    "total_count": totalCount,
  };
}

class PeviousOrderModelItem {
  PeviousOrderModelItem({
    this.baseCurrencyCode,
    this.baseDiscountAmount,
    this.baseDiscountInvoiced,
    this.baseGrandTotal,
    this.baseDiscountTaxCompensationAmount,
    this.baseDiscountTaxCompensationInvoiced,
    this.baseShippingAmount,
    this.baseShippingDiscountAmount,
    this.baseShippingDiscountTaxCompensationAmnt,
    this.baseShippingInclTax,
    this.baseShippingInvoiced,
    this.baseShippingTaxAmount,
    this.baseSubtotal,
    this.baseSubtotalInclTax,
    this.baseSubtotalInvoiced,
    this.baseTaxAmount,
    this.baseTaxInvoiced,
    this.baseTotalDue,
    this.baseTotalInvoiced,
    this.baseTotalInvoicedCost,
    this.baseTotalPaid,
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
    this.discountInvoiced,
    this.emailSent,
    this.entityId,
    this.globalCurrencyCode,
    this.grandTotal,
    this.discountTaxCompensationAmount,
    this.discountTaxCompensationInvoiced,
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
    this.shippingInvoiced,
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
    this.subtotalInvoiced,
    this.taxAmount,
    this.taxInvoiced,
    this.totalDue,
    this.totalInvoiced,
    this.totalItemCount,
    this.totalPaid,
    this.totalQtyOrdered,
    this.updatedAt,
    this.weight,
    this.items,
    this.billingAddress,
    this.payment,
    this.statusHistories,
    this.extensionAttributes,
    this.shippingDescription,
    this.appliedRuleIds,
    this.couponCode,
    this.discountDescription,
  });

  String baseCurrencyCode;
  int baseDiscountAmount;
  int baseDiscountInvoiced;
  double baseGrandTotal;
  int baseDiscountTaxCompensationAmount;
  int baseDiscountTaxCompensationInvoiced;
  int baseShippingAmount;
  int baseShippingDiscountAmount;
  int baseShippingDiscountTaxCompensationAmnt;
  int baseShippingInclTax;
  int baseShippingInvoiced;
  int baseShippingTaxAmount;
  double baseSubtotal;
  double baseSubtotalInclTax;
  double baseSubtotalInvoiced;
  int baseTaxAmount;
  int baseTaxInvoiced;
  int baseTotalDue;
  double baseTotalInvoiced;
  int baseTotalInvoicedCost;
  double baseTotalPaid;
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
  int discountInvoiced;
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
  int shippingInvoiced;
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
  double subtotalInvoiced;
  int taxAmount;
  int taxInvoiced;
  int totalDue;
  double totalInvoiced;
  int totalItemCount;
  double totalPaid;
  int totalQtyOrdered;
  DateTime updatedAt;
  int weight;
  List<ParentItemElement> items;
  Address billingAddress;
  Payment payment;
  List<dynamic> statusHistories;
  ItemExtensionAttributes extensionAttributes;
  String shippingDescription;
  String appliedRuleIds;
  String couponCode;
  String discountDescription;

  factory PeviousOrderModelItem.fromJson(Map<String, dynamic> json) => PeviousOrderModelItem(
    baseCurrencyCode: json["base_currency_code"],
    baseDiscountAmount: json["base_discount_amount"],
    baseDiscountInvoiced: json["base_discount_invoiced"],
    baseGrandTotal: json["base_grand_total"].toDouble(),
    baseDiscountTaxCompensationAmount: json["base_discount_tax_compensation_amount"],
    baseDiscountTaxCompensationInvoiced: json["base_discount_tax_compensation_invoiced"],
    baseShippingAmount: json["base_shipping_amount"],
    baseShippingDiscountAmount: json["base_shipping_discount_amount"],
    baseShippingDiscountTaxCompensationAmnt: json["base_shipping_discount_tax_compensation_amnt"],
    baseShippingInclTax: json["base_shipping_incl_tax"],
    baseShippingInvoiced: json["base_shipping_invoiced"],
    baseShippingTaxAmount: json["base_shipping_tax_amount"],
    baseSubtotal: json["base_subtotal"].toDouble(),
    baseSubtotalInclTax: json["base_subtotal_incl_tax"].toDouble(),
    baseSubtotalInvoiced: json["base_subtotal_invoiced"].toDouble(),
    baseTaxAmount: json["base_tax_amount"],
    baseTaxInvoiced: json["base_tax_invoiced"],
    baseTotalDue: json["base_total_due"],
    baseTotalInvoiced: json["base_total_invoiced"].toDouble(),
    baseTotalInvoicedCost: json["base_total_invoiced_cost"],
    baseTotalPaid: json["base_total_paid"].toDouble(),
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
    discountInvoiced: json["discount_invoiced"],
    emailSent: json["email_sent"],
    entityId: json["entity_id"],
    globalCurrencyCode: json["global_currency_code"],
    grandTotal: json["grand_total"].toDouble(),
    discountTaxCompensationAmount: json["discount_tax_compensation_amount"],
    discountTaxCompensationInvoiced: json["discount_tax_compensation_invoiced"],
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
    shippingInvoiced: json["shipping_invoiced"],
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
    subtotalInvoiced: json["subtotal_invoiced"].toDouble(),
    taxAmount: json["tax_amount"],
    taxInvoiced: json["tax_invoiced"],
    totalDue: json["total_due"],
    totalInvoiced: json["total_invoiced"].toDouble(),
    totalItemCount: json["total_item_count"],
    totalPaid: json["total_paid"].toDouble(),
    totalQtyOrdered: json["total_qty_ordered"],
    updatedAt: DateTime.parse(json["updated_at"]),
    weight: json["weight"],
    items: List<ParentItemElement>.from(json["items"].map((x) => ParentItemElement.fromJson(x))),
    billingAddress: Address.fromJson(json["billing_address"]),
    payment: Payment.fromJson(json["payment"]),
    statusHistories: List<dynamic>.from(json["status_histories"].map((x) => x)),
    extensionAttributes: ItemExtensionAttributes.fromJson(json["extension_attributes"]),
    shippingDescription: json["shipping_description"] == null ? null : json["shipping_description"],
    appliedRuleIds: json["applied_rule_ids"] == null ? null : json["applied_rule_ids"],
    couponCode: json["coupon_code"] == null ? null : json["coupon_code"],
    discountDescription: json["discount_description"] == null ? null : json["discount_description"],
  );

  Map<String, dynamic> toJson() => {
    "base_currency_code": baseCurrencyCode,
    "base_discount_amount": baseDiscountAmount,
    "base_discount_invoiced": baseDiscountInvoiced,
    "base_grand_total": baseGrandTotal,
    "base_discount_tax_compensation_amount": baseDiscountTaxCompensationAmount,
    "base_discount_tax_compensation_invoiced": baseDiscountTaxCompensationInvoiced,
    "base_shipping_amount": baseShippingAmount,
    "base_shipping_discount_amount": baseShippingDiscountAmount,
    "base_shipping_discount_tax_compensation_amnt": baseShippingDiscountTaxCompensationAmnt,
    "base_shipping_incl_tax": baseShippingInclTax,
    "base_shipping_invoiced": baseShippingInvoiced,
    "base_shipping_tax_amount": baseShippingTaxAmount,
    "base_subtotal": baseSubtotal,
    "base_subtotal_incl_tax": baseSubtotalInclTax,
    "base_subtotal_invoiced": baseSubtotalInvoiced,
    "base_tax_amount": baseTaxAmount,
    "base_tax_invoiced": baseTaxInvoiced,
    "base_total_due": baseTotalDue,
    "base_total_invoiced": baseTotalInvoiced,
    "base_total_invoiced_cost": baseTotalInvoicedCost,
    "base_total_paid": baseTotalPaid,
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
    "discount_invoiced": discountInvoiced,
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
    "shipping_invoiced": shippingInvoiced,
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
    "subtotal_invoiced": subtotalInvoiced,
    "tax_amount": taxAmount,
    "tax_invoiced": taxInvoiced,
    "total_due": totalDue,
    "total_invoiced": totalInvoiced,
    "total_item_count": totalItemCount,
    "total_paid": totalPaid,
    "total_qty_ordered": totalQtyOrdered,
    "updated_at": updatedAt.toIso8601String(),
    "weight": weight,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "billing_address": billingAddress.toJson(),
    "payment": payment.toJson(),
    "status_histories": List<dynamic>.from(statusHistories.map((x) => x)),
    "extension_attributes": extensionAttributes.toJson(),
    "shipping_description": shippingDescription == null ? null : shippingDescription,
    "applied_rule_ids": appliedRuleIds == null ? null : appliedRuleIds,
    "coupon_code": couponCode == null ? null : couponCode,
    "discount_description": discountDescription == null ? null : discountDescription,
  };
}

class Address {
  Address({
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
    this.company,
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
  String company;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
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
    company: json["company"] == null ? null : json["company"],
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
    "company": company == null ? null : company,
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
    this.weight,
    this.appliedRuleIds,
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
  int weight;
  String appliedRuleIds;

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
    weight: json["weight"] == null ? null : json["weight"],
    appliedRuleIds: json["applied_rule_ids"] == null ? null : json["applied_rule_ids"],
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
    "sku": sku,
    "store_id": storeId,
    "tax_amount": taxAmount,
    "tax_invoiced": taxInvoiced,
    "tax_percent": taxPercent,
    "updated_at": updatedAt.toIso8601String(),
    "weee_tax_applied": weeeTaxApplied == null ? null : weeeTaxAppliedValues.reverse[weeeTaxApplied],
    "product_option": productOption == null ? null : productOption.toJson(),
    "parent_item_id": parentItemId == null ? null : parentItemId,
    "parent_item": parentItem == null ? null : parentItem.toJson(),
    "weight": weight == null ? null : weight,
    "applied_rule_ids": appliedRuleIds == null ? null : appliedRuleIds,
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

enum ProductType { CONFIGURABLE, VIRTUAL, SIMPLE }

final productTypeValues = EnumValues({
  "configurable": ProductType.CONFIGURABLE,
  "simple": ProductType.SIMPLE,
  "virtual": ProductType.VIRTUAL
});

enum Sku { THE_1150000148250_GM, THE_1150000148500_GM, THE_130000000215_KG, THE_1190001457_EA }



enum WeeeTaxApplied { EMPTY }

final weeeTaxAppliedValues = EnumValues({
  "[]": WeeeTaxApplied.EMPTY
});

class Shipping {
  Shipping({
    this.total,
    this.address,
    this.method,
  });

  Map<String, int> total;
  Address address;
  String method;

  factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
    total: Map.from(json["total"]).map((k, v) => MapEntry<String, int>(k, v)),
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    method: json["method"] == null ? null : json["method"],
  );

  Map<String, dynamic> toJson() => {
    "total": Map.from(total).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "address": address == null ? null : address.toJson(),
    "method": method == null ? null : method,
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






//import 'dart:convert';
//
//ProductOrdertModel productOrdertModelFromJson(String str) => ProductOrdertModel.fromJson(json.decode(str));
//
//String productOrdertModelToJson(ProductOrdertModel data) => json.encode(data.toJson());
//
//class ProductOrdertModel {
//  ProductOrdertModel({
//    this.items,
//    this.searchCriteria,
//    this.totalCount,
//  });
//
//  List<ProductOrdertModelItem> items;
//  SearchCriteria searchCriteria;
//  int totalCount;
//
//  factory ProductOrdertModel.fromJson(Map<String, dynamic> json) => ProductOrdertModel(
//    items: List<ProductOrdertModelItem>.from(json["items"].map((x) => ProductOrdertModelItem.fromJson(x))),
//    searchCriteria: SearchCriteria.fromJson(json["search_criteria"]),
//    totalCount: json["total_count"],
//  );
//
//  Map<String, dynamic> toJson() => {
//    "items": List<dynamic>.from(items.map((x) => x.toJson())),
//    "search_criteria": searchCriteria.toJson(),
//    "total_count": totalCount,
//  };
//}
//
//class ProductOrdertModelItem {
//  ProductOrdertModelItem({
//    this.baseCurrencyCode,
//    this.baseDiscountAmount,
//    this.baseGrandTotal,
//    this.baseDiscountTaxCompensationAmount,
//    this.baseShippingAmount,
//    this.baseShippingDiscountAmount,
//    this.baseShippingDiscountTaxCompensationAmnt,
//    this.baseShippingInclTax,
//    this.baseShippingTaxAmount,
//    this.baseSubtotal,
//    this.baseSubtotalInclTax,
//    this.baseTaxAmount,
//    this.baseTotalDue,
//    this.baseToGlobalRate,
//    this.baseToOrderRate,
//    this.billingAddressId,
//    this.createdAt,
//    this.customerEmail,
//    this.customerFirstname,
//    this.customerGroupId,
//    this.customerId,
//    this.customerIsGuest,
//    this.customerLastname,
//    this.customerNoteNotify,
//    this.discountAmount,
//    this.emailSent,
//    this.entityId,
//    this.globalCurrencyCode,
//    this.grandTotal,
//    this.discountTaxCompensationAmount,
//    this.incrementId,
//    this.isVirtual,
//    this.orderCurrencyCode,
//    this.protectCode,
//    this.quoteId,
//    this.remoteIp,
//    this.shippingAmount,
//    this.shippingDescription,
//    this.shippingDiscountAmount,
//    this.shippingDiscountTaxCompensationAmount,
//    this.shippingInclTax,
//    this.shippingTaxAmount,
//    this.state,
//    this.status,
//    this.storeCurrencyCode,
//    this.storeId,
//    this.storeName,
//    this.storeToBaseRate,
//    this.storeToOrderRate,
//    this.subtotal,
//    this.subtotalInclTax,
//    this.taxAmount,
//    this.totalDue,
//    this.totalItemCount,
//    this.totalQtyOrdered,
//    this.updatedAt,
//    this.weight,
//    this.items,
//    this.billingAddress,
//    this.payment,
//    this.statusHistories,
//    this.extensionAttributes,
//  });
//
//  CurrencyCode baseCurrencyCode;
//  int baseDiscountAmount;
//  int baseGrandTotal;
//  int baseDiscountTaxCompensationAmount;
//  int baseShippingAmount;
//  int baseShippingDiscountAmount;
//  int baseShippingDiscountTaxCompensationAmnt;
//  int baseShippingInclTax;
//  int baseShippingTaxAmount;
//  int baseSubtotal;
//  int baseSubtotalInclTax;
//  int baseTaxAmount;
//  int baseTotalDue;
//  int baseToGlobalRate;
//  int baseToOrderRate;
//  int billingAddressId;
//  DateTime createdAt;
//  CustomerEmail customerEmail;
//  CustomerStname customerFirstname;
//  int customerGroupId;
//  int customerId;
//  int customerIsGuest;
//  CustomerStname customerLastname;
//  int customerNoteNotify;
//  int discountAmount;
//  int emailSent;
//  int entityId;
//  CurrencyCode globalCurrencyCode;
//  int grandTotal;
//  int discountTaxCompensationAmount;
//  String incrementId;
//  int isVirtual;
//  CurrencyCode orderCurrencyCode;
//  String protectCode;
//  int quoteId;
//  RemoteIp remoteIp;
//  int shippingAmount;
//  ShippingDescription shippingDescription;
//  int shippingDiscountAmount;
//  int shippingDiscountTaxCompensationAmount;
//  int shippingInclTax;
//  int shippingTaxAmount;
//  String state;
//  String status;
//  CurrencyCode storeCurrencyCode;
//  int storeId;
//  StoreName storeName;
//  int storeToBaseRate;
//  int storeToOrderRate;
//  int subtotal;
//  int subtotalInclTax;
//  int taxAmount;
//  int totalDue;
//  int totalItemCount;
//  int totalQtyOrdered;
//  DateTime updatedAt;
//  int weight;
//  List<ShippingAssignmentItem> items;
//  Address billingAddress;
//  Payment payment;
//  List<dynamic> statusHistories;
//  ExtensionAttributes extensionAttributes;
//
//  factory ProductOrdertModelItem.fromJson(Map<String, dynamic> json) => ProductOrdertModelItem(
//    baseCurrencyCode: currencyCodeValues.map[json["base_currency_code"]],
//    baseDiscountAmount: json["base_discount_amount"],
//    baseGrandTotal: json["base_grand_total"],
//    baseDiscountTaxCompensationAmount: json["base_discount_tax_compensation_amount"],
//    baseShippingAmount: json["base_shipping_amount"],
//    baseShippingDiscountAmount: json["base_shipping_discount_amount"],
//    baseShippingDiscountTaxCompensationAmnt: json["base_shipping_discount_tax_compensation_amnt"],
//    baseShippingInclTax: json["base_shipping_incl_tax"],
//    baseShippingTaxAmount: json["base_shipping_tax_amount"],
//    baseSubtotal: json["base_subtotal"],
//    baseSubtotalInclTax: json["base_subtotal_incl_tax"],
//    baseTaxAmount: json["base_tax_amount"],
//    baseTotalDue: json["base_total_due"],
//    baseToGlobalRate: json["base_to_global_rate"],
//    baseToOrderRate: json["base_to_order_rate"],
//    billingAddressId: json["billing_address_id"],
//    createdAt: DateTime.parse(json["created_at"]),
//    customerEmail: customerEmailValues.map[json["customer_email"]],
//    customerFirstname: customerStnameValues.map[json["customer_firstname"]],
//    customerGroupId: json["customer_group_id"],
//    customerId: json["customer_id"],
//    customerIsGuest: json["customer_is_guest"],
//    customerLastname: customerStnameValues.map[json["customer_lastname"]],
//    customerNoteNotify: json["customer_note_notify"],
//    discountAmount: json["discount_amount"],
//    emailSent: json["email_sent"],
//    entityId: json["entity_id"],
//    globalCurrencyCode: currencyCodeValues.map[json["global_currency_code"]],
//    grandTotal: json["grand_total"],
//    discountTaxCompensationAmount: json["discount_tax_compensation_amount"],
//    incrementId: json["increment_id"],
//    isVirtual: json["is_virtual"],
//    orderCurrencyCode: currencyCodeValues.map[json["order_currency_code"]],
//    protectCode: json["protect_code"],
//    quoteId: json["quote_id"],
//    remoteIp: remoteIpValues.map[json["remote_ip"]],
//    shippingAmount: json["shipping_amount"],
//    shippingDescription: shippingDescriptionValues.map[json["shipping_description"]],
//    shippingDiscountAmount: json["shipping_discount_amount"],
//    shippingDiscountTaxCompensationAmount: json["shipping_discount_tax_compensation_amount"],
//    shippingInclTax: json["shipping_incl_tax"],
//    shippingTaxAmount: json["shipping_tax_amount"],
//    state: json["state"],
//    status: json["status"],
//    storeCurrencyCode: currencyCodeValues.map[json["store_currency_code"]],
//    storeId: json["store_id"],
//    storeName: storeNameValues.map[json["store_name"]],
//    storeToBaseRate: json["store_to_base_rate"],
//    storeToOrderRate: json["store_to_order_rate"],
//    subtotal: json["subtotal"],
//    subtotalInclTax: json["subtotal_incl_tax"],
//    taxAmount: json["tax_amount"],
//    totalDue: json["total_due"],
//    totalItemCount: json["total_item_count"],
//    totalQtyOrdered: json["total_qty_ordered"],
//    updatedAt: DateTime.parse(json["updated_at"]),
//    weight: json["weight"],
//    items: List<ShippingAssignmentItem>.from(json["items"].map((x) => ShippingAssignmentItem.fromJson(x))),
//    billingAddress: Address.fromJson(json["billing_address"]),
//    payment: Payment.fromJson(json["payment"]),
//    statusHistories: List<dynamic>.from(json["status_histories"].map((x) => x)),
//    extensionAttributes: ExtensionAttributes.fromJson(json["extension_attributes"]),
//  );
//
//  Map<String, dynamic> toJson() => {
//    "base_currency_code": currencyCodeValues.reverse[baseCurrencyCode],
//    "base_discount_amount": baseDiscountAmount,
//    "base_grand_total": baseGrandTotal,
//    "base_discount_tax_compensation_amount": baseDiscountTaxCompensationAmount,
//    "base_shipping_amount": baseShippingAmount,
//    "base_shipping_discount_amount": baseShippingDiscountAmount,
//    "base_shipping_discount_tax_compensation_amnt": baseShippingDiscountTaxCompensationAmnt,
//    "base_shipping_incl_tax": baseShippingInclTax,
//    "base_shipping_tax_amount": baseShippingTaxAmount,
//    "base_subtotal": baseSubtotal,
//    "base_subtotal_incl_tax": baseSubtotalInclTax,
//    "base_tax_amount": baseTaxAmount,
//    "base_total_due": baseTotalDue,
//    "base_to_global_rate": baseToGlobalRate,
//    "base_to_order_rate": baseToOrderRate,
//    "billing_address_id": billingAddressId,
//    "created_at": createdAt.toIso8601String(),
//    "customer_email": customerEmailValues.reverse[customerEmail],
//    "customer_firstname": customerStnameValues.reverse[customerFirstname],
//    "customer_group_id": customerGroupId,
//    "customer_id": customerId,
//    "customer_is_guest": customerIsGuest,
//    "customer_lastname": customerStnameValues.reverse[customerLastname],
//    "customer_note_notify": customerNoteNotify,
//    "discount_amount": discountAmount,
//    "email_sent": emailSent,
//    "entity_id": entityId,
//    "global_currency_code": currencyCodeValues.reverse[globalCurrencyCode],
//    "grand_total": grandTotal,
//    "discount_tax_compensation_amount": discountTaxCompensationAmount,
//    "increment_id": incrementId,
//    "is_virtual": isVirtual,
//    "order_currency_code": currencyCodeValues.reverse[orderCurrencyCode],
//    "protect_code": protectCode,
//    "quote_id": quoteId,
//    "remote_ip": remoteIpValues.reverse[remoteIp],
//    "shipping_amount": shippingAmount,
//    "shipping_description": shippingDescriptionValues.reverse[shippingDescription],
//    "shipping_discount_amount": shippingDiscountAmount,
//    "shipping_discount_tax_compensation_amount": shippingDiscountTaxCompensationAmount,
//    "shipping_incl_tax": shippingInclTax,
//    "shipping_tax_amount": shippingTaxAmount,
//    "state": state,
//    "status": status,
//    "store_currency_code": currencyCodeValues.reverse[storeCurrencyCode],
//    "store_id": storeId,
//    "store_name": storeNameValues.reverse[storeName],
//    "store_to_base_rate": storeToBaseRate,
//    "store_to_order_rate": storeToOrderRate,
//    "subtotal": subtotal,
//    "subtotal_incl_tax": subtotalInclTax,
//    "tax_amount": taxAmount,
//    "total_due": totalDue,
//    "total_item_count": totalItemCount,
//    "total_qty_ordered": totalQtyOrdered,
//    "updated_at": updatedAt.toIso8601String(),
//    "weight": weight,
//    "items": List<dynamic>.from(items.map((x) => x.toJson())),
//    "billing_address": billingAddress.toJson(),
//    "payment": payment.toJson(),
//    "status_histories": List<dynamic>.from(statusHistories.map((x) => x)),
//    "extension_attributes": extensionAttributes.toJson(),
//  };
//}
//
//enum CurrencyCode { AED }
//
//final currencyCodeValues = EnumValues({
//  "AED": CurrencyCode.AED
//});
//
//class Address {
//  Address({
//    this.addressType,
//    this.city,
//    this.countryId,
//    this.email,
//    this.entityId,
//    this.firstname,
//    this.lastname,
//    this.parentId,
//    this.postcode,
//    this.region,
//    this.regionCode,
//    this.regionId,
//    this.street,
//    this.telephone,
//  });
//
//  AddressType addressType;
//  City city;
//  CountryId countryId;
//  CustomerEmail email;
//  int entityId;
//  Firstname firstname;
//  Lastname lastname;
//  int parentId;
//  String postcode;
//  Region region;
//  RegionCode regionCode;
//  int regionId;
//  List<Street> street;
//  String telephone;
//
//  factory Address.fromJson(Map<String, dynamic> json) => Address(
//    addressType: addressTypeValues.map[json["address_type"]],
//    city: cityValues.map[json["city"]],
//    countryId: countryIdValues.map[json["country_id"]],
//    email: customerEmailValues.map[json["email"]],
//    entityId: json["entity_id"],
//    firstname: firstnameValues.map[json["firstname"]],
//    lastname: lastnameValues.map[json["lastname"]],
//    parentId: json["parent_id"],
//    postcode: json["postcode"],
//    region: regionValues.map[json["region"]],
//    regionCode: regionCodeValues.map[json["region_code"]],
//    regionId: json["region_id"],
//    street: List<Street>.from(json["street"].map((x) => streetValues.map[x])),
//    telephone: json["telephone"],
//  );
//
//  Map<String, dynamic> toJson() => {
//    "address_type": addressTypeValues.reverse[addressType],
//    "city": cityValues.reverse[city],
//    "country_id": countryIdValues.reverse[countryId],
//    "email": customerEmailValues.reverse[email],
//    "entity_id": entityId,
//    "firstname": firstnameValues.reverse[firstname],
//    "lastname": lastnameValues.reverse[lastname],
//    "parent_id": parentId,
//    "postcode": postcode,
//    "region": regionValues.reverse[region],
//    "region_code": regionCodeValues.reverse[regionCode],
//    "region_id": regionId,
//    "street": List<dynamic>.from(street.map((x) => streetValues.reverse[x])),
//    "telephone": telephone,
//  };
//}
//
//enum AddressType { BILLING, SHIPPING }
//
//final addressTypeValues = EnumValues({
//  "billing": AddressType.BILLING,

//  "shipping": AddressType.SHIPPING
//});
//
//enum City { CITY_TEN, PURCHASE }
//
//final cityValues = EnumValues({
//  "City Ten": City.CITY_TEN,
//  "Purchase": City.PURCHASE
//});
//
//enum CountryId { US }
//
//final countryIdValues = EnumValues({
//  "US": CountryId.US
//});
//
//enum CustomerEmail { ABC_ABC_ABC }
//
//final customerEmailValues = EnumValues({
//  "abc@abc.abc": CustomerEmail.ABC_ABC_ABC
//});
//
//enum Firstname { TEST, JANE }
//
//final firstnameValues = EnumValues({
//  "Jane": Firstname.JANE,
//  "test": Firstname.TEST
//});
//
//enum Lastname { TEST, DOE }
//
//final lastnameValues = EnumValues({
//  "Doe": Lastname.DOE,
//  "test": Lastname.TEST
//});
//
//enum Region { CALIFORNIA, NEW_YORK }
//
//final regionValues = EnumValues({
//  "California": Region.CALIFORNIA,
//  "New York": Region.NEW_YORK
//});
//
//enum RegionCode { CA, NY }
//
//final regionCodeValues = EnumValues({
//  "CA": RegionCode.CA,
//  "NY": RegionCode.NY
//});
//
//enum Street { THE_123_OAK_AVE }
//
//final streetValues = EnumValues({
//  "123 Oak Ave": Street.THE_123_OAK_AVE
//});
//
//enum CustomerStname { ABC }
//
//final customerStnameValues = EnumValues({
//  "abc": CustomerStname.ABC
//});
//
//class ExtensionAttributes {
//  ExtensionAttributes({
//    this.shippingAssignments,
//    this.paymentAdditionalInfo,
//    this.appliedTaxes,
//    this.itemAppliedTaxes,
//  });
//
//  List<ShippingAssignment> shippingAssignments;
//  List<PaymentAdditionalInfo> paymentAdditionalInfo;
//  List<dynamic> appliedTaxes;
//  List<dynamic> itemAppliedTaxes;
//
//  factory ExtensionAttributes.fromJson(Map<String, dynamic> json) => ExtensionAttributes(
//    shippingAssignments: List<ShippingAssignment>.from(json["shipping_assignments"].map((x) => ShippingAssignment.fromJson(x))),
//    paymentAdditionalInfo: List<PaymentAdditionalInfo>.from(json["payment_additional_info"].map((x) => PaymentAdditionalInfo.fromJson(x))),
//    appliedTaxes: List<dynamic>.from(json["applied_taxes"].map((x) => x)),
//    itemAppliedTaxes: List<dynamic>.from(json["item_applied_taxes"].map((x) => x)),
//  );
//
//  Map<String, dynamic> toJson() => {
//    "shipping_assignments": List<dynamic>.from(shippingAssignments.map((x) => x.toJson())),
//    "payment_additional_info": List<dynamic>.from(paymentAdditionalInfo.map((x) => x.toJson())),
//    "applied_taxes": List<dynamic>.from(appliedTaxes.map((x) => x)),
//    "item_applied_taxes": List<dynamic>.from(itemAppliedTaxes.map((x) => x)),
//  };
//}
//
//class PaymentAdditionalInfo {
//  PaymentAdditionalInfo({
//    this.key,
//    this.value,
//  });
//
//  Key key;
//  AdditionalInformation value;
//
//  factory PaymentAdditionalInfo.fromJson(Map<String, dynamic> json) => PaymentAdditionalInfo(
//    key: keyValues.map[json["key"]],
//    value: additionalInformationValues.map[json["value"]],
//  );
//
//  Map<String, dynamic> toJson() => {
//    "key": keyValues.reverse[key],
//    "value": additionalInformationValues.reverse[value],
//  };
//}
//
//enum Key { METHOD_TITLE, INSTRUCTIONS }
//
//final keyValues = EnumValues({
//  "instructions": Key.INSTRUCTIONS,
//  "method_title": Key.METHOD_TITLE
//});
//
//enum AdditionalInformation { CASH_ON_DELIVERY, EMPTY }
//
//final additionalInformationValues = EnumValues({
//  "Cash On Delivery": AdditionalInformation.CASH_ON_DELIVERY,
//  "": AdditionalInformation.EMPTY
//});
//
//class ShippingAssignment {
//  ShippingAssignment({
//    this.shipping,
//    this.items,
//  });
//
//  Shipping shipping;
//  List<ShippingAssignmentItem> items;
//
//  factory ShippingAssignment.fromJson(Map<String, dynamic> json) => ShippingAssignment(
//    shipping: Shipping.fromJson(json["shipping"]),
//    items: List<ShippingAssignmentItem>.from(json["items"].map((x) => ShippingAssignmentItem.fromJson(x))),
//  );
//
//  Map<String, dynamic> toJson() => {
//    "shipping": shipping.toJson(),
//    "items": List<dynamic>.from(items.map((x) => x.toJson())),
//  };
//}
//
//class ShippingAssignmentItem {
//  ShippingAssignmentItem({
//    this.amountRefunded,
//    this.baseAmountRefunded,
//    this.baseDiscountAmount,
//    this.baseDiscountInvoiced,
//    this.baseDiscountTaxCompensationAmount,
//    this.baseOriginalPrice,
//    this.basePrice,
//    this.basePriceInclTax,
//    this.baseRowInvoiced,
//    this.baseRowTotal,
//    this.baseRowTotalInclTax,
//    this.baseTaxAmount,
//    this.baseTaxInvoiced,
//    this.createdAt,
//    this.discountAmount,
//    this.discountInvoiced,
//    this.discountPercent,
//    this.freeShipping,
//    this.discountTaxCompensationAmount,
//    this.isQtyDecimal,
//    this.isVirtual,
//    this.itemId,
//    this.name,
//    this.noDiscount,
//    this.orderId,
//    this.originalPrice,
//    this.price,
//    this.priceInclTax,
//    this.productId,
//    this.productType,
//    this.qtyCanceled,
//    this.qtyInvoiced,
//    this.qtyOrdered,
//    this.qtyRefunded,
//    this.qtyShipped,
//    this.quoteItemId,
//    this.rowInvoiced,
//    this.rowTotal,
//    this.rowTotalInclTax,
//    this.rowWeight,
//    this.sku,
//    this.storeId,
//    this.taxAmount,
//    this.taxInvoiced,
//    this.taxPercent,
//    this.updatedAt,
//    this.weight,
//  });
//
//  int amountRefunded;
//  int baseAmountRefunded;
//  int baseDiscountAmount;
//  int baseDiscountInvoiced;
//  int baseDiscountTaxCompensationAmount;
//  int baseOriginalPrice;
//  int basePrice;
//  int basePriceInclTax;
//  int baseRowInvoiced;
//  int baseRowTotal;
//  int baseRowTotalInclTax;
//  int baseTaxAmount;
//  int baseTaxInvoiced;
//  DateTime createdAt;
//  int discountAmount;
//  int discountInvoiced;
//  int discountPercent;
//  int freeShipping;
//  int discountTaxCompensationAmount;
//  int isQtyDecimal;
//  int isVirtual;
//  int itemId;
//  String name;
//  int noDiscount;
//  int orderId;
//  int originalPrice;
//  int price;
//  int priceInclTax;
//  int productId;
//  ProductType productType;
//  int qtyCanceled;
//  int qtyInvoiced;
//  int qtyOrdered;
//  int qtyRefunded;
//  int qtyShipped;
//  int quoteItemId;
//  int rowInvoiced;
//  int rowTotal;
//  int rowTotalInclTax;
//  int rowWeight;
//  String sku;
//  int storeId;
//  int taxAmount;
//  int taxInvoiced;
//  int taxPercent;
//  DateTime updatedAt;
//  int weight;
//
//  factory ShippingAssignmentItem.fromJson(Map<String, dynamic> json) => ShippingAssignmentItem(
//    amountRefunded: json["amount_refunded"],
//    baseAmountRefunded: json["base_amount_refunded"],
//    baseDiscountAmount: json["base_discount_amount"],
//    baseDiscountInvoiced: json["base_discount_invoiced"],
//    baseDiscountTaxCompensationAmount: json["base_discount_tax_compensation_amount"],
//    baseOriginalPrice: json["base_original_price"],
//    basePrice: json["base_price"],
//    basePriceInclTax: json["base_price_incl_tax"],
//    baseRowInvoiced: json["base_row_invoiced"],
//    baseRowTotal: json["base_row_total"],
//    baseRowTotalInclTax: json["base_row_total_incl_tax"],
//    baseTaxAmount: json["base_tax_amount"],
//    baseTaxInvoiced: json["base_tax_invoiced"],
//    createdAt: DateTime.parse(json["created_at"]),
//    discountAmount: json["discount_amount"],
//    discountInvoiced: json["discount_invoiced"],
//    discountPercent: json["discount_percent"],
//    freeShipping: json["free_shipping"],
//    discountTaxCompensationAmount: json["discount_tax_compensation_amount"],
//    isQtyDecimal: json["is_qty_decimal"],
//    isVirtual: json["is_virtual"],
//    itemId: json["item_id"],
//    name: json["name"],
//    noDiscount: json["no_discount"],
//    orderId: json["order_id"],
//    originalPrice: json["original_price"],
//    price: json["price"],
//    priceInclTax: json["price_incl_tax"],
//    productId: json["product_id"],
//    productType: productTypeValues.map[json["product_type"]],
//    qtyCanceled: json["qty_canceled"],
//    qtyInvoiced: json["qty_invoiced"],
//    qtyOrdered: json["qty_ordered"],
//    qtyRefunded: json["qty_refunded"],
//    qtyShipped: json["qty_shipped"],
//    quoteItemId: json["quote_item_id"],
//    rowInvoiced: json["row_invoiced"],
//    rowTotal: json["row_total"],
//    rowTotalInclTax: json["row_total_incl_tax"],
//    rowWeight: json["row_weight"],
//    sku: json["sku"],
//    storeId: json["store_id"],
//    taxAmount: json["tax_amount"],
//    taxInvoiced: json["tax_invoiced"],
//    taxPercent: json["tax_percent"],
//    updatedAt: DateTime.parse(json["updated_at"]),
//    weight: json["weight"] == null ? null : json["weight"],
//  );
//
//  Map<String, dynamic> toJson() => {
//    "amount_refunded": amountRefunded,
//    "base_amount_refunded": baseAmountRefunded,
//    "base_discount_amount": baseDiscountAmount,
//    "base_discount_invoiced": baseDiscountInvoiced,
//    "base_discount_tax_compensation_amount": baseDiscountTaxCompensationAmount,
//    "base_original_price": baseOriginalPrice,
//    "base_price": basePrice,
//    "base_price_incl_tax": basePriceInclTax,
//    "base_row_invoiced": baseRowInvoiced,
//    "base_row_total": baseRowTotal,
//    "base_row_total_incl_tax": baseRowTotalInclTax,
//    "base_tax_amount": baseTaxAmount,
//    "base_tax_invoiced": baseTaxInvoiced,
//    "created_at": createdAt.toIso8601String(),
//    "discount_amount": discountAmount,
//    "discount_invoiced": discountInvoiced,
//    "discount_percent": discountPercent,
//    "free_shipping": freeShipping,
//    "discount_tax_compensation_amount": discountTaxCompensationAmount,
//    "is_qty_decimal": isQtyDecimal,
//    "is_virtual": isVirtual,
//    "item_id": itemId,
//    "name": nameValues.reverse[name],
//    "no_discount": noDiscount,
//    "order_id": orderId,
//    "original_price": originalPrice,
//    "price": price,
//    "price_incl_tax": priceInclTax,
//    "product_id": productId,
//    "product_type": productTypeValues.reverse[productType],
//    "qty_canceled": qtyCanceled,
//    "qty_invoiced": qtyInvoiced,
//    "qty_ordered": qtyOrdered,
//    "qty_refunded": qtyRefunded,
//    "qty_shipped": qtyShipped,
//    "quote_item_id": quoteItemId,
//    "row_invoiced": rowInvoiced,
//    "row_total": rowTotal,
//    "row_total_incl_tax": rowTotalInclTax,
//    "row_weight": rowWeight,
//    "sku": skuValues.reverse[sku],
//    "store_id": storeId,
//    "tax_amount": taxAmount,
//    "tax_invoiced": taxInvoiced,
//    "tax_percent": taxPercent,
//    "updated_at": updatedAt.toIso8601String(),
//    "weight": weight == null ? null : weight,
//  };
//}
//
//enum Name { FRESH_EGGS_SET, CHILLED_LAMB_HIND_SHANK, YOGURT_1_LT, ONION_RING_BREADED, FRECH_FRIES_STEAK_HOUSE }
//
//final nameValues = EnumValues({
//  "Chilled Lamb Hind Shank": Name.CHILLED_LAMB_HIND_SHANK,
//  "Frech Fries Steak House": Name.FRECH_FRIES_STEAK_HOUSE,
//  "Fresh Eggs Set": Name.FRESH_EGGS_SET,
//  "Onion Ring Breaded": Name.ONION_RING_BREADED,
//  "Yogurt 1 Lt": Name.YOGURT_1_LT
//});
//
//enum ProductType { SIMPLE }
//
//final productTypeValues = EnumValues({
//  "simple": ProductType.SIMPLE
//});
//
//enum Sku { FRESH_EGGS, CHILLED_LAMB_HIND_SHANK, YOGURT_1_LT, ONION_RING_BREADED, FRECH_FRIES_STEAK_HOUSE }
//
//final skuValues = EnumValues({
//  "Chilled Lamb Hind Shank": Sku.CHILLED_LAMB_HIND_SHANK,
//  "frech-fries-steak-house": Sku.FRECH_FRIES_STEAK_HOUSE,
//  "Fresh Eggs": Sku.FRESH_EGGS,
//  "Onion-Ring-Breaded": Sku.ONION_RING_BREADED,
//  "yogurt-1-lt": Sku.YOGURT_1_LT
//});
//
//class Shipping {
//  Shipping({
//    this.address,
//    this.method,
//    this.total,
//  });
//
//  Address address;
//  ShippingMethod method;
//  Total total;
//
//  factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
//    address: Address.fromJson(json["address"]),
//    method: shippingMethodValues.map[json["method"]],
//    total: Total.fromJson(json["total"]),
//  );
//
//  Map<String, dynamic> toJson() => {
//    "address": address.toJson(),
//    "method": shippingMethodValues.reverse[method],
//    "total": total.toJson(),
//  };
//}
//
//enum ShippingMethod { FLATRATE_FLATRATE }
//
//final shippingMethodValues = EnumValues({
//  "flatrate_flatrate": ShippingMethod.FLATRATE_FLATRATE
//});
//
//class Total {
//  Total({
//    this.baseShippingAmount,
//    this.baseShippingDiscountAmount,
//    this.baseShippingDiscountTaxCompensationAmnt,
//    this.baseShippingInclTax,
//    this.baseShippingTaxAmount,
//    this.shippingAmount,
//    this.shippingDiscountAmount,
//    this.shippingDiscountTaxCompensationAmount,
//    this.shippingInclTax,
//    this.shippingTaxAmount,
//  });
//
//  int baseShippingAmount;
//  int baseShippingDiscountAmount;
//  int baseShippingDiscountTaxCompensationAmnt;
//  int baseShippingInclTax;
//  int baseShippingTaxAmount;
//  int shippingAmount;
//  int shippingDiscountAmount;
//  int shippingDiscountTaxCompensationAmount;
//  int shippingInclTax;
//  int shippingTaxAmount;
//
//  factory Total.fromJson(Map<String, dynamic> json) => Total(
//    baseShippingAmount: json["base_shipping_amount"],
//    baseShippingDiscountAmount: json["base_shipping_discount_amount"],
//    baseShippingDiscountTaxCompensationAmnt: json["base_shipping_discount_tax_compensation_amnt"],
//    baseShippingInclTax: json["base_shipping_incl_tax"],
//    baseShippingTaxAmount: json["base_shipping_tax_amount"],
//    shippingAmount: json["shipping_amount"],
//    shippingDiscountAmount: json["shipping_discount_amount"],
//    shippingDiscountTaxCompensationAmount: json["shipping_discount_tax_compensation_amount"],
//    shippingInclTax: json["shipping_incl_tax"],
//    shippingTaxAmount: json["shipping_tax_amount"],
//  );
//
//  Map<String, dynamic> toJson() => {
//    "base_shipping_amount": baseShippingAmount,
//    "base_shipping_discount_amount": baseShippingDiscountAmount,
//    "base_shipping_discount_tax_compensation_amnt": baseShippingDiscountTaxCompensationAmnt,
//    "base_shipping_incl_tax": baseShippingInclTax,
//    "base_shipping_tax_amount": baseShippingTaxAmount,
//    "shipping_amount": shippingAmount,
//    "shipping_discount_amount": shippingDiscountAmount,
//    "shipping_discount_tax_compensation_amount": shippingDiscountTaxCompensationAmount,
//    "shipping_incl_tax": shippingInclTax,
//    "shipping_tax_amount": shippingTaxAmount,
//  };
//}
//
//class Payment {
//  Payment({
//    this.accountStatus,
//    this.additionalInformation,
//    this.amountOrdered,
//    this.baseAmountOrdered,
//    this.baseShippingAmount,
//    this.ccLast4,
//    this.entityId,
//    this.method,
//    this.parentId,
//    this.shippingAmount,
//    this.ccExpYear,
//    this.ccSsStartMonth,
//    this.ccSsStartYear,
//  });
//
//  dynamic accountStatus;
//  List<AdditionalInformation> additionalInformation;
//  int amountOrdered;
//  int baseAmountOrdered;
//  int baseShippingAmount;
//  dynamic ccLast4;
//  int entityId;
//  PaymentMethod method;
//  int parentId;
//  int shippingAmount;
//  String ccExpYear;
//  String ccSsStartMonth;
//  String ccSsStartYear;
//
//  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
//    accountStatus: json["account_status"],
//    additionalInformation: List<AdditionalInformation>.from(json["additional_information"].map((x) => additionalInformationValues.map[x])),
//    amountOrdered: json["amount_ordered"],
//    baseAmountOrdered: json["base_amount_ordered"],
//    baseShippingAmount: json["base_shipping_amount"],
//    ccLast4: json["cc_last4"],
//    entityId: json["entity_id"],
//    method: paymentMethodValues.map[json["method"]],
//    parentId: json["parent_id"],
//    shippingAmount: json["shipping_amount"],
//    ccExpYear: json["cc_exp_year"] == null ? null : json["cc_exp_year"],
//    ccSsStartMonth: json["cc_ss_start_month"] == null ? null : json["cc_ss_start_month"],
//    ccSsStartYear: json["cc_ss_start_year"] == null ? null : json["cc_ss_start_year"],
//  );
//
//  Map<String, dynamic> toJson() => {
//    "account_status": accountStatus,
//    "additional_information": List<dynamic>.from(additionalInformation.map((x) => additionalInformationValues.reverse[x])),
//    "amount_ordered": amountOrdered,
//    "base_amount_ordered": baseAmountOrdered,
//    "base_shipping_amount": baseShippingAmount,
//    "cc_last4": ccLast4,
//    "entity_id": entityId,
//    "method": paymentMethodValues.reverse[method],
//    "parent_id": parentId,
//    "shipping_amount": shippingAmount,
//    "cc_exp_year": ccExpYear == null ? null : ccExpYear,
//    "cc_ss_start_month": ccSsStartMonth == null ? null : ccSsStartMonth,
//    "cc_ss_start_year": ccSsStartYear == null ? null : ccSsStartYear,
//  };
//}
//
//enum PaymentMethod { CASHONDELIVERY }
//
//final paymentMethodValues = EnumValues({
//  "cashondelivery": PaymentMethod.CASHONDELIVERY
//});
//
//enum RemoteIp { THE_2505034 }
//
//final remoteIpValues = EnumValues({
//  "2.50.50.34": RemoteIp.THE_2505034
//});
//
//enum ShippingDescription { FLAT_RATE_FIXED }
//
//final shippingDescriptionValues = EnumValues({
//  "Flat Rate - Fixed": ShippingDescription.FLAT_RATE_FIXED
//});
//
//
//
//enum Status { PENDING }
//
//final c = EnumValues({
//  "pending": Status.PENDING
//});
//
//enum StoreName { MAIN_WEBSITE_MAIN_WEBSITE_STORE_ENGLISH }
//
//final storeNameValues = EnumValues({
//  "Main Website\nMain Website Store\nEnglish": StoreName.MAIN_WEBSITE_MAIN_WEBSITE_STORE_ENGLISH
//});
//
//class SearchCriteria {
//  SearchCriteria({
//    this.filterGroups,
//  });
//
//  List<FilterGroup> filterGroups;
//
//  factory SearchCriteria.fromJson(Map<String, dynamic> json) => SearchCriteria(
//    filterGroups: List<FilterGroup>.from(json["filter_groups"].map((x) => FilterGroup.fromJson(x))),
//  );
//
//  Map<String, dynamic> toJson() => {
//    "filter_groups": List<dynamic>.from(filterGroups.map((x) => x.toJson())),
//  };
//}
//
//class FilterGroup {
//  FilterGroup({
//    this.filters,
//  });
//
//  List<Filter> filters;
//
//  factory FilterGroup.fromJson(Map<String, dynamic> json) => FilterGroup(
//    filters: List<Filter>.from(json["filters"].map((x) => Filter.fromJson(x))),
//  );
//
//  Map<String, dynamic> toJson() => {
//    "filters": List<dynamic>.from(filters.map((x) => x.toJson())),
//  };
//}
//
//class Filter {
//  Filter({
//    this.field,
//    this.value,
//    this.conditionType,
//  });
//
//  String field;
//  CustomerEmail value;
//  String conditionType;
//
//  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
//    field: json["field"],
//    value: customerEmailValues.map[json["value"]],
//    conditionType: json["condition_type"],
//  );
//
//  Map<String, dynamic> toJson() => {
//    "field": field,
//    "value": customerEmailValues.reverse[value],
//    "condition_type": conditionType,
//  };
//}
//
//class EnumValues<T> {
//  Map<String, T> map;
//  Map<T, String> reverseMap;
//
//  EnumValues(this.map);
//
//  Map<T, String> get reverse {
//    if (reverseMap == null) {
//      reverseMap = map.map((k, v) => new MapEntry(v, k));
//    }
//    return reverseMap;
//  }
//}
