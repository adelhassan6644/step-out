import 'package:stepOut/app/localization/language_constant.dart';
import 'package:stepOut/main_models/service_model.dart';
import 'package:stepOut/navigation/custom_navigation.dart';

class CategoriesModel {
  String? status;
  String? message;
  List<CategoryItem>? data;

  CategoriesModel({this.status, this.message, this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CategoryItem>[];
      json['data'].forEach((v) {
        data!.add(CategoryItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryItem {
  int? id;
  String? image;
  String? name;
  String? description;
  List<SubCategoryModel>? subCategories;

  CategoryItem(
      {this.id, this.image, this.name, this.description, this.subCategories});

  CategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    if (json['subCategories'] != null) {
      subCategories = [
        SubCategoryModel(
            name: getTranslated(
                "all", CustomNavigator.navigatorState.currentContext!),
            id: -1)
      ];
      json['subCategories'].forEach((v) {
        subCategories!.add(SubCategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['description'] = description;
    if (subCategories != null) {
      data['subCategories'] = subCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategoryModel {
  int? id;
  String? image;
  int? categoryId;
  String? name;
  String? description;
  List<ServiceModel>? services;

  SubCategoryModel({
    this.id,
    this.image,
    this.categoryId,
    this.name,
    this.description,
    this.services,
  });

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    categoryId = json['category_id'];
    name = json['name'];
    description = json['description'];
    if (json['services'] != null) {
      services = [];
      json['services'].forEach((v) {
        services!.add(ServiceModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['category_id'] = categoryId;
    data['name'] = name;
    data['description'] = description;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
