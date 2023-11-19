class OffersModel {
  String? message;
  List<OfferItem>? data;

  OffersModel({this.message, this.data});

  OffersModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(OfferItem.fromJson(v));
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

class OfferItem {
  final int? id;
  final String? type;
  final String? discount;
  final String? price;
  final int? placeId;
  final String? terms;
  final String? code;
  final DateTime? expireDate;
  final String? image;
  final String? status;
  final String? title;
  final String? description;
  final int? priceAfterDiscount;

  OfferItem({
    this.id,
    this.type,
    this.discount,
    this.price,
    this.placeId,
    this.terms,
    this.code,
    this.expireDate,
    this.image,
    this.status,
    this.title,
    this.description,
    this.priceAfterDiscount,
  });

  factory OfferItem.fromJson(Map<String, dynamic> json) => OfferItem(
        id: json["id"],
        type: json["type"],
        discount: json["discount"],
        price: json["price"],
        placeId: json["place_id"],
        terms: json["terms"],
        code: json["code"],
        expireDate: json["expire_date"] == null
            ? null
            : DateTime.parse(json["expire_date"]),
        image: json["image"],
        status: json["status"],
        title: json["title"],
        description: json["description"],
        priceAfterDiscount: json["price_after_discount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "discount": discount,
        "price": price,
        "place_id": placeId,
        "terms": terms,
        "code": code,
        "expire_date":
            "${expireDate!.year.toString().padLeft(4, '0')}-${expireDate!.month.toString().padLeft(2, '0')}-${expireDate!.day.toString().padLeft(2, '0')}",
        "image": image,
        "status": status,
        "title": title,
        "description": description,
        "price_after_discount": priceAfterDiscount,
      };
}
