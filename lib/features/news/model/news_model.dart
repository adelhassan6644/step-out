class NewsModel {
  String? message;
  List<NewsItem>? data;

  NewsModel({this.message, this.data});

  NewsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <NewsItem>[];
      json['data'].forEach((v) {
        data!.add(NewsItem.fromJson(v));
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

class NewsItem {
  final int? id;
  final String? author;
  final String? image;
  final String? address;
  final String? url;
  final String? status;
  final String? title;
  final String? content;
  final dynamic lat;
  final dynamic long;
  final List<Image>? images;

  NewsItem({
    this.id,
    this.author,
    this.image,
    this.address,
    this.url,
    this.status,
    this.title,
    this.lat,
    this.long,
    this.content,
    this.images,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) => NewsItem(
        id: json["id"],
        author: json["author"],
        image: json["image"],
        url: json["url"],
        address: json["address"],
        status: json["status"],
        title: json["title"],
        lat: json["lat"],
        long: json["long"],
        content: json["content"],
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "image": image,
        "address": address,
        "url": url,
        "status": status,
        "lat": lat,
        "long": long,
        "title": title,
        "content": content,
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}

class Image {
  final int? id;
  final String? image;
  final int? newsId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Image({
    this.id,
    this.image,
    this.newsId,
    this.createdAt,
    this.updatedAt,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        image: json["image"],
        newsId: json["news_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "news_id": newsId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
