class CategoryDetailsModel {
  String? message;
  Data? data;

  CategoryDetailsModel({this.message, this.data});

  CategoryDetailsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? image;
  String? title;
  String? textColor;
  String? color;
  String? description;

  Data(
      {this.id,
      this.image,
      this.title,
      this.textColor,
      this.color,
      this.description,
     });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    textColor = json['text_color'];
    color = json['color'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    data['text_color'] = textColor;
    data['color'] = color;
    data['description'] = description;

    return data;
  }
}
