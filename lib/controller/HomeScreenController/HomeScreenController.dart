import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../constants/colors_constants/colors_constants.dart';

class HomeScreenController extends GetxController {
  TextEditingController _titleController = TextEditingController();
  get TitleController => _titleController;

  TextEditingController _contentController = TextEditingController();
  get ContentController => _contentController;
  CollectionReference _notes = FirebaseFirestore.instance.collection('notes');

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

   
 
}
