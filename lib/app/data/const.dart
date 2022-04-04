import 'dart:convert';
import 'dart:ui';
// import 'dart:ffi';

import 'package:elessam_services/app/modules/home/attendance_model.dart';
import 'package:elessam_services/app/modules/home/employee_dtata_model.dart';
import 'package:elessam_services/app/modules/signInScreen/user_model.dart';
import 'package:intl/intl.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
const primaryColor = Color.fromARGB(255, 247, 175, 109);
var orpc = OdooClient('https://100.elessam.com');
var session;
// var uid;

var check_in;
var check_out;
User user = User();
var prefs; //= await SharedPreferences.getInstance();
List<Attendance> attendance = <Attendance>[];
// List<EmployeeDtata> employeeData = <EmployeeDtata>[];

var  subscription;//= orpc.sessionStream.listen(sessionChanged);
var prev_session;

var employeeId;
dynamic latitude;
dynamic longitude;
dynamic userpassword;
sessionChanged(OdooSession sessionId) async {
  print('We got new session ID: ' + sessionId.id);
  // store_session_somehow(sessionId);
  prefs.write('sessionId', sessionId);
  // prefs.write('userid', sessionId.userLogin);
  // prefs.write('userpassword', userpassword);
}

Future<bool> login(String username, String password) async {
  try {
    session = await orpc.authenticate('elessam-15', username, password);
     user = (userFromJson)(jsonEncode(session));
    // sessionChanged(session);
    // uid = session.userId;
    // await prefs.write('userid', username);
    // await prefs.write('password', password);
    //  Get.offAll(() => HomeView());
    return true;
  } catch (e) {
    return false;
    // print('bbbbbbbbbbbbbbb');
    // print(e);
    // print('Authenticated');
  }
}

Future<bool> getEmployeeData(int? userid) async {
  try {
    var res = await orpc.callKw({
      'model': 'hr.employee',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          ['user_id', '=', userid] //session.userId
        ],
        'fields': ['id', 'name', 'latitude', 'longitude'],
      },
    });
    print(jsonEncode(res));
    // employeeData = (employeeDtataFromJson(jsonEncode(res)));
    // for (var emp in employeeData) {
    //   print(emp.latitude);
    // }
    // emp_id=(res[0]['id']).toInt();
    print( res[0]['latitude']);
    employeeId = res[0]['id'].toInt();
    latitude = res[0]['latitude'];
    longitude = res[0]['longitude'];
 //   print('hhhh   '+latitude);
    prefs.write('employeeId', employeeId);
    prefs.write('latitude', latitude);
    prefs.write('longitude', longitude);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> getEmployeeAttendance() async {
  try {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    var res = await orpc.callKw({
      'model': 'hr.attendance',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          '&', [('employee_id'), '=', (employeeId)],[('check_in'), '>=', formattedDate]],
        'fields': ['employee_id', 'check_in', 'check_out'],
      },
    });
    // emp_id = (res[0]['id']).toInt();

    print(formattedDate);
    attendance = (attendanceFromJson(jsonEncode(res)));
    print('bbbbb' + (attendance.length).toString());
    return true;
  } catch (e) {
    print('nnnnnnnnn');
    print(prefs.read('employeeId'));
    print(e);
    return false;
  }
}


 Future<bool> updateLocationStreamInfo() async {
    try {
      return true;
    } catch (e) {
      return false;
    }
  }

