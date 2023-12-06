class ServiceModel {
  int? id;
  String? image;
  String? name;
  String? description;
  bool? isSelected;
  List<SubServiceModel>? subServices;

  ServiceModel(
      {this.id,
      this.image,
      this.isSelected,
      this.name,
      this.description,
      this.subServices});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    isSelected = false;
    name = json['name'];
    description = json['description'];
    if (json['subServices'] != null) {
      subServices = [];
      json['subServices'].forEach((v) {
        subServices!.add(SubServiceModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['description'] = description;
    data['is_selected'] = isSelected;
    if (subServices != null) {
      data['subServices'] = subServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubServiceModel {
  int? id;
  String? image;
  String? name;
  String? description;
  bool? isSelected;

  SubServiceModel(
      {this.id, this.image, this.name, this.isSelected, this.description});

  SubServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['description'] = description;
    data['is_selected'] = isSelected;
    return data;
  }
}
