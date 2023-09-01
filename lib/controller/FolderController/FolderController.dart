import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notepad/controller/SignUpController/SignUpController.dart';

import '../../constants/colors_constants/colors_constants.dart';
import '../../constants/fonts_size_constant/fonts_size_constant.dart';
import '../../view/Folder/Folder.dart';
import '../HomeScreenController/HomeScreenController.dart';

class FolderController extends GetxController {
  SignUpController signUpController = Get.put(SignUpController());
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  User? UserId = FirebaseAuth.instance.currentUser;

  final CollectionReference _folder =
      FirebaseFirestore.instance.collection('folder');

  Future<void> delete(String productId) async {
    await _folder.doc(productId).delete();

    Get.snackbar(
      'successfully deleted', //Snackbar title
      'You have successfully deleted a Note', // Snackbar message
      icon: const Icon(Icons.delete, color: Colors.black),
      backgroundColor: Colors_Constants.app_white_color,
      colorText: Colors.black,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(
          seconds: 3), // Duration for which the Snackbar is shown
    );
  }

  void showCustomDialog(context) {
    Get.defaultDialog(
      title: "Update folder Name!",
      content: Column(
        children: [
          Form(
            key: homeScreenController.formKey,
            child: TextFormField(
              controller: homeScreenController.FolderTextEditingController
                ..text = "${Get.arguments['folderName']}",
              keyboardType: TextInputType.name,
              focusNode: signUpController.focusNode1,
              onFieldSubmitted: (value) {
                FocusScope.of(context)
                    .requestFocus(signUpController.focusNode2);
              },
              style: TextStyle(color: Colors_Constants.app_black_color),
              validator: homeScreenController.validateFolderName,
              decoration: InputDecoration(
                hintText: 'Folder name',
              ),
            ),
          )
        ],
      ),
      titleStyle: TextStyle(
          color: Colors.black,
          fontSize: Fonts_Size_Constants.sub_heading_font_size.sp),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            "Close",
            style: TextStyle(
                color: Colors.red,
                fontSize: Fonts_Size_Constants.sub_heading_font_size.sp),
          ),
        ),
        TextButton(
          onPressed: () async {
            if (homeScreenController.formKey.currentState!.validate()) {
              homeScreenController.formKey.currentState!.save();

              final String folderName =
                  homeScreenController.FolderTextEditingController.text;
              if (folderName != null) {
                updateFolderName();
                // Get.to(() => Folder(), arguments: {
                //   'folderName':
                //       homeScreenController.FolderTextEditingController.text,
                // });
                homeScreenController.FolderTextEditingController.text = '';

                // homeScreenController.FolderTextEditingController.clear();
              }
            }

            // Get.back();
          },
          child: Text(
            "update",
            style: TextStyle(
                color: Colors.black,
                fontSize: Fonts_Size_Constants.heading_font_size.sp),
          ),
        ),
      ],
    );
  }

  updateFolderName() async {
    await FirebaseFirestore.instance
        .collection('folderName')
        .doc(Get.arguments["folderName"].toString())
        .update(
      {
        'folderName': homeScreenController.FolderTextEditingController.text,
      },
    ).then((value) {
      Get.back();
      Get.snackbar(
        'Update Successfully ', //Snackbar title
        'You successfully updated a Note', // Snackbar message
        icon: const Icon(Icons.update_rounded, color: Colors.black),
        backgroundColor: Colors_Constants.app_white_color,
        colorText: Colors.black,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(
            seconds: 3), // Duration for which the Snackbar is shown
      );
    });
  }
}
