import '../../../home_screen/date/model/doctor_model.dart';

class AppointmentModel {
  int? id;
  DoctorModel? doctor;
  Patient? patient;
  String? appointmentTime;
  String? appointmentEndTime;
  String? status;
  String? notes;
  int? appointmentPrice;

  AppointmentModel(
      {this.id,
      this.doctor,
      this.patient,
      this.appointmentTime,
      this.appointmentEndTime,
      this.status,
      this.notes,
      this.appointmentPrice});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctor =
        json['doctor'] != null ? DoctorModel.fromJson(json['doctor']) : null;
    patient =
        json['patient'] != null ? Patient.fromJson(json['patient']) : null;
    appointmentTime = json['appointment_time'];
    appointmentEndTime = json['appointment_end_time'];
    status = json['status'];
    notes = json['notes'];
    appointmentPrice = json['appointment_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (doctor != null) {
      data['doctor'] = doctor!.toJson();
    }
    if (patient != null) {
      data['patient'] = patient!.toJson();
    }
    data['appointment_time'] = appointmentTime;
    data['appointment_end_time'] = appointmentEndTime;
    data['status'] = status;
    data['notes'] = notes;
    data['appointment_price'] = appointmentPrice;
    return data;
  }
}

class Patient {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? gender;

  Patient({this.id, this.name, this.email, this.phone, this.gender});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['gender'] = gender;
    return data;
  }
}
