import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/signInScreen/bindings/sign_in_screen_binding.dart';
import '../modules/signInScreen/views/sign_in_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGN_IN_SCREEN;
 static const HOMEDIR = Routes.HOME;
  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN_SCREEN,
      page: () => SignInScreenView(),
      binding: SignInScreenBinding(),
    ),
  ];
}
