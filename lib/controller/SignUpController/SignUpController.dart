import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad/constants/colors_constants/colors_constants.dart';

import '../../view/EmailVerification/EmailVerificationController.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
        //  User user = credential.user!;
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
          Get.to(EmailVerification());
        }

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Verification email sent!')),
        // );
        // Get.to(Login());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }
}
