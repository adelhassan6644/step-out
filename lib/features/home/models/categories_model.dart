class CategoriesModel {
  String? message;
  List<CategoryItem>? data;

  CategoriesModel({this.message, this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(CategoryItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryItem {
  final int? id;
  final String? image;
  final String? name;
  final String? description;
  final List<SubCategoryModel>? subCategories;

  CategoryItem({
    this.id,
    this.image,
    this.name,
    this.description,
    this.subCategories,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) => CategoryItem(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
        subCategories: json["subCategories"] == null
            ? []
            : List<SubCategoryModel>.from(json["subCategories"]!
                .map((x) => SubCategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "description": description,
        "subCategories": subCategories == null
            ? []
            : List<SubCategoryModel>.from(
                subCategories!.map((x) => x.toJson())),
      };
}

class SubCategoryModel {
  final int? id;
  final String? image;
  final int? categoryId;
  final String? name;
  final String? description;

  SubCategoryModel({
    this.id,
    this.image,
    this.categoryId,
    this.name,
    this.description,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModel(
        id: json["id"],
        image: json["image"],
        categoryId: json["category_id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "category_id": categoryId,
        "name": name,
        "description": description,
      };
}
