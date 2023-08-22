import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad/constants/colors_constants/colors_constants.dart';

import '../../view/EmailVerification/EmailVerificationController.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Timer? timer;
  bool _isEmailVerified = false;
  get isEmailVerified => _isEmailVerified;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  get formKey => _formKey;
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  get NameTextEditingController => _nameTextEditingController;

  final TextEditingController _emailTextEditingController =
      TextEditingController();
  get emailAddress => _emailTextEditingController;

  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  get password => _passwordTextEditingController;

  String? validateName(String? input) {
    if (input == null || input.isEmpty) {
      return 'User name is required.';
    }

    return null;
  }

  register(context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress.text,
          password: password.text,
        );
        // sendEmailVerificationCode();
        Get.to(EmailVerification());
        //  User user = credential.user!;
        // User? user = _auth.currentUser;
        // if (user != null && !user.emailVerified) {
        //   await user.sendEmailVerification();
        //   Get.snackbar(
        //     'Email Verification', //Snackbar title
        //     'Verification email sent to ${user.email}', // Snackbar message
        //     icon: const Icon(Icons.verified_outlined, color: Colors.black),
        //     backgroundColor: Colors_Constants.app_white_color,
        //     colorText: Colors.black,
        //     snackPosition: SnackPosition.TOP,
        //     duration: const Duration(
        //         seconds: 3), // Duration for which the Snackbar is shown
        //   );
        //   Get.to(EmailVerification());
        // }

        // Get.to(Login());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          Get.snackbar(
            'Account Already Exists. ', //Snackbar title
            'Please Login!', // Snackbar message
            icon: const Icon(Icons.error_outline, color: Colors.black),
            backgroundColor: Colors_Constants.app_white_color,
            colorText: Colors.black,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(
                seconds: 3), // Duration for which the Snackbar is shown
          );
        }
      } catch (e) {
        print(e);
        Get.snackbar(
          'Error!', //Snackbar title
          e.toString(), // Snackbar message
          icon: const Icon(Icons.error_outline, color: Colors.black),
          backgroundColor: Colors_Constants.app_white_color,
          colorText: Colors.black,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(
              seconds: 3), // Duration for which the Snackbar is shown
        );
      }
    }
  }

  // sendEmailVerificationCode() async {
  //   User? user = _auth.currentUser;
  //   if (user != null && !user.emailVerified) {
  //     await user.sendEmailVerification();
  //     Get.to(EmailVerification());
  //     Get.snackbar(
  //       'Email Verification', //Snackbar title
  //       'Verification email sent to ${user.email}', // Snackbar message
  //       icon: const Icon(Icons.verified_outlined, color: Colors.black),
  //       backgroundColor: Colors_Constants.app_white_color,
  //       colorText: Colors.black,
  //       snackPosition: SnackPosition.TOP,
  //       duration: const Duration(
  //           seconds: 3), // Duration for which the Snackbar is shown
  //     );
  //   }
  // }

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   User? _isEmailVerified = FirebaseAuth.instance.currentUser;

  //   if (!isEmailVerified) {
  //     sendEmailVerification();
  //     timer = Timer.periodic(Duration(seconds: 3), (timer) {
  //       checkEmailVerified();
  //     });
  //   }
  //   super.onInit();
  // }

  // @override
  // void dispose() {
  //   timer?.cancel();
  //   // TODO: implement dispose
  //   super.dispose();
  // }

  // Future<void> checkEmailVerified() async {
  //   await FirebaseAuth.instance.currentUser!.reload();

  //   _isEmailVerified = !_isEmailVerified;

  //   _isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

  //   if (isEmailVerified) timer?.cancel();
  // }
}
