import 'package:stepOut/features/home/models/categories_model.dart';
import 'package:stepOut/features/home/models/offers_model.dart';

import '../../../main_models/service_model.dart';

class ItemDetailsModel {
  String? name;
  String? description;
  int? id;
  String? cover;
  String? logo;
  String? address;
  dynamic lat;
  dynamic long;
  String? status;
  String? phone;
  String? facebook;
  String? whatsapp;
  String? tiktok;
  String? twitter;
  String? instagram;
  String? snapchat;
  String? closingTime;
  String? openingTime;
  int? categoryId;
  int? subCategoryId;
  double? rating;
  int? totalRating;
  List<String>? images;
  List<SubCategoryModel>? tags;
  List<ServiceModel>? services;
  List<OfferItem>? offers;
  List<FeedbackModel>? feedbacks;

  ItemDetailsModel({
    this.name,
    this.description,
    this.id,
    this.cover,
    this.logo,
    this.address,
    this.lat,
    this.long,
    this.status,
    this.phone,
    this.facebook,
    this.whatsapp,
    this.tiktok,
    this.twitter,
    this.instagram,
    this.snapchat,
    this.closingTime,
    this.openingTime,
    this.rating,
    this.totalRating,
    this.services,
    this.tags,
    this.images,
    this.offers,
    this.feedbacks,
  });

  factory ItemDetailsModel.fromJson(Map<String, dynamic> json) =>
      ItemDetailsModel(
        name: json["name"],
        description: json["description"],
        id: json["id"],
        cover: json["cover"],
        logo: json["logo"],
        address: json["address"],
        lat: json["lat"],
        long: json["long"],
        status: json["status"],
        phone: json["phone"],
        facebook: json["facebook"],
        whatsapp: json["whatsapp"],
        tiktok: json["tiktok"],
        twitter: json["twitter"],
        instagram: json["instagram"],
        snapchat: json["snapchat"],
        closingTime: json["closing_time"],
        openingTime: json["opening_time"],
        rating: double.parse(
            json["rating"] != null ? json["rating"].toString() : "0"),
        totalRating: json["ratingCount"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        tags: json["tags"] == null
            ? []
            : List<SubCategoryModel>.from(
                json["tags"]!.map((x) => SubCategoryModel.fromJson(x))),
        services: json["services"] == null
            ? []
            : List<ServiceModel>.from(
                json["services"]!.map((x) => ServiceModel.fromJson(x))),
        offers: json["offers"] == null
            ? []
            : List<OfferItem>.from(
                json["offers"]!.map((x) => OfferItem.fromJson(x))),
        feedbacks: json["feedbacks"] == null
            ? []
            : List<FeedbackModel>.from(
                json["feedbacks"]!.map((x) => FeedbackModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "id": id,
        "cover": cover,
        "logo": logo,
        "address": address,
        "lat": lat,
        "long": long,
        "status": status,
        "phone": phone,
        "facebook": facebook,
        "whatsapp": whatsapp,
        "tiktok": tiktok,
        "twitter": twitter,
        "instagram": instagram,
        "snapchat": snapchat,
        "closing_time": closingTime,
        "opening_time": openingTime,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "rating": rating,
        "total_rating": totalRating,
        "tags": tags == null
            ? []
            : List<dynamic>.from(tags!.map((x) => x.toJson())),
        "images":
            images == null ? [] : List<String>.from(images!.map((x) => x)),
        "feedbacks": feedbacks == null
            ? []
            : List<dynamic>.from(feedbacks!.map((x) => x.toJson())),
        "services": services == null
            ? []
            : List<dynamic>.from(services!.map((x) => x.toJson())),
      };
}

class FeedbackModel {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? rating;
  String? comment;
  String? name;
  String? image;

  FeedbackModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.rating,
    this.comment,
    this.name,
    this.image,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        rating: json["rating"],
        comment: json["comment"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "rating": rating,
        "comment": comment,
        "image": image,
        "name": name,
      };
}
