import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notepad/constants/colors_constants/colors_constants.dart';
import 'package:notepad/customButtons/login_signup_button.dart';
import 'package:notepad/view/signUp/signUp.dart';

import '../../constants/fonts_size_constant/fonts_size_constant.dart';
import '../login/login.dart';

class Start_Screen extends StatelessWidget {
  const Start_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    var heightt = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      backgroundColor: Colors_Constants.app_background_color,
      body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Welcome to UpTodo",
                        style: TextStyle(
                            color: Colors_Constants.app_white_color,
                            fontWeight: FontWeight.bold,
                            fontSize: Fonts_Size_Constants.heading_font_size.sp,
                            fontFamily:
                                Fonts_Size_Constants.regular_font_family),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: heightt * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Please login to your account \nor create new account to continue",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors_Constants.app_white_color_70,
                            fontSize:
                                Fonts_Size_Constants.sub_heading_font_size.sp,
                            fontFamily:
                                Fonts_Size_Constants.regular_font_family),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: heightt * 0.5,
                ),
                Login_SignUp_Button().customButton(context,
                nextScreen: Login(),
                    innerColor: Colors_Constants.app_blue_color,
                    textColor: Colors_Constants.app_white_color,
                    text: "LOGIN"),
                SizedBox(
                  height: heightt * 0.05,
                ),
                Login_SignUp_Button().customButton(context,
                nextScreen: SignUp(),
                    innerColor: Colors_Constants.app_black_color,
                    textColor: Colors_Constants.app_white_color,
                    text: "CREATE ACCOUNT")
              ],
            ),
          )),
    );
  }
}
