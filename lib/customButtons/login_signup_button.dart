import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notepad/constants/colors_constants/colors_constants.dart';

import '../constants/fonts_size_constant/fonts_size_constant.dart';

class Login_SignUp_Button {
  customButton(BuildContext context,
      {var nextScreen,
      required var innerColor,
      required var textColor,
      required String text}) {
    var heightt = MediaQuery.of(context).size.height * 1;
    var widthh = MediaQuery.of(context).size.width * 1;

    return Column(children: <Widget>[
      MaterialButton(
        minWidth: widthh * 0.8,
        height: heightt * 0.07,
        onPressed: () {
          Get.off(nextScreen);
        },
        color: innerColor,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors_Constants.app_blue_color, width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: FittedBox(
          child: Text(
            text,
            style: TextStyle(
                color: textColor,
                fontSize: Fonts_Size_Constants.sub_heading_font_size.sp,
                fontFamily: Fonts_Size_Constants.heading_font_family,
                wordSpacing: 1,
                letterSpacing: 1),
          ),
        ),
      ),
    ]);
  }
}
