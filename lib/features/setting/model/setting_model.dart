class SettingModel {
  String? message;
  Data? data;

  SettingModel({this.message, this.data});

  SettingModel.fromJson(Map<String, dynamic> json) {
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
  String? terms;
  String? name;
  String? email;
  String? twitter;
  String? website;
  String? instagram;
  String? facebook;
  String? tiktok;
  String? snapchat;
  String? image;
  String? phone;
  String? whatsApp;
  String? aboutUs;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.terms,
      this.name,
      this.email,
      this.twitter,
      this.website,
      this.instagram,
      this.facebook,
      this.tiktok,
      this.snapchat,
      this.image,
      this.whatsApp,
      this.phone,
      this.aboutUs,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    terms = json['terms'];
    email = json['email'];
    twitter = json['twitter'];
    website = json['website'];
    instagram = json['instagram'];
    facebook = json['facebook'];
    tiktok = json['tiktok'];
    snapchat = json['snapchat'];
    image = json['image'];
    whatsApp = json['whatsApp'];
    phone = json['phone'];
    aboutUs = json['aboutUs'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['terms'] = terms;
    data['name'] = name;
    data['email'] = email;
    data['twitter'] = twitter;
    data['website'] = website;
    data['instagram'] = instagram;
    data['facebook'] = facebook;
    data['tiktok'] = tiktok;
    data['image'] = image;
    data['phone'] = phone;
    data['aboutUs'] = aboutUs;
    data['whatsApp'] = whatsApp;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
