import 'dart:convert';

import 'package:elessam_services/app/modules/signInScreen/user_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import 'app/data/const.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  await GetStorage.init();
  prefs = GetStorage();
  prefs.listenKey('userpassword', (value) {
    print('new key is $value');
  });
  subscription = orpc.sessionStream.listen(sessionChanged);

  try {
    // final res = prefs.read('sessionId');
    final res = await prefs.read('userid');
    final pass = await prefs.read('userpassword');
    // print(res);
    if (res != null && pass != null) {
      // print(jsonEncode(res));

      // prev_session =  OdooSession.fromJson((res));
      print('biiiiiiiiiiiiiii');
      // print((prev_session));
      // orpc = await OdooClient("https://my-db.odoo.com", prev_session);
      session = await orpc.authenticate('elessam-15', res, pass);
      // orpc.sessionId
      user = (userFromJson)(jsonEncode(session));
      final res2 = await getEmployeeData(user.userId);
      print(res2);
      employeeId = prefs.read('employeeId');
      latitude = prefs.read('latitude');
      longitude = prefs.read('longitude');
      print('hhhhhhhh');
      print(orpc.sessionId);

      runApp(
        GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Application",
          initialRoute: AppPages.HOMEDIR,
          // theme: ThemeData(
          //   primaryColor: primaryColor,
          // ),
          getPages: AppPages.routes,
        ),
      );
    } else {
      runApp(
        GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Application",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        ),
      );
    }
  } on OdooException catch (e) {
    print(e);
    runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );
  }
}
