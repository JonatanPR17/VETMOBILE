import 'package:vetmobile/domain/auth/models/user_profile.dart';

class Appointment {
  int? appointmentNumber;
  String? date;
  String? time;
  String? type;
  String? reason;
  bool? state;
  int? branchId;
  int? petId;
  int? scheduleId;
  int? employeeId;
  int? serviceId;
  UserProfile? userProfile;

  // Constructor tradicional, similar al de UserProfile
  Appointment({
    this.appointmentNumber,
    this.date,
    this.time,
    this.type,
    this.reason,
    this.state,
    this.branchId,
    this.petId,
    this.scheduleId,
    this.employeeId,
    this.serviceId,
    this.userProfile,
  });

  // Método para crear un objeto Appointment a partir de un Map JSON (deserialización)
  Appointment.fromJson(Map<String, dynamic> json) {
    appointmentNumber = json['appointmentNumber'];
    date = json['date'];
    time = json['time'];
    type = json['type'];
    reason = json['reason'];
    state = json['state'];
    branchId = json['branchId'];
    petId = json['petId'];
    employeeId = json['employeeId'];
    serviceId = json['serviceId'];
    scheduleId = json['scheduleId'];
    userProfile = json['userProfile'] != null ? UserProfile.fromJson(json['userProfile']) : null;
  }

  // Método para convertir un objeto Appointment a Map (serialización)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointmentNumber'] = this.appointmentNumber;
    data['date'] = this.date;
    data['time'] = this.time;
    data['type'] = this.type;
    data['reason'] = this.reason;
    data['state'] = this.state;
    data['branchId'] = this.branchId;
    data['petId'] = this.petId;
    data['employeeId'] = this.employeeId;
    data['serviceId'] = this.serviceId;
    data['scheduleId'] = this.scheduleId;
    if (this.userProfile != null) {
      data['userProfile'] = this.userProfile!.toJson();
    }
    return data;
  }
}
