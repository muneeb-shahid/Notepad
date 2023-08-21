import 'package:get/get.dart';
import 'package:notepad/routes/routes_name.dart';
import 'package:notepad/view/signUp/signUp.dart';

import '../customButtons/login_signup_button.dart';
import '../view/Start_Screen/Start_Screen.dart';
import '../view/login/login.dart';
import '../view/splash_screen/splash_screen.dart';


class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RoutesName.splash_screen,
          page: () => splash_screen(),
        ),
        GetPage(
          name: RoutesName.Start_Screen,
          page: () => Start_Screen(),
        ),
       
      
      
        GetPage(
          name: RoutesName.Login,
          page: () => Login(),
        ),
        GetPage(name: RoutesName.SignUp, page: () => SignUp()),

        
      ];
}
