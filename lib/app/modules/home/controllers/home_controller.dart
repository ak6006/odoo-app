import 'dart:async';

import 'package:elessam_services/app/data/const.dart';
import 'package:elessam_services/app/modules/home/views/position.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:geolocator_apple/geolocator_apple.dart';
import 'package:geolocator_android/geolocator_android.dart';

import '../attendance_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  // RxBool buttonin = true.obs;
  //  bool get isDark => prefs.read('darkmode') ?? false;
  final buttonin = false.obs;
  final buttonout = false.obs;
  final attendanceControl = <Attendance>[].obs;
  final colorin = Color.fromARGB(255, 247, 137, 43).obs;
  final colorout = Color.fromARGB(255, 247, 137, 43).obs;
  final isLoading = false.obs;
  final serviceEnabled = false.obs;
  final permission = LocationPermission.denied.obs;
  final startTime =
      DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()).obs;

  final endtTime = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()).obs;

  final locationStreamId =0.obs;
  // final position =<Position>[].obs;
  final position = Position(
          longitude: 0,
          latitude: 0,
          timestamp: null,
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0)
      .obs;
  // final LocationSettings locationSettings =  LocationSettings(
  //   accuracy: LocationAccuracy.high,
  //   distanceFilter: 100,
  // );
  // late StreamSubscription<Position> positionStream;
  // // final position = Rx<Position>;
// final position = Position().obs;

  showMessage(String str) {
    Get.defaultDialog(
        title: "خطاء في الوصول",
        middleText: str,
        backgroundColor: Color.fromARGB(255, 206, 160, 33),
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        radius: 30);
  }

  resetsetting() {
    colorout.value = const Color.fromARGB(255, 247, 137, 43);
    colorin.value = const Color.fromARGB(255, 247, 137, 43);
    buttonin.value = false;
    buttonout.value = false;
  }

  Future<bool> getcurrentPosition() async {
    // position.v=null;
    serviceEnabled.value = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled.value) {
      //  print(serviceEnabled);
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      showMessage(
          "خدمة تحديد المواقع غير مفعلة \n يرجى تفعيل الخدمة والمحاولة مجددا ");
      isLoading.value = false;
      return false; // Future.error('Location services are disabled.');
    }

    permission.value = await Geolocator.checkPermission();

    if (permission.value == LocationPermission.denied) {
      permission.value = await Geolocator.requestPermission();
      if (permission.value == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        showMessage('لا يمكن اجراء العملية \n يجب الوصول لخدمة تحديد المواقع');
        isLoading.value = false;
        return false; // Future.error('Location permissions are denied');
      }
    }
    print('vvv  ${permission.value}');

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      showMessage(
          'لا يمكن اجراء العملية \n لا يمكن الوصول لخدمة تحديد المواقع');
      isLoading.value = false;
      return false;
      //  Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    position.value = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    double distanceInMeters = Geolocator.distanceBetween(
        double.parse(latitude),
        double.parse(longitude),
        position.value.latitude,
        position.value.longitude);
    print(position.value.latitude);
    print(position.value.longitude);

    // double bearing = Geolocator.bearingBetween(
    //    double.parse(latitude),
    //     double.parse(longitude),
    //     position.value.latitude,
    //     position.value.longitude);
    // print(distanceInMeters);
    if (distanceInMeters > 25.0) {
      showMessage(
          "لقد تجاوزت المسافة المسموح بها \n يرجى المحاولة في موضع بالقرب من موقعك \n المسافة الحالية هي : ${distanceInMeters.toInt()} متر");
      isLoading.value = false;
      return false;
    }
    print('المسافة هي    $distanceInMeters ');
    isLoading.value = false;
    // print(());
    return true;
  }

  updateButtonIn(bool state, Color color) {
    buttonin(state);
    colorin(color);
  }

  updateButtonout(bool state, Color color) {
    buttonout(state);
    colorout(color);
  }

//   Future getUserInfo() async {
//     //## user = userFromJson(jsonEncode(orpc.sessionId));
//         // final tm = await getEmployeeData(user.userId);
//         // final x = prefs.read('employeeId');
//         // if(employeeId)
//         // {
//         //   print('goooooooooooooooooooooood');
//         // }

