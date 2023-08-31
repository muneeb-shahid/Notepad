import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notepad/controller/EditPostController/EditPostController.dart';

import '../../constants/colors_constants/colors_constants.dart';
import '../../constants/fonts_size_constant/fonts_size_constant.dart';
import '../../controller/NoteController/NoteController.dart';

class EditPost extends StatelessWidget {
  EditPost({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    NoteController noteController = Get.put(NoteController());
    EditPostController editPostController = Get.put(EditPostController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors_Constants.app_pink_color,
          // title: Text(Get.arguments["docId"].toString()),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors_Constants.app_pink_color,
          onPressed: () async {
            editPostController.updateNotes();
          },
          child: Icon(Icons.save),
        ),
        body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Column(
                      children: [
                        TextFormField(
                          style: TextStyle(
                              fontFamily:
                                  Fonts_Size_Constants.heading_font_family,
                              fontWeight: FontWeight.bold,
                              color: Colors_Constants.app_black_color,
                              fontSize:
                                  Fonts_Size_Constants.heading_font_size.sp),
                          controller: noteController.TitleController
                            ..text = "${Get.arguments["title"].toString()}",
                          decoration: const InputDecoration(
                            hintText: 'Title',
                          ),
                          validator: noteController.validateTitle,
                          focusNode: noteController.focusNode1,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(noteController.focusNode2);
                          },
                        ),
                        TextFormField(
                          maxLines: 50,
                          controller: noteController.ContentController
                            ..text = "${Get.arguments["content"].toString()}",
                          decoration: const InputDecoration(
                            hintText: 'Content',
                          ),
                          style: TextStyle(
                            fontFamily:
                                Fonts_Size_Constants.regular_font_family,
                            color: Colors_Constants.app_black_color,
                          ),
                          validator: noteController.validateContent,
                          focusNode: noteController.focusNode2,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )));
  }
}
