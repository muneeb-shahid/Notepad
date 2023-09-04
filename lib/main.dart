import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notepad/controller/MyAppController/MyAppController.dart';
import 'package:notepad/view/BottomNav/BottomNav.dart';
import 'package:notepad/view/HomeScreen/Home_screen.dart';
import 'package:notepad/view/Note/Note.dart';
import 'package:notepad/view/Start_Screen/Start_Screen.dart';
import 'package:notepad/view/login/login.dart';
import 'package:notepad/view/signUp/signUp.dart';

import 'Routes/approutes.dart';
import 'firebase_options.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyAppController appController = Get.put(MyAppController());
    return ScreenUtilInit(
      designSize: const Size(360, 790),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Notepad',
          theme: ThemeData(
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          getPages: AppRoutes.appRoutes(),
          home: appController.user != null ? BottomNav() :  Start_Screen(),
        );
      },
    );
  }
}
