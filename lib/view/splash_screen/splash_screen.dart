import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad/constants/colors_constants/colors_constants.dart';
import 'package:notepad/controller/splash_screen_controller/splash_screen_controller.dart';
import 'package:notepad/images/images.dart';
import 'package:notepad/view/Start_Screen/Start_Screen.dart';

class splash_screen extends StatelessWidget {
  const splash_screen({super.key});

  @override
  Widget build(BuildContext context) {
    splash_screen_controller _splash_Controller =
        Get.put(splash_screen_controller());
    return Scaffold(
        backgroundColor: Colors_Constants.app_background_color,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset(App_Images.splash_screen_image))
          ],
        ));
  }
}
