import 'package:get/route_manager.dart';
import 'package:gui/screens/home/home.dart';

part 'user_routes.dart';

class AppPages {
  // static const String inital = UserRoutes.splash;

  static final routes = [
    // GetPage(
    //   transition: Transition.cupertino,
    //   name: UserRoutes.signUp,
    //   page: () => const SignUpPage(),
    // ),
    // GetPage(
    //   transition: Transition.cupertino,
    //   name: UserRoutes.login,
    //   page: () => const LoginPage(),
    // ),
    // GetPage(
    //   transition: Transition.cupertino,
    //   name: UserRoutes.home,
    //   page: () => HomePage(),
    // ),
    GetPage(
      transition: Transition.cupertino,
      name: UserRoutes.home,
      page: () => HomePage(),
    ),
  ];
}
