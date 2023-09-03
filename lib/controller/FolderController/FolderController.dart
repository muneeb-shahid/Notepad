import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notepad/controller/SignUpController/SignUpController.dart';

import '../../constants/colors_constants/colors_constants.dart';
import '../../constants/fonts_size_constant/fonts_size_constant.dart';
import '../HomeScreenController/HomeScreenController.dart';

class FolderController extends GetxController {
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  SignUpController signUpController = Get.put(SignUpController());



  final CollectionReference _folder =
      FirebaseFirestore.instance.collection('folder');

  Future<void> delete(String productId) async {
    await _folder.doc(productId).delete();

    Get.snackbar(
      'successfully deleted', //Snackbar title
      'You have successfully deleted a folder', // Snackbar message
      icon: const Icon(Icons.delete, color: Colors.black),
      backgroundColor: Colors_Constants.app_white_color,
      colorText: Colors.black,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(
          seconds: 3), // Duration for which the Snackbar is shown
    );
  }

  updateFolderName(String productId) async {
    Get.defaultDialog(
      title: "Update folder name",
      content: Column(
        children: [
          Form(
            key: homeScreenController.formKey,
            child: TextFormField(
              controller: homeScreenController.FolderTextEditingController,
              keyboardType: TextInputType.name,
              style: TextStyle(color: Colors_Constants.app_black_color),
              validator: homeScreenController.validateFolderName,
              decoration: InputDecoration(
                hintText: 'Enter your folder name',
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
            homeScreenController.FolderTextEditingController.clear();
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
            await _folder.doc(productId).update(
              {
                'folderName':
                    homeScreenController.FolderTextEditingController.text,
              },
            ).then((value) {
              homeScreenController.FolderTextEditingController.clear();
              Get.back();
              Get.snackbar(
                'Update Successfully ', //Snackbar title
                'You successfully updated a folder', // Snackbar message
                icon: const Icon(Icons.update_rounded, color: Colors.black),
                backgroundColor: Colors_Constants.app_white_color,
                colorText: Colors.black,
                snackPosition: SnackPosition.TOP,
                duration: const Duration(
                    seconds: 3), // Duration for which the Snackbar is shown
              );
            });
          },
          child: Text(
            "Update",
            style: TextStyle(
                color: Colors.black,
                fontSize: Fonts_Size_Constants.heading_font_size.sp),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
