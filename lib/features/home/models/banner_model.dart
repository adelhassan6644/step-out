class BannerModel {
  String? message;
  List<Data>? data;

  BannerModel({this.message, this.data});

  BannerModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  int? id;
  int? itemId;
  String? image;
  String? name;
  String? status;

  Data({this.id, this.status, this.itemId, this.image, this.name});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    itemId = json['place_id'];
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['item_id'] = itemId;
    data['image'] = image;
    data['name'] = name;

    return data;
  }
}
