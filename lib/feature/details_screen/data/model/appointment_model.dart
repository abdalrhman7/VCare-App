class StoreAppointmentModel {
  final int doctorId;
  final String startTime;
  String? notes;

  StoreAppointmentModel({
    required this.doctorId,
    required this.startTime,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'doctor_id': doctorId,
      'start_time': startTime,
      'notes': notes,
    };
  }
}
