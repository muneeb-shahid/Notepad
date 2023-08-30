import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/colors_constants/colors_constants.dart';
import '../../constants/fonts_size_constant/fonts_size_constant.dart';
import '../../controller/NoteController/NoteController.dart';

class EditPost extends StatelessWidget {
  final dynamic editNote;
  EditPost({super.key, required this.editNote});

  @override
  Widget build(BuildContext context) {
    NoteController noteController = Get.put(NoteController());
    CollectionReference _notes = FirebaseFirestore.instance.collection('notes');

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors_Constants.app_pink_color,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors_Constants.app_pink_color,
          onPressed: ([DocumentSnapshot? documentSnapshot]) async {
          

              final String title = noteController.TitleController.text;
              final String content = noteController.ContentController.text;
              if (documentSnapshot != null) {
                noteController.TitleController.text = documentSnapshot['title'];
                noteController.ContentController.text =
                    documentSnapshot['content'];
                await _notes
                    .doc(documentSnapshot!.id)
                    .update({"title": title, "content": content});

                noteController.TitleController.text = '';
                noteController.ContentController.text = '';
                // Get.back();
              
            }
          },
          child: Icon(Icons.save),
        ),
        body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    editNote["title"].toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        wordSpacing: 2,
                        color: Colors.red,
                        fontFamily: Fonts_Size_Constants.heading_font_family,
                        fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    editNote["content"].toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        wordSpacing: 2,
                        color: Colors.black,
                        fontFamily: Fonts_Size_Constants.heading_font_family,
                        fontSize: 16.sp),
                  ),
                ],
              ),
            )));
  }
}
