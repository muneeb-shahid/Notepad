import 'package:get/get.dart';
import 'package:notepad/routes/routes_name.dart';

import '../view/Start_Screen/Start_Screen.dart';
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
        // GetPage(
        //   name: RoutesName.SignUpPage,
        //   page: () => SignUpPage(),
        // ),
        // GetPage(
        //   name: RoutesName.BottomNav,
        //   page: () => BottomNav(),
        // ),
      
        // GetPage(
        //   name: RoutesName.CreateBlog,
        //   page: () => CreateBlog(),
        // ),
        // GetPage(
        //   name: RoutesName.HomePage,
        //   page: () => HomePage(),
        // ),
        // GetPage(name: RoutesName.Profile, page: () => Profile()),

        
      ];
}
