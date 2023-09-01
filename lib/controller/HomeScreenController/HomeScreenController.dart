import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:notepad/constants/fonts_size_constant/fonts_size_constant.dart';
import 'package:notepad/controller/SignUpController/SignUpController.dart';
import 'package:notepad/view/Folder/Folder.dart';
import 'package:notepad/view/login/login.dart';

import '../../constants/colors_constants/colors_constants.dart';

class HomeScreenController extends GetxController {
  final CollectionReference _folder =
      FirebaseFirestore.instance.collection('folder');
  String UserId = FirebaseAuth.instance.currentUser!.uid;
  SignUpController signUpController = Get.put(SignUpController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  get formKey => _formKey;

  TextEditingController _searchController = TextEditingController();
  RxString search = ''.obs;

  get SearchController => _searchController;
  final TextEditingController _folderTextEditingController =
      TextEditingController();
  get FolderTextEditingController => _folderTextEditingController;

  TextEditingController _titleController = TextEditingController();

  get TitleController => _titleController;

  TextEditingController _contentController = TextEditingController();
  get ContentController => _contentController;
  CollectionReference _notes = FirebaseFirestore.instance.collection('notes');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Get.offAll(() => Login());
      print("User signed out successfully");
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  Future<void> delete(String productId) async {
    await _notes.doc(productId).delete();

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
      title: "Make folder!",
      content: Column(
        children: [
          Form(
            key: formKey,
            child: TextFormField(
              controller: FolderTextEditingController,
              keyboardType: TextInputType.name,
              focusNode: signUpController.focusNode1,
              onFieldSubmitted: (value) {
                FocusScope.of(context)
                    .requestFocus(signUpController.focusNode2);
              },
              style: TextStyle(color: Colors_Constants.app_black_color),
              validator: validateFolderName,
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
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();

              final String folderName = _folderTextEditingController.text;
              if (folderName != null) {
                await _folder.add({"folderName": folderName, "UserId": UserId});
                Get.to(() => Folder(), arguments: {
                  'folderName': FolderTextEditingController.text,
                });
                FolderTextEditingController.text = '';

                FolderTextEditingController.clear();
              }
            }

            // Get.back();
          },
          child: Text(
            "save",
            style: TextStyle(
                color: Colors.black,
                fontSize: Fonts_Size_Constants.heading_font_size.sp),
          ),
        ),
      ],
    );
  }

  String? validateFolderName(String? input) {
    if (input == null || input.isEmpty) {
      return 'Folder name is required.';
    }

    return null;
  }

  @override
  void dispose() {
    _folderTextEditingController.dispose();

    super.dispose();
  }
}
