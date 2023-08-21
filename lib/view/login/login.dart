import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/colors_constants/colors_constants.dart';
import '../../constants/fonts_size_constant/fonts_size_constant.dart';
import '../signUp/signUp.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
                  SizedBox(
                    height: heightt * 0.05,
                  ),
                  Text(
                    "Login",
                    style: TextStyle(
                        color: Colors_Constants.app_white_color,
                        fontWeight: FontWeight.bold,
                        fontSize: Fonts_Size_Constants.heading_font_size.sp,
                        fontFamily: Fonts_Size_Constants.regular_font_family),
                  ),
                  SizedBox(
                    height: heightt * 0.1,
                  ),
                  Text(
                    "Email",
                    style: TextStyle(
                        color: Colors_Constants.app_white_color,
                        fontWeight: FontWeight.bold,
                        fontSize: Fonts_Size_Constants.text_font_size.sp,
                        fontFamily: Fonts_Size_Constants.regular_font_family),
                  ),
                  SizedBox(
                    height: heightt * 0.01,
                  ),
                  Row(
                    children: [
                      TextFormField(),
                    ],
                  )
                ],
              ),
              
            )));
  }
}
