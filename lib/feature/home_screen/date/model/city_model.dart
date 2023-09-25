import 'Specialization.dart';

class CityModel {
  int? id;
  String? name;
  SpecializationModel? governrate;

  CityModel({this.id, this.name, this.governrate});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    governrate = json['governrate'] != null
        ? SpecializationModel.fromJson(json['governrate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (governrate != null) {
      data['governrate'] = governrate!.toJson();
    }
    return data;
  }
}