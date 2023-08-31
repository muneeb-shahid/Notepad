import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad/controller/NoteController/NoteController.dart';

import '../../constants/colors_constants/colors_constants.dart';

class EditPostController extends GetxController {
  NoteController noteController = Get.put(NoteController());

  updateNotes() async {
    await FirebaseFirestore.instance
        .collection('notes')
        .doc(Get.arguments["docId"].toString())
        .update(
      {
        'title': noteController.TitleController.text,
        'content': noteController.ContentController.text,
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
