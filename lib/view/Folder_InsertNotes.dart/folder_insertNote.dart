import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notepad/controller/Folder_InsertNoteController/Folder_InsertNoteController.dart';

import '../../constants/colors_constants/colors_constants.dart';
import '../../constants/fonts_size_constant/fonts_size_constant.dart';

class Folder_InsertNote extends StatelessWidget {
  const Folder_InsertNote({super.key});

  @override
  Widget build(BuildContext context) {
    Folder_InsertNoteController folder_insertNoteController =
        Get.put(Folder_InsertNoteController());

    return Scaffold(
        backgroundColor: Colors_Constants.app_background_color,
        appBar: AppBar(
          backgroundColor: Colors_Constants.app_pink_color,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors_Constants.app_pink_color,
          onPressed: () async {
            folder_insertNoteController.insertData();
          },
          child: Icon(Icons.save),
        ),
        body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                      key: folder_insertNoteController.formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            style: TextStyle(
                                fontFamily:
                                    Fonts_Size_Constants.heading_font_family,
                                fontWeight: FontWeight.bold,
                                color: Colors_Constants.app_black_color,
                                fontSize:
                                    Fonts_Size_Constants.heading_font_size.sp),
                            controller: folder_insertNoteController.TitleController,
                            decoration: const InputDecoration(
                              hintText: 'Title',
                            ),
                            validator: folder_insertNoteController.validateTitle,
                            focusNode: folder_insertNoteController.focusNode1,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(folder_insertNoteController.focusNode2);
                            },
                          ),
                          TextFormField(
                            maxLines: 50,
                            controller: folder_insertNoteController.ContentController,
                            decoration: const InputDecoration(
                              hintText: 'Content',
                            ),
                            style: TextStyle(
                              fontFamily:
                                  Fonts_Size_Constants.regular_font_family,
                              color: Colors_Constants.app_black_color,
                            ),
                            focusNode: folder_insertNoteController.focusNode2,
                          ),
                        ],
                      )),
                ],
              ),
            )));
  }
}
