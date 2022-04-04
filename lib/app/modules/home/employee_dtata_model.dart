// To parse this JSON data, do
//
//     final employeeDtata = employeeDtataFromJson(jsonString);

import 'dart:convert';

List<EmployeeDtata> employeeDtataFromJson(String str) => List<EmployeeDtata>.from(json.decode(str).map((x) => EmployeeDtata.fromJson(x)));

String employeeDtataToJson(List<EmployeeDtata> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class EmployeeDtata {
  dynamic id;
  dynamic name;
  dynamic latitude;
  dynamic longitude;

  EmployeeDtata({this.id, this.name, this.latitude, this.longitude});

  EmployeeDtata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
