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
    var widthh = MediaQuery.of(context).size.width * 1;

    return Scaffold(
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(children: [
                    Center(
                      child: Image(
                          image: AssetImage(
                              "assets/images/Start screen image.png")),
                    ),
                    SizedBox(
                      height: heightt * 0.1,
                    ),
                    Center(
                      child: FittedBox(
                        child: Text(
                          "Get things done with TODO",
                          style: TextStyle(
                              fontFamily:
                                  Fonts_Size_Constants.regular_font_family,
                              fontWeight: FontWeight.bold,
                              color: Colors_Constants.app_black_color,
                              fontSize:
                                  Fonts_Size_Constants.heading_font_size.sp),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: heightt * 0.02,
                    ),
                    Center(
                      child: Text(
                        "Efficiently manage tasks and boost \nproductivity with this intuitive ToDo app.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily:
                                Fonts_Size_Constants.regular_font_family,
                            fontWeight: FontWeight.bold,
                            color: Colors_Constants.app_grey_color,
                            fontSize: Fonts_Size_Constants.text_font_size.sp),
                      ),
                    ),
                    SizedBox(
                      height: heightt * 0.15,
                    ),
                    Login_SignUp_Button().customButton(context,
                        nextScreen: SignUp(),
                        innerColor: Colors_Constants.app_pink_color,
                        textColor: Colors_Constants.app_white_color,
                        text: "Get Started")
                  ]),
                ),
              ],
            ),
          )),
    );
  }
}
