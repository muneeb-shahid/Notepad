import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:notepad/controller/LoginController/LoginController.dart';
import 'package:notepad/controller/SignUpController/SignUpController.dart';
import 'package:notepad/customButtons/Login&signupButton.dart';
import 'package:notepad/functions/Email&PasswordValidation/Email_Password_Validation.dart';

import '../../constants/colors_constants/colors_constants.dart';
import '../../constants/fonts_size_constant/fonts_size_constant.dart';
import '../../images/images.dart';
import '../forgetpassword/forgetpassword.dart';
import '../signUp/signUp.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    EmailPasswordValidation emailPasswordValidation =
        Get.put(EmailPasswordValidation());
    SignUpController signUpController = Get.put(SignUpController());

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
              Column(children: [
                Center(
                  child: Text(
                    "Welcome Back!",
                    style: TextStyle(
                        fontFamily: Fonts_Size_Constants.regular_font_family,
                        fontWeight: FontWeight.bold,
                        color: Colors_Constants.app_black_color,
                        fontSize: Fonts_Size_Constants.heading_font_size.sp),
                  ),
                ),
                SizedBox(
                  height: heightt * 0.02,
                ),
                Center(
                  child: Text(
                    "Let’s help you meet your tasks",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: Fonts_Size_Constants.regular_font_family,
                        fontWeight: FontWeight.bold,
                        color: Colors_Constants.app_grey_color,
                        fontSize: Fonts_Size_Constants.text_font_size.sp),
                  ),
                ),
                SizedBox(
                  height: heightt * 0.05,
                ),
                Image(
                    height: heightt * 0.18,
                    image: AssetImage(
                      App_Images.login_screen_image,
                    )),
                SizedBox(
                  height: heightt * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: 

                  Obx(
                    () => Form(
                        key: loginController.formKey,
                        child: Column(
                          children: [
                            // Email TextFormField
                            TextFormField(
                              controller: loginController.login_emailAddress,
                              focusNode: loginController.focusNode1,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(loginController.focusNode2);
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                  color: Colors_Constants.app_black_color),
                              validator: emailPasswordValidation.validateEmail,
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
                                    Icon(Icons.email, color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: heightt * 0.03,
                            ),

                            // Password TextFormField
                            TextFormField(
                              obscureText: signUpController.isObscured.value,
                              controller: loginController.login_password,
                              focusNode: loginController.focusNode2,
                              style: TextStyle(
                                  color: Colors_Constants.app_black_color),
                              validator:
                                  emailPasswordValidation.validatePassword,
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
                                    Icon(Icons.password, color: Colors.black),
                                suffixIconColor:
                                    Colors_Constants.app_black_color,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    signUpController
                                        .toggleObscure(); // Call the _toggleObscure method
                                  },
                                  child: Icon(
                                    signUpController.isObscured.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
              
                ),
                SizedBox(
                  height: heightt * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: InkWell(
                        onTap: () {
                          Get.to(ForgetPassword());
                        },
                        child: Text(
                          "Forget password",
                          style: TextStyle(
                              fontFamily:
                                  Fonts_Size_Constants.regular_font_family,
                              fontWeight: FontWeight.bold,
                              color: Colors_Constants.app_grey_color,
                              fontSize: Fonts_Size_Constants.text_font_size.sp),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: heightt * 0.01,
                ),
                SizedBox(
                  height: heightt * 0.03,
                ),
                customLogin_SignupButton(
                    func: () => loginController.login(),
                    innerColor: Colors_Constants.app_pink_color,
                    textColor: Colors_Constants.app_white_color,
                    text: "Login")
              ]),
              SizedBox(
                height: heightt * 0.02,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text(
                        "Don’t have an account ?",
                        style: TextStyle(
                          color: Colors_Constants.app_black_color,
                          fontSize: Fonts_Size_Constants.text_font_size.sp,
                          fontFamily: Fonts_Size_Constants.regular_font_family,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.offAll(() => SignUp());
                      },
                      child: FittedBox(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors_Constants.app_black_color,
                            fontSize: Fonts_Size_Constants.text_font_size.sp,
                            fontFamily:
                                Fonts_Size_Constants.regular_font_family,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
