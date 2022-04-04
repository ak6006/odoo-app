import 'package:get/get.dart';

import '../attendance_model.dart';

class AttendanceProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Attendance.fromJson(map);
      if (map is List)
        return map.map((item) => Attendance.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Attendance?> getAttendance(int id) async {
    final response = await get('attendance/$id');
    return response.body;
  }

  Future<Response<Attendance>> postAttendance(Attendance attendance) async =>
      await post('attendance', attendance);
  Future<Response> deleteAttendance(int id) async =>
      await delete('attendance/$id');
}
