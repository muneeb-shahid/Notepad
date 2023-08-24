import 'package:get/get.dart';
import 'package:notepad/routes/routes_name.dart';
import 'package:notepad/view/signUp/signUp.dart';

import '../customButtons/login_signup_button.dart';
import '../view/EmailVerification/EmailVerification.dart';
import '../view/HomeScreen/Home_screen.dart';
import '../view/Start_Screen/Start_Screen.dart';
import '../view/forgetpassword/forgetpassword.dart';
import '../view/login/login.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RoutesName.Start_Screen,
          page: () => Start_Screen(),
        ),
        GetPage(
          name: RoutesName.Login,
          page: () => Login(),
        ),
        GetPage(name: RoutesName.SignUp, page: () => SignUp()),
        GetPage(
          name: RoutesName.EmailVerification,
          page: () => EmailVerification(),
        ),
        GetPage(
          name: RoutesName.EmailVerification,
          page: () => ForgetPassword(),
        ),
        GetPage(
          name: RoutesName.EmailVerification,
          page: () => HomePage(),
        ),
      ];
}
