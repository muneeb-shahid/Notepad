import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notepad/view/Note/Note.dart';

import '../../constants/colors_constants/colors_constants.dart';
import '../../constants/fonts_size_constant/fonts_size_constant.dart';
import '../Checklist/Checklist.dart';
import '../Folder/Folder.dart';

enum _menuValues { Note, Checklist, Folder }

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var heightt = MediaQuery.of(context).size.height * 1;
    var widthh = MediaQuery.of(context).size.width * 1;

    final user = FirebaseAuth.instance.currentUser;

    void showCustomDialog() {
      Get.defaultDialog(
        title: "Dialog Title",
        middleText: "This is the dialog's content.",
        actions: [
          ElevatedButton(
            onPressed: () {
              // Close the dialog
              Get.back();
            },
            child: Text("Close"),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors_Constants.app_background_color,
      appBar: AppBar(
        backgroundColor: Colors_Constants.app_pink_color,
        title: Text(
          "Notes",
          style: TextStyle(
              fontFamily: Fonts_Size_Constants.Philosopher,
              fontWeight: FontWeight.bold,
              fontSize: Fonts_Size_Constants.heading_font_size.sp),
        ),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
          PopupMenuButton<_menuValues>(
            offset: Offset(0, heightt * 0.08),
            shape: RoundedRectangleBorder(
              side:
                  BorderSide(width: 1, color: Colors_Constants.app_black_color),
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.white,
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.note_add,
                      color: Colors.black,
                    ),
                    Text(
                      "Note",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: Fonts_Size_Constants.regular_font_family,
                          fontSize:
                              Fonts_Size_Constants.sub_heading_font_size.sp),
                    ),
                  ],
                ),
                value: _menuValues.Note,
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.checklist,
                      color: Colors.black,
                    ),
                    Text(
                      "Checklist",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: Fonts_Size_Constants.regular_font_family,
                          fontSize:
                              Fonts_Size_Constants.sub_heading_font_size.sp),
                    ),
                  ],
                ),
                value: _menuValues.Checklist,
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.folder,
                      color: Colors.black,
                    ),
                    Text(
                      "Folder",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: Fonts_Size_Constants.regular_font_family,
                          fontSize:
                              Fonts_Size_Constants.sub_heading_font_size.sp),
                    ),
                  ],
                ),
                value: _menuValues.Folder,
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case _menuValues.Note:
                  Get.to(Note());
                  break;
                case _menuValues.Checklist:
                  Get.to(Checklist());
                  break;
                case _menuValues.Folder:
                  Get.to(Folder());
                  break;
                default:
              }
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ElevatedButton(
          onPressed: () {
            // Call the showCustomDialog function to show the dialog
            showCustomDialog();
          },
          child: Text("Show Dialog"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
