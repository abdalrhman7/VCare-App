import 'Specialization.dart';
import 'city_model.dart';
import 'home_model.dart';

class DoctorModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? photo;
  String? gender;
  String? address;
  String? description;
  String? degree;
  SpecializationModel? specialization;
  CityModel? city;
  int? appointPrice;
  String? startTime;
  String? endTime;

  DoctorModel(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.photo,
        this.gender,
        this.address,
        this.description,
        this.degree,
        this.specialization,
        this.city,
        this.appointPrice,
        this.startTime,
        this.endTime});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'];
    gender = json['gender'];
    address = json['address'];
    description = json['description'];
    degree = json['degree'];
    specialization = json['specialization'] != null
        ? SpecializationModel.fromJson(json['specialization'])
        : null;
    city = json['city'] != null ? CityModel.fromJson(json['city']) : null;
    appointPrice = json['appoint_price'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['photo'] = photo;
    data['gender'] = gender;
    data['address'] = address;
    data['description'] = description;
    data['degree'] = degree;
    if (specialization != null) {
      data['specialization'] = specialization!.toJson();
    }
    if (city != null) {
      data['city'] = city!.toJson();
    }
    data['appoint_price'] = appointPrice;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    return data;
  }
}