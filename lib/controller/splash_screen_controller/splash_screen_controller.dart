import 'dart:async';

import 'package:get/get.dart';

import '../../view/Start_Screen/Start_Screen.dart';

class splash_screen_controller extends GetxController{

  @override
  void onInit() {
    Timer(Duration(seconds: 3), () {
      navigateToStartScreen();
    });
    super.onInit();
  }

  navigateToStartScreen() {
    Get.offAll(Start_Screen());
  }
}