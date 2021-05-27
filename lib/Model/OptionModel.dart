import 'dart:convert';

OptionModel optionModelFromJson(String str) => OptionModel.fromJson(json.decode(str));

String optionModelToJson(OptionModel data) => json.encode(data.toJson());

class OptionModel {
  OptionModel({
    this.isWysiwygEnabled,
    this.isHtmlAllowedOnFront,
    this.usedForSortBy,
    this.isFilterable,
    this.isFilterableInSearch,
    this.isUsedInGrid,
    this.isVisibleInGrid,
    this.isFilterableInGrid,
    this.position,
    this.applyTo,
    this.isSearchable,
    this.isVisibleInAdvancedSearch,
    this.isComparable,
    this.isUsedForPromoRules,
    this.isVisibleOnFront,
    this.usedInProductListing,
    this.isVisible,
    this.scope,
    this.attributeId,
    this.attributeCode,
    this.frontendInput,
    this.entityTypeId,
    this.isRequired,
    this.options,
    this.isUserDefined,
    this.defaultFrontendLabel,
    this.frontendLabels,
    this.backendType,
    this.sourceModel,
    this.defaultValue,
    this.isUnique,
    this.validationRules,
  });

  bool isWysiwygEnabled;
  bool isHtmlAllowedOnFront;
  bool usedForSortBy;
  bool isFilterable;
  bool isFilterableInSearch;
  bool isUsedInGrid;
  bool isVisibleInGrid;
  bool isFilterableInGrid;
  int position;
  List<dynamic> applyTo;
  String isSearchable;
  String isVisibleInAdvancedSearch;
  String isComparable;
  String isUsedForPromoRules;
  String isVisibleOnFront;
  String usedInProductListing;
  bool isVisible;
  String scope;
  int attributeId;
  String attributeCode;
  String frontendInput;
  String entityTypeId;
  bool isRequired;
  List<Option> options;
  bool isUserDefined;
  String defaultFrontendLabel;
  List<dynamic> frontendLabels;
  String backendType;
  String sourceModel;
  String defaultValue;
  String isUnique;
  List<dynamic> validationRules;

  factory OptionModel.fromJson(Map<String, dynamic> json) => OptionModel(
    isWysiwygEnabled: json["is_wysiwyg_enabled"],
    isHtmlAllowedOnFront: json["is_html_allowed_on_front"],
    usedForSortBy: json["used_for_sort_by"],
    isFilterable: json["is_filterable"],
    isFilterableInSearch: json["is_filterable_in_search"],
    isUsedInGrid: json["is_used_in_grid"],
    isVisibleInGrid: json["is_visible_in_grid"],
    isFilterableInGrid: json["is_filterable_in_grid"],
    position: json["position"],
    applyTo: List<dynamic>.from(json["apply_to"].map((x) => x)),
    isSearchable: json["is_searchable"],
    isVisibleInAdvancedSearch: json["is_visible_in_advanced_search"],
    isComparable: json["is_comparable"],
    isUsedForPromoRules: json["is_used_for_promo_rules"],
    isVisibleOnFront: json["is_visible_on_front"],
    usedInProductListing: json["used_in_product_listing"],
    isVisible: json["is_visible"],
    scope: json["scope"],
    attributeId: json["attribute_id"],
    attributeCode: json["attribute_code"],
    frontendInput: json["frontend_input"],
    entityTypeId: json["entity_type_id"],
    isRequired: json["is_required"],
    options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
    isUserDefined: json["is_user_defined"],
    defaultFrontendLabel: json["default_frontend_label"],
    frontendLabels: List<dynamic>.from(json["frontend_labels"].map((x) => x)),
    backendType: json["backend_type"],
    sourceModel: json["source_model"],
    defaultValue: json["default_value"],
    isUnique: json["is_unique"],
    validationRules: List<dynamic>.from(json["validation_rules"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "is_wysiwyg_enabled": isWysiwygEnabled,
    "is_html_allowed_on_front": isHtmlAllowedOnFront,
    "used_for_sort_by": usedForSortBy,
    "is_filterable": isFilterable,
    "is_filterable_in_search": isFilterableInSearch,
    "is_used_in_grid": isUsedInGrid,
    "is_visible_in_grid": isVisibleInGrid,
    "is_filterable_in_grid": isFilterableInGrid,
    "position": position,
    "apply_to": List<dynamic>.from(applyTo.map((x) => x)),
    "is_searchable": isSearchable,
    "is_visible_in_advanced_search": isVisibleInAdvancedSearch,
    "is_comparable": isComparable,
    "is_used_for_promo_rules": isUsedForPromoRules,
    "is_visible_on_front": isVisibleOnFront,
    "used_in_product_listing": usedInProductListing,
    "is_visible": isVisible,
    "scope": scope,
    "attribute_id": attributeId,
    "attribute_code": attributeCode,
    "frontend_input": frontendInput,
    "entity_type_id": entityTypeId,
    "is_required": isRequired,
    "options": List<dynamic>.from(options.map((x) => x.toJson())),
    "is_user_defined": isUserDefined,
    "default_frontend_label": defaultFrontendLabel,
    "frontend_labels": List<dynamic>.from(frontendLabels.map((x) => x)),
    "backend_type": backendType,
    "source_model": sourceModel,
    "default_value": defaultValue,
    "is_unique": isUnique,
    "validation_rules": List<dynamic>.from(validationRules.map((x) => x)),
  };
}

class Option {
  Option({
    this.label,
    this.value,
  });

  String label;
  String value;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
  };
}
