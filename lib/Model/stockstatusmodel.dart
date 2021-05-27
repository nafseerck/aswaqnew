import 'dart:convert';

StockStatusModel stockStatusModelFromJson(String str) => StockStatusModel.fromJson(json.decode(str));

String stockStatusModelToJson(StockStatusModel data) => json.encode(data.toJson());

class StockStatusModel {
  StockStatusModel({
    this.productId,
    this.stockId,
    this.qty,
    this.stockStatus,
    this.stockItem,
  });

  int productId;
  int stockId;
  int qty;
  int stockStatus;
  StockItem stockItem;

  factory StockStatusModel.fromJson(Map<String, dynamic> json) => StockStatusModel(
    productId: json["product_id"],
    stockId: json["stock_id"],
    qty: json["qty"],
    stockStatus: json["stock_status"],
    stockItem: StockItem.fromJson(json["stock_item"]),
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "stock_id": stockId,
    "qty": qty,
    "stock_status": stockStatus,
    "stock_item": stockItem.toJson(),
  };
}

class StockItem {
  StockItem({
    this.itemId,
    this.productId,
    this.stockId,
    this.qty,
    this.isInStock,
    this.isQtyDecimal,
    this.showDefaultNotificationMessage,
    this.useConfigMinQty,
    this.minQty,
    this.useConfigMinSaleQty,
    this.minSaleQty,
    this.useConfigMaxSaleQty,
    this.maxSaleQty,
    this.useConfigBackorders,
    this.backorders,
    this.useConfigNotifyStockQty,
    this.notifyStockQty,
    this.useConfigQtyIncrements,
    this.qtyIncrements,
    this.useConfigEnableQtyInc,
    this.enableQtyIncrements,
    this.useConfigManageStock,
    this.manageStock,
    this.lowStockDate,
    this.isDecimalDivided,
    this.stockStatusChangedAuto,
  });

  int itemId;
  int productId;
  int stockId;
  int qty;
  bool isInStock;
  bool isQtyDecimal;
  bool showDefaultNotificationMessage;
  bool useConfigMinQty;
  int minQty;
  int useConfigMinSaleQty;
  int minSaleQty;
  bool useConfigMaxSaleQty;
  int maxSaleQty;
  bool useConfigBackorders;
  int backorders;
  bool useConfigNotifyStockQty;
  int notifyStockQty;
  bool useConfigQtyIncrements;
  int qtyIncrements;
  bool useConfigEnableQtyInc;
  bool enableQtyIncrements;
  bool useConfigManageStock;
  bool manageStock;
  dynamic lowStockDate;
  bool isDecimalDivided;
  int stockStatusChangedAuto;

  factory StockItem.fromJson(Map<String, dynamic> json) => StockItem(
    itemId: json["item_id"],
    productId: json["product_id"],
    stockId: json["stock_id"],
    qty: json["qty"],
    isInStock: json["is_in_stock"],
    isQtyDecimal: json["is_qty_decimal"],
    showDefaultNotificationMessage: json["show_default_notification_message"],
    useConfigMinQty: json["use_config_min_qty"],
    minQty: json["min_qty"],
    useConfigMinSaleQty: json["use_config_min_sale_qty"],
    minSaleQty: json["min_sale_qty"],
    useConfigMaxSaleQty: json["use_config_max_sale_qty"],
    maxSaleQty: json["max_sale_qty"],
    useConfigBackorders: json["use_config_backorders"],
    backorders: json["backorders"],
    useConfigNotifyStockQty: json["use_config_notify_stock_qty"],
    notifyStockQty: json["notify_stock_qty"],
    useConfigQtyIncrements: json["use_config_qty_increments"],
    qtyIncrements: json["qty_increments"],
    useConfigEnableQtyInc: json["use_config_enable_qty_inc"],
    enableQtyIncrements: json["enable_qty_increments"],
    useConfigManageStock: json["use_config_manage_stock"],
    manageStock: json["manage_stock"],
    lowStockDate: json["low_stock_date"],
    isDecimalDivided: json["is_decimal_divided"],
    stockStatusChangedAuto: json["stock_status_changed_auto"],
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId,
    "product_id": productId,
    "stock_id": stockId,
    "qty": qty,
    "is_in_stock": isInStock,
    "is_qty_decimal": isQtyDecimal,
    "show_default_notification_message": showDefaultNotificationMessage,
    "use_config_min_qty": useConfigMinQty,
    "min_qty": minQty,
    "use_config_min_sale_qty": useConfigMinSaleQty,
    "min_sale_qty": minSaleQty,
    "use_config_max_sale_qty": useConfigMaxSaleQty,
    "max_sale_qty": maxSaleQty,
    "use_config_backorders": useConfigBackorders,
    "backorders": backorders,
    "use_config_notify_stock_qty": useConfigNotifyStockQty,
    "notify_stock_qty": notifyStockQty,
    "use_config_qty_increments": useConfigQtyIncrements,
    "qty_increments": qtyIncrements,
    "use_config_enable_qty_inc": useConfigEnableQtyInc,
    "enable_qty_increments": enableQtyIncrements,
    "use_config_manage_stock": useConfigManageStock,
    "manage_stock": manageStock,
    "low_stock_date": lowStockDate,
    "is_decimal_divided": isDecimalDivided,
    "stock_status_changed_auto": stockStatusChangedAuto,
  };
}
