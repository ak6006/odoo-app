import 'package:get/get.dart';

import '../employee_dtata_model.dart';

class EmployeeDtataProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return EmployeeDtata.fromJson(map);
      if (map is List)
        return map.map((item) => EmployeeDtata.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<EmployeeDtata?> getEmployeeDtata(int id) async {
    final response = await get('employeedtata/$id');
    return response.body;
  }

  Future<Response<EmployeeDtata>> postEmployeeDtata(
          EmployeeDtata employeedtata) async =>
      await post('employeedtata', employeedtata);
  Future<Response> deleteEmployeeDtata(int id) async =>
      await delete('employeedtata/$id');
}
