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
  dynamic agentId;
  double? rating;
  int? totalRating;
  Category? category;
  Category? subCategory;
  List<String>? images;
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
    this.categoryId,
    this.subCategoryId,
    this.agentId,
    this.rating,
    this.totalRating,
    this.category,
    this.subCategory,
    this.images,
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
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        agentId: json["agent_id"],
        rating: double.parse(json["rating"].toString()),
        totalRating: json["total_rating"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        subCategory: json["subCategory"] == null
            ? null
            : Category.fromJson(json["subCategory"]),
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x["image"])),
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
        "agent_id": agentId,
        "rating": rating,
        "total_rating": totalRating,
        "category": category?.toJson(),
        "subCategory": subCategory?.toJson(),
        "images":
            images == null ? [] : List<String>.from(images!.map((x) => x)),
        "feedbacks": feedbacks == null
            ? []
            : List<dynamic>.from(feedbacks!.map((x) => x.toJson())),
      };
}

class Category {
  int? id;
  dynamic image;
  String? name;
  String? description;
  int? categoryId;

  Category({
    this.id,
    this.image,
    this.name,
    this.description,
    this.categoryId,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "description": description,
        "category_id": categoryId,
      };
}

class FeedbackModel {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? clientId;
  int? placeId;
  int? rating;
  String? comment;
  String? name;
  String? image;

  FeedbackModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.clientId,
    this.placeId,
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
        clientId: json["client_id"],
        placeId: json["place_id"],
        rating: json["rating"],
        comment: json["comment"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "client_id": clientId,
        "place_id": placeId,
        "rating": rating,
        "comment": comment,
        "image": image,
        "name": name,
      };
}
