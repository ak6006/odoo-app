import 'dart:convert';

import 'package:elessam_services/app/data/const.dart';
import 'package:elessam_services/app/modules/home/attendance_model.dart';
import 'package:elessam_services/app/modules/home/views/position.dart';
import 'package:elessam_services/app/modules/signInScreen/views/sign_in_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:odoo_rpc/odoo_rpc.dart';

import '../../signInScreen/controllers/sign_in_screen_controller.dart';
import '../../signInScreen/user_model.dart';
import '../../signInScreen/views/components/bezierContainer.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    // final ButtonStyle style =
    //     ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    final HomeController c = Get.put(HomeController());
    // c.updateAttendanceControl(attendance);
    return Scaffold(
      appBar: AppBar(
        // title: new Text(
        //   "",
        //   style: TextStyle(color: Colors.amber),
        // ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // leading: TextButton.icon(
        //   onPressed: () async {
        //     controller.isLoading.value = true;
        //     // user = (userFromJson)(jsonEncode(session));
        //     final res2 = await getEmployeeData(user.userId);
        //     print(res2);
        //     employeeId = prefs.read('employeeId');
        //     latitude = prefs.read('latitude');
        //     longitude = prefs.read('longitude');
        //     controller.resetsetting();
        //     attendance.clear();

        //     final res = await getEmployeeAttendance();

        //     controller.updateAttendanceControl(attendance);
        //     controller.isLoading.value = false;
        //   },
        //   icon: const Icon(
        //     Icons.update,

        //     color: Color.fromARGB(255, 247, 137, 43), // add custom icons also
        //   ),
        //   label: Text('تحديث بيانات'),
        // ),

        actions: <Widget>[
          // TextButton.icon(
          //     onPressed: () {}, icon: Icon(Icons.update), label: Text('gggg')),
          TextButton.icon(
            onPressed: () async {
              controller.isLoading.value = true;
              // user = (userFromJson)(jsonEncode(session));
              final res2 = await getEmployeeData(user.userId);
              // print('kkk' +res2.toString());
              employeeId = prefs.read('employeeId');
              latitude = prefs.read('latitude');
              longitude = prefs.read('longitude');
              controller.resetsetting();
              print(latitude);
              attendance.clear();

              final res = await getEmployeeAttendance();

              controller.updateAttendanceControl(attendance);
              controller.isLoading.value = false;
            },
            icon: const Icon(
              Icons.update,

              color: Color.fromARGB(255, 247, 137, 43), // add custom icons also
            ),
            label: const Text(
              'تحديث بيانات',
              style: TextStyle(
                  color: Color.fromARGB(255, 214, 168, 60),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            width: 120,
          ),
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: TextButton.icon(
                label: const Text(
                  'خروج',
                  style: TextStyle(
                      color: Color.fromARGB(255, 214, 168, 60),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  prefs.remove('employeeId');
                  prefs.remove('latitude');
                  prefs.remove('longitude');
                  prefs.remove('userid');
                  prefs.remove('userpassword');
                  Get.put(SignInScreenController());
                  Get.offAll(() => SignInScreenView());
                },
                icon: const Icon(
                  Icons.logout,
                  color: Color.fromARGB(255, 247, 137, 43),
                ),
              )),
        ],
      ),
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: -height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(height: 80),
                    // _emailPasswordWidget(),
                    // SizedBox(height: 20),
                    Container(),
                    Obx(
                      () => controller.isLoading.value
                          ? const CircularProgressIndicator(
                              color: Color(0xffe46b10))
                          : Column(
                              children: [
                                employeeGetIn('تسجيل حضور'),
                                SizedBox(height: 50),
                                employeeGetOut('تسجيل انصراف'),
                              ],
                            ),
                    ),

                    SizedBox(height: height * .055),
                    // _createAccountLabel(),
                  ],
                ),
              ),
            ),
            // Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text: 'مجموعة ',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10)),
          children: [
            TextSpan(
              text: 'العصام ',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: '\n موارد بشرية',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  Widget employeeGetIn(String title) {
    return Obx(
      () => InkWell(
        onTap: controller.buttonin.value
            ? null
            : () async {
                controller.isLoading.value = true;
                print((latitude));
                if (latitude == false || longitude == false) {
                  controller.showMessage(
                      "لا يوجد لديك احداثيات موقع على النظام \n  يرجى مراجعة مسؤول النظام");
                  controller.isLoading.value = false;
                  return;
                }

                final log = await controller.getcurrentPosition();
                // double distanceInMeters = Geolocator.distanceBetween(
                //     double.parse(latitude),
                //     double.parse(longitude),
                //     controller.position.value.latitude,
                //     controller.position.value.longitude);
                // //  print(controller.position.value.latitude);
                // //  print(controller.position.value.longitude);
                // print(distanceInMeters);
                // if (distanceInMeters > 2.0) {
                //   controller.showMessage(
                //       "لقد تجاوزت المسافة المسموح بها \n يرجى المحاولة في موضع بالقرب من موقعك");
                //   controller.isLoading.value = false;
                //   return;
                // }

                // return;
                if (log) {
                  try {
                    DateTime now = DateTime.now();
                    String formattedDate =
                        DateFormat('yyyy-MM-dd hh:mm:ss').format(now);
                    check_in = await orpc.callKw({
                      'model': 'hr.attendance',
                      'method': 'create',
                      'args': [
                        {
                          'employee_id': employeeId,
                          'check_in': formattedDate //'2022-03-19 15:50:04'
                        },
                      ],
                      'kwargs': {},
                    });
                    print(check_in);
                    final att = Attendance(
                        id: check_in,
                        employeeId: [employeeId],
                        checkIn: formattedDate,
                        checkOut: false);
                    attendance.add(att);
                    controller.updateAttendanceControl(attendance);
                    controller.isLoading.value = false;
                    Get.snackbar(
                      "تم تسجيل الحضور",
                      'عملية ناجحة',
                      duration: const Duration(seconds: 5),
                    );
                  } catch (e) {
                    controller.isLoading.value = false;
                    print(e);
                  }
                }
              },
        child: Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    // Color(0xfffbb448),
                    // Color.fromARGB(255, 247, 137, 43)
                    controller.colorin.value, controller.colorin.value
                  ])),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget employeeGetOut(String title) {
    return Obx(() => InkWell(
          onTap: controller.buttonout.value
              ? null
              : () async {
                  controller.isLoading.value = true;
                  if (latitude == false || longitude == false) {
                    controller.showMessage(
                        "لا يوجد لديك احداثيات موقع على النظام \n  يرجى مراجعة مسؤول النظام");
                    controller.isLoading.value = false;
                    return;
                  }

                  final log = await controller.getcurrentPosition();
                  // double distanceInMeters = Geolocator.distanceBetween(
                  //     double.parse(latitude),
                  //     double.parse(longitude),
                  //     controller.position.value.latitude,
                  //     controller.position.value.longitude);
                  // //  print(controller.position.value.latitude);
                  // //  print(controller.position.value.longitude);
                  // print(distanceInMeters);
                  // if (distanceInMeters > 2.0) {
                  //   controller.showMessage(
                  //       "لقد تجاوزت المسافة المسموح بها \n يرجى المحاولة في موضع بالقرب من موقعك");
                  //   controller.isLoading.value = false;
                  //   return;
                  // }
                  if (log) {
                    try {
                      final id = attendance[0].id;
                      DateTime now = DateTime.now();
                      String formattedDate =
                          DateFormat('yyyy-MM-dd hh:mm:ss').format(now);
                      check_out = await orpc.callKw({
                        'model': 'hr.attendance',
                        'method': 'write',
                        'args': [
                          id,
                          {
                            // 'employee_id': employeeId,
                            'check_out': formattedDate //'2022-03-19 15:50:04'
                          },
                        ],
                        'kwargs': {},
                      });
                      print(formattedDate);
                      // final att = Attendance(
                      //     id: check_in,
                      //     employeeId: [employeeId],
                      //     checkIn: formattedDate,
                      //     checkOut: false);
                      // attendance.add(att);
                      attendance[0].checkOut = formattedDate;
                      controller.isLoading.value = false;
                      controller.updateAttendanceControl(attendance);
                         Get.snackbar(
                      "تم تسجيل الانصراف",
                      'عملية ناجحة',
                      duration: const Duration(seconds: 5),
                    );
                    } catch (e) {
                      controller.isLoading.value = false;
                      print(e);
                    }
                  }
                },
          child: Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.shade200,
                      offset: Offset(2, 4),
                      blurRadius: 5,
                      spreadRadius: 2)
                ],
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      controller.colorout.value,
                      controller.colorout.value
                    ])),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ));
  }
}
