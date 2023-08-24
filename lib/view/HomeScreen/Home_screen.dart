import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/colors_constants/colors_constants.dart';
import '../../constants/fonts_size_constant/fonts_size_constant.dart';


 

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
        title: ListTile(
          title: Text(
            "Notes",
            style: TextStyle(
                fontFamily: Fonts_Size_Constants.Philosopher,
                fontWeight: FontWeight.bold,
                fontSize: Fonts_Size_Constants.heading_font_size.sp),
          ),
          trailing: SizedBox(
              width: widthh * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {}),
                  IconButton(
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () {}),
                  PopupMenuButton<_menuValues>(
                      itemBuilder: (context) => [
                            PopupMenuItem(child: Text("Note"),value:_menuValues.Note ,),
                            PopupMenuItem(child: Text("Checklist"),value:_menuValues.Checklist ,),
                            PopupMenuItem(child: Text("Folder"),value:_menuValues.Folder ,),
                          ])
                ],
              )),
        ),
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
