import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notepad/constants/colors_constants/colors_constants.dart';
import 'package:notepad/constants/fonts_size_constant/fonts_size_constant.dart';
import 'package:notepad/customButtons/Login&signupButton.dart';
import 'package:notepad/home.dart';
import 'package:notepad/view/login/login.dart';
import 'package:lottie/lottie.dart';

import '../../controller/EmailVerificationController/EmailVerificationController.dart';
import '../../images/images.dart';
import '../HomeScreen/Home_screen.dart';

class EmailVerification extends StatelessWidget {
  EmailVerification({super.key});

  EmailVerificationController emailVerificationController =
      Get.put(EmailVerificationController());
  var user = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) => emailVerificationController
          .isEmailVerified
      ? HomePage()
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
                        Image(image: AssetImage(App_Images.top_left_shape)),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          child: Text(
                            'A verification email has been sent to \n\n${user}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily:
                                    Fonts_Size_Constants.regular_font_family,
                                fontWeight: FontWeight.bold,
                                color: Colors_Constants.app_grey_color,
                                fontSize:
                                    Fonts_Size_Constants.text_font_size.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: emailVerificationController.screenHeight * 0.05,
                    ),
                    Container(
                      height: emailVerificationController.screenHeight * 0.3,
                      child: Lottie.asset(
                        App_Images.verify_email_lottie_image,
                        repeat: true,
                        reverse: false,
                        animate: true,
                      ),
                    ),
                    SizedBox(
                      height: emailVerificationController.screenHeight * 0.05,
                    ),
                    customLogin_SignupButton(
                        func: () => emailVerificationController
                            .sendEmailVerificationCode(),
                        innerColor: Colors_Constants.app_pink_color,
                        textColor: Colors_Constants.app_white_color,
                        text: "Resend Email"),
                    SizedBox(
                      height: emailVerificationController.screenHeight * 0.05,
                    ),
                    customLogin_SignupButton(
                        func: () => emailVerificationController.signOut(),
                        innerColor: Colors_Constants.app_grey_color,
                        textColor: Colors_Constants.app_white_color,
                        text: "Cancel"),
                  ],
                ),
              )),
        );
}
