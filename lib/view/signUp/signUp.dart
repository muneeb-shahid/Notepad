import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors_constants/colors_constants.dart';
import '../../constants/fonts_size_constant/fonts_size_constant.dart';
import '../../customButtons/login_signup_button.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    var heightt = MediaQuery.of(context).size.height * 1;
    var widthh = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      backgroundColor: Colors_Constants.app_background_color,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    color: Colors_Constants.app_background_color,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Positioned(
                      child:
                          Image(image: AssetImage("assets/images/shape.png"))),
                  Positioned(
                      top: heightt * 0.2,
                      left: widthh * 0.1,
                      right: widthh * 0.1,
                      child: Center(
                        child: Text(
                          "Welcome onboard!",
                          style: TextStyle(
                              fontFamily:
                                  Fonts_Size_Constants.regular_font_family,
                              fontWeight: FontWeight.bold,
                              color: Colors_Constants.app_black_color,
                              fontSize:
                                  Fonts_Size_Constants.heading_font_size.sp),
                        ),
                      )),
                  Positioned(
                      top: heightt * 0.25,
                      left: widthh * 0.1,
                      right: widthh * 0.1,
                      child: Center(
                        child: Text(
                          "Let’s help you meet your tasks",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily:
                                  Fonts_Size_Constants.regular_font_family,
                              fontWeight: FontWeight.bold,
                              color: Colors_Constants.app_grey_color,
                              fontSize: Fonts_Size_Constants.text_font_size.sp),
                        ),
                      )),
                  Positioned(
                      top: heightt * 0.35,
                      left: widthh * 0.1,
                      right: widthh * 0.1,
                      child: Form(
                          child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.name,
                            style: TextStyle(
                                color: Colors_Constants.app_black_color),
                            // validator: validateEmail,
                            // onChanged: (value) {
                            //   _email = value;
                            // },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors_Constants.app_white_color,
                              hintText: 'Enter your full name',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.white,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.white)),
                              prefixIcon:
                                  Icon(Icons.person_2, color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: heightt * 0.05,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            style: TextStyle(
                                color: Colors_Constants.app_black_color),
                            // validator: validateEmail,
                            // onChanged: (value) {
                            //   _email = value;
                            // },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors_Constants.app_white_color,
                              hintText: 'Enter your email',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.white,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.white)),
                              prefixIcon:
                                  Icon(Icons.person_2, color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: heightt * 0.05,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            style: TextStyle(
                                color: Colors_Constants.app_black_color),
                            // validator: validateEmail,
                            // onChanged: (value) {
                            //   _email = value;
                            // },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors_Constants.app_white_color,
                              hintText: 'Enter your password',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.white,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.white)),
                              prefixIcon:
                                  Icon(Icons.person_2, color: Colors.black),
                            ),
                          ),
                        ],
                      ))),
                  Positioned(
                      bottom: heightt * 0.16,
                      left: widthh * 0.1,
                      right: widthh * 0.1,
                      child: Login_SignUp_Button().customButton(context,
                          nextScreen: SignUp(),
                          innerColor: Colors_Constants.app_pink_color,
                          textColor: Colors_Constants.app_white_color,
                          text: "Register")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
