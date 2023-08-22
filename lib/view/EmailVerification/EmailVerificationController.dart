import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notepad/constants/colors_constants/colors_constants.dart';
import 'package:notepad/constants/fonts_size_constant/fonts_size_constant.dart';
import 'package:notepad/home.dart';

import '../../controller/EmailVerificationController/EmailVerificationController.dart';

class EmailVerification extends StatelessWidget {
  EmailVerification({super.key});

  EmailVerificationController emailVerificationController =
      Get.put(EmailVerificationController());
  var user = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) => emailVerificationController
          .isEmailVerified
      ? home()
      : Scaffold(
          backgroundColor: Colors_Constants.app_background_color,
          body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(image: AssetImage("assets/images/shape.png")),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'A verification email has been sent to \n\n${user}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily:
                                  Fonts_Size_Constants.regular_font_family,
                              fontWeight: FontWeight.bold,
                              color: Colors_Constants.app_grey_color,
                              fontSize: Fonts_Size_Constants.text_font_size.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: emailVerificationController.screenHeight * 0.1,
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: Text("Resend Email"))
                  ],
                ),
              )),
        );
}
