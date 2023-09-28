import 'doctor_model.dart';

class HomeModel {
  int? id;
  String? name;
  List<DoctorModel>? doctors;

  HomeModel({this.id, this.name, this.doctors});

  HomeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['doctors'] != null) {
      doctors = <DoctorModel>[];
      json['doctors'].forEach((v) {
        doctors!.add(DoctorModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (doctors != null) {
      data['doctors'] = doctors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}





