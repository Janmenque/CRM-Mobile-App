
import 'dart:convert';

AddProductAllDropdownModel addProductAllDropdownModelFromJson(String str) => AddProductAllDropdownModel.fromJson(json.decode(str));

String addProductAllDropdownModelToJson(AddProductAllDropdownModel data) => json.encode(data.toJson());

class AddProductAllDropdownModel {
  bool? result;
  String? message;
  Data? data;

  AddProductAllDropdownModel({
    this.result,
    this.message,
    this.data,
  });

  factory AddProductAllDropdownModel.fromJson(Map<String, dynamic> json) => AddProductAllDropdownModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data?.toJson(),
  };
}


class Data {
  List<ProductType>? productTypes;
  List<BarcodeSymbology>? barcodeSymbologies;
  List<Brand>? brands;
  List<ProductCategory>? categories;
  List<ProductUnit>? productUnits;
  List<TaxLists>? taxLists;
  List<TaxMethod>? taxMethod;

  Data({
    this.productTypes,
    this.barcodeSymbologies,
    this.brands,
    this.categories,
    this.productUnits,
    this.taxLists,
    this.taxMethod,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    productTypes: json["product_types"] == null ? [] : List<ProductType>.from(json["product_types"]!.map((x) => ProductType.fromJson(x))),
    barcodeSymbologies: json["barcode_symbologies"] == null ? [] : List<BarcodeSymbology>.from(json["barcode_symbologies"]!.map((x) => BarcodeSymbology.fromJson(x))),
    brands: json["brands"] == null ? [] : List<Brand>.from(json["brands"]!.map((x) => Brand.fromJson(x))),
    categories: json["categories"] == null ? [] : List<ProductCategory>.from(json["categories"]!.map((x) => ProductCategory.fromJson(x))),
    productUnits: json["product_units"] == null ? [] : List<ProductUnit>.from(json["product_units"]!.map((x) => ProductUnit.fromJson(x))),
    taxLists: json["tax_lists"] == null ? [] : List<TaxLists>.from(json["tax_lists"]!.map((x) => TaxLists.fromJson(x))),
    taxMethod: json["tax_method"] == null ? [] : List<TaxMethod>.from(json["tax_method"]!.map((x) => TaxMethod.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "product_types": productTypes == null ? [] : List<dynamic>.from(productTypes!.map((x) => x.toJson())),
    "barcode_symbologies": barcodeSymbologies == null ? [] : List<dynamic>.from(barcodeSymbologies!.map((x) => x.toJson())),
    "brands": brands == null ? [] : List<dynamic>.from(brands!.map((x) => x.toJson())),
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "product_units": productUnits == null ? [] : List<dynamic>.from(productUnits!.map((x) => x.toJson())),
    "tax_lists": taxLists == null ? [] : List<dynamic>.from(taxLists!.map((x) => x.toJson())),
    "tax_method": taxMethod == null ? [] : List<dynamic>.from(taxMethod!.map((x) => x.toJson())),
  };
}

class ProductType {
  String? value;
  String? label;

  ProductType({
    this.value,
    this.label,
  });

  factory ProductType.fromJson(Map<String, dynamic> json) => ProductType(
    value: json["value"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "label": label,
  };
}

class BarcodeSymbology {
  String? value;
  String? label;

  BarcodeSymbology({
    this.value,
    this.label,
  });

  factory BarcodeSymbology.fromJson(Map<String, dynamic> json) => BarcodeSymbology(
    value: json["value"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "label": label,
  };
}

class Brand {
  int? id;
  String? title;

  Brand({
    this.id,
    this.title,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}

class ProductCategory {
  int? id;
  String? name;

  ProductCategory({
    this.id,
    this.name,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class TaxLists {
  int? id;
  String? name;

  TaxLists({
    this.id,
    this.name,
  });

  factory TaxLists.fromJson(Map<String, dynamic> json) => TaxLists(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class ProductUnit {
  int? id;
  String? unitName;

  ProductUnit({
    this.id,
    this.unitName,
  });

  factory ProductUnit.fromJson(Map<String, dynamic> json) => ProductUnit(
    id: json["id"],
    unitName: json["unit_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "unit_name": unitName,
  };
}

class TaxMethod {
  int? value;
  String? label;

  TaxMethod({
    this.value,
    this.label,
  });

  factory TaxMethod.fromJson(Map<String, dynamic> json) => TaxMethod(
    value: json["value"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "label": label,
  };
}
