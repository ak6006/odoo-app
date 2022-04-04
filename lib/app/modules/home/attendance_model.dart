// To parse this JSON data, do
//
//     final attendance = attendanceFromJson(jsonString);

import 'dart:convert';

List<Attendance> attendanceFromJson(String str) => List<Attendance>.from(json.decode(str).map((x) => Attendance.fromJson(x)));

String attendanceToJson(List<Attendance> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Attendance {
  int? id;
  List<int>? employeeId;
  String? checkIn;
  dynamic? checkOut;

  Attendance({this.id, this.employeeId, this.checkIn, this.checkOut});

  Attendance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'].cast<int>();
    checkIn = json['check_in'];
    checkOut = json['check_out'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['employee_id'] = employeeId;
    data['check_in'] = checkIn;
    data['check_out'] = checkOut.toString();
    return data;
  }
}
