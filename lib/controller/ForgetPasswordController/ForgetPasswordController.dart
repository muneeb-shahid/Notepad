import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad/view/login/login.dart';

import '../../constants/colors_constants/colors_constants.dart';

class ForgetPasswordController extends GetxController {
  FocusNode _focusNode1 = FocusNode();
  get focusNode1 => _focusNode1;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  get formKey => _formKey;

  final TextEditingController _forget_EmailTextEditingController =
      TextEditingController();
  get forget_emailAddress => _forget_EmailTextEditingController;

  Future<void> resetPassword() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
            email: _forget_EmailTextEditingController.text.trim());
        Get.offAll(Login());

        Get.snackbar(
          'Reset Password',
          "Password reset email has been sent to ${_forget_EmailTextEditingController.text} ",
          icon: const Icon(Icons.send_outlined, color: Colors.black),
          backgroundColor: Colors_Constants.app_white_color,
          colorText: Colors.black,
          snackPosition: SnackPosition.TOP,
        );
      } on FirebaseAuthException catch (e) {
        print(e);
        if (e.code == 'user-not-found') {
          print('No email found.');
          Get.snackbar(
            'Error',
            "${_forget_EmailTextEditingController.text} email is not found in our database",
            icon: const Icon(Icons.error_outline, color: Colors.black),
            backgroundColor: Colors_Constants.app_white_color,
            colorText: Colors.black,
            snackPosition: SnackPosition.TOP,
          );
        }
      }
      _forget_EmailTextEditingController.clear();
    }
  }

  @override
  void dispose() {
    _forget_EmailTextEditingController.dispose();
    _focusNode1.dispose();

    super.dispose();
  }
}