//         //  print(user.userId);
//       //  final res= await  getEmployeeAttendance();
//         //  Get.offAll(() => HomeView());
// }

  updateAttendanceControl(List<Attendance> att) {
    // ignore: unrelated_type_equality_checks
    if (att.isNotEmpty && att[0].checkIn != false) {
      updateButtonIn(true, const Color.fromARGB(255, 179, 179, 179));
    }
    if (att.isNotEmpty && att[0].checkOut != false) {
      updateButtonout(true, Color.fromARGB(255, 184, 179, 179));
    }
    if (att.isEmpty) {
      updateButtonout(true, Color.fromARGB(255, 184, 179, 179));
    }
    if (att.isNotEmpty && att[0].checkIn != false && att[0].checkOut == false) {
      updateButtonout(false, Color.fromARGB(255, 247, 137, 43));
    }

    attendanceControl.value = att;
  }

 
  @override
  Future<void> onInit() async {
// buttonin.value=false;

// attendanceControl.assignAll(attendance);
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    permission.value = await Geolocator.requestPermission();
    if (permission.value == LocationPermission.denied) {
      await Get.dialog(
        AlertDialog(
          title: const Text("الوصول"),
          content: const Text(
              "يرجى السماح للتطبيق الوصول بشكل دائم\n لخدمة تحديد المواقع"),
          actions: <Widget>[
            TextButton(
              child: const Text("موافق"),
              onPressed: () async {
                if (permission.value == LocationPermission.denied) {
                  permission.value = await Geolocator.requestPermission();
                } else {
                  Get.back();
                }
              },
            )
          ],
        ),
        barrierDismissible: false,
      );
    }
    // const LocationSettings locationSettings = LocationSettings(
    //   accuracy: LocationAccuracy.high,
    //   distanceFilter: 10,
    //   // timeLimit: Duration.microsecondsPerSecond,
    // );
    late LocationSettings locationSettings;

if (defaultTargetPlatform == TargetPlatform.android) {
  locationSettings = AndroidSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 10,
    forceLocationManager: true,
    intervalDuration: const Duration(seconds: 10),
    //(Optional) Set foreground notification config to keep the app alive 
    //when going to the background
    foregroundNotificationConfig: const ForegroundNotificationConfig(
        notificationText:
        "مجموعة العصام",
        notificationTitle: "تتبع المواقع للموظف",
        enableWakeLock: true,
    )
  );
} else if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
  locationSettings = AppleSettings(
    accuracy: LocationAccuracy.high,
    activityType: ActivityType.fitness,
    distanceFilter: 10,
    pauseLocationUpdatesAutomatically: true,
    // Only set to true if our app will be started up in the background.
    showBackgroundLocationIndicator: true,
  );
} else {
    locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 10,
  );
}
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) async {
      print(position == null
          ? 'Unknown'
          : '${position.latitude.toString()}, ${position.longitude.toString()}');
    
      // startTime.value = endtTime.value;
if(locationStreamId.value != 0)
{
    endtTime.value = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
      startTime.value = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
   await orpc.callKw({
        'model': 'hr.tracking',
        'method': 'write',
        'args': [
          locationStreamId.value,
          {
           
            'end_date': endtTime.value, //'2022-03-19 15:50:04'
            
          },
        ],
        'kwargs': {},
      });
}
    locationStreamId.value=  await orpc.callKw({
        'model': 'hr.tracking',
        'method': 'create',
        'args': [
          {
            'employee': employeeId,
            'rq_date': startTime.value,
            // 'end_date': endtTime.value, //'2022-03-19 15:50:04'
            'latitude': position?.latitude.toString(),
            'longitude': position?.longitude.toString()
          },
        ],
        'kwargs': {},
      });
      print(locationStreamId.value);
      startTime.value =
          DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
    });
    // positionStream.isBlank
    // subscription = orpc.sessionStream.listen(sessionChanged);
    super.onReady();
    // determinePosition().then((value) async {

    final res = await getEmployeeAttendance();

    updateAttendanceControl(attendance);

    // final log = await getcurrentPosition();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
