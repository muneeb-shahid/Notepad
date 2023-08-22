import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors_constants/colors_constants.dart';
import '../../home.dart';

class EmailVerificationController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void checkEmailVerification() async {
    User? user = _auth.currentUser;
    if (user != null && user.emailVerified) {
      // Navigate to home screen
      Get.to(home());
    } else {
      Get.snackbar(
        'Please verified your email', //Snackbar title
        'Please verify your email first', // Snackbar message
        icon: const Icon(Icons.verified_outlined, color: Colors.black),
        backgroundColor: Colors_Constants.app_white_color,
        colorText: Colors.black,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(
            seconds: 3), // Duration for which the Snackbar is shown
      );
    }
  }
}
