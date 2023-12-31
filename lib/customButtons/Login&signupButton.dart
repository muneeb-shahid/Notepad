import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/LoginController/LoginController.dart';
import '../../controller/SignUpController/SignUpController.dart';


var mediaQueryData = Get.mediaQuery;

double screenHeight = mediaQueryData.size.height * 1;
double screenWidth = mediaQueryData.size.width * 1;
final LoginController _loginController = Get.put(LoginController());
final SignUpController _signUpController = Get.put(SignUpController());

customLogin_SignupButton(
    {required func,
    required innerColor,
    required var textColor,
    required String text}) {
  return GestureDetector(
    onTap: func,
    
    child: Container(
      
      height: screenHeight * 0.07,
      width: screenWidth * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: innerColor,
      ),
      child: Center(
          child: Text(
        text,
        style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: textColor),
      )),
    ),
  );
}
