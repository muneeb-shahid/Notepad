import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors_constants/colors_constants.dart';
import '../../home.dart';

MediaQueryData mediaQueryData = Get.mediaQuery;

class EmailVerificationController extends GetxController {
  double screenHeight = mediaQueryData.size.height * 1;
  double screenWidth = mediaQueryData.size.width * 1;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Timer? timer;
  bool _isEmailVerified = false;
  get isEmailVerified => _isEmailVerified;

  sendEmailVerificationCode() async {
    User? user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      Get.snackbar(
        'Email Verification', //Snackbar title
        'Verification email sent to ${user.email}', // Snackbar message
        icon: const Icon(Icons.verified_outlined, color: Colors.black),
        backgroundColor: Colors_Constants.app_white_color,
        colorText: Colors.black,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(
            seconds: 3), // Duration for which the Snackbar is shown
      );
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    User? isEmailVerified = FirebaseAuth.instance.currentUser;

    if (!_isEmailVerified) {
      sendEmailVerificationCode();
      timer = Timer.periodic(Duration(seconds: 3), (timer) {
        checkEmailVerified();
      });
    }
    super.onInit();
  }

  @override
  void dispose() {
    timer?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    _isEmailVerified = !_isEmailVerified;

    _isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (isEmailVerified) {
      Get.to(home());
    }
  }
}
