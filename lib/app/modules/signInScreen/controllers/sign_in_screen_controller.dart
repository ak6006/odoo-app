// import 'dart:convert';
// import 'package:get_storage/get_storage.dart';
// import 'package:elessam_services/app/data/const.dart';
// import 'package:elessam_services/app/modules/signInScreen/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../../home/views/home_view.dart';

class SignInScreenController extends GetxController {
  //TODO: Implement SignInScreenController

  final count = 0.obs;
  final isLoading = false.obs;
  // final permission = LocationPermission.denied.obs;
//  final prefs =SharedPreferences.getInstance();

//  Future<SharedPreferences> get init_perfer async => await SharedPreferences.getInstance();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    //  await    Get.defaultDialog(
    //     title: permission.value.toString(),
    //     middleText: 'يرجى السماح للتطبيق الوصول بشكل دائم\n لخدمة تحديد المواقع',
    //     backgroundColor: Color.fromARGB(255, 206, 160, 33),
    //     titleStyle: TextStyle(color: Colors.white),
    //     middleTextStyle: TextStyle(color: Colors.white),
    //     radius: 30);

    // await Get.snackbar(

    //    "تحذير"
    //  ,'يرجى السماح للتطبيق الوصول بشكل دائم\n لخدمة تحديد المواقع', duration:Duration(seconds: 5),);
//      if(permission.value == LocationPermission.denied )

//      {

//         await Get.defaultDialog(
//         title: permission.value.toString(),
//         middleText: 'يرجى السماح للتطبيق الوصول بشكل دائم\n لخدمة تحديد المواقع',
//         backgroundColor: Color.fromARGB(255, 206, 160, 33),
//         titleStyle: TextStyle(color: Colors.white),
//         middleTextStyle: TextStyle(color: Colors.white),
//         radius: 30,onConfirm: (){}).then((value) async {
//  permission.value = await Geolocator.requestPermission();
//         });}
//  permission.value = await Geolocator.requestPermission();
//    print(permission.value.toString());
//     do {
//       await Get.dialog(
//         AlertDialog(
//           title: const Text("الوصول"),
//           content: const Text(
//               "يرجى السماح للتطبيق الوصول بشكل دائم\n لخدمة تحديد المواقع"),
//           actions: <Widget>[
//             TextButton(
//               child: const Text("موافق"),
//               onPressed: () async {
//                 if (permission.value == LocationPermission.denied) {
//                   permission.value = await Geolocator.requestPermission();
//                 }else {
//                   Get.back();
//                 }
//               },
//             )
//           ],
//         ),
//         barrierDismissible: false,
//       );
//       print(permission.value.toString());
//     } while (permission.value == LocationPermission.denied);

    // prefs = GetStorage();
    // print(prefs.read('userid'));
    // final x = prefs.read('userid');
    // if (orpc.sessionId != null) {
    // //##  user = userFromJson(jsonEncode(orpc.sessionId));
    //   print('yyyyyyyyyyyyyy');
    //   await getUserInfo();
    //   // Get.offAll(() => HomeView());
    // } else

    //  if (x != null) {
    //   final log =await login(prefs.read('userid'), prefs.read('password'));
    //  print(log);
    //   if (log == true) {
    //     getUserInfo();
    //   }
    // } else {
    //   print('mmmmmmmmmmmmmmmmm');
    // }
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
