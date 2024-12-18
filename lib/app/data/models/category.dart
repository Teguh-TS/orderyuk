// To parse this JSON data, do
//
//     final demoMod2 = demoMod2FromJson(jsonString);

import 'dart:convert';

DemoMod2 demoMod2FromJson(String str) => DemoMod2.fromJson(json.decode(str));

String demoMod2ToJson(DemoMod2 data) => json.encode(data.toJson());

class DemoMod2 {
  List<Category> categories;

  DemoMod2({
    required this.categories,
  });

  factory DemoMod2.fromJson(Map<String, dynamic> json) => DemoMod2(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  String idCategory;
  String strCategory;
  String strCategoryThumb;
  String strCategoryDescription;

  Category({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        idCategory: json["idCategory"],
        strCategory: json["strCategory"],
        strCategoryThumb: json["strCategoryThumb"],
        strCategoryDescription: json["strCategoryDescription"],
      );

  Map<String, dynamic> toJson() => {
        "idCategory": idCategory,
        "strCategory": strCategory,
        "strCategoryThumb": strCategoryThumb,
        "strCategoryDescription": strCategoryDescription,
      };
}
