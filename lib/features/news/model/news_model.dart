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
  int? id;
  String? image;
  String? title;
  String? description;
  String? link;
  double? lat;
  double? long;
  String? address;

  NewsItem({
    this.id,
    this.image,
    this.title,
    this.description,
    this.link,
    this.lat,
    this.long,
    this.address,
  });

  NewsItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
    image = json['image'];
    title = json['title'];
    address = json['address'];
    description = json['description'];
    lat = json['lat'] != null ? double.parse(json['lat'].toString()) : null;
    long = json['long'] != null ? double.parse(json['long'].toString()) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['link'] = link;
    data['address'] = address;
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}
