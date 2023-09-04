import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notepad/constants/colors_constants/colors_constants.dart';
import 'package:notepad/constants/fonts_size_constant/fonts_size_constant.dart';
import 'package:notepad/controller/HomeScreenController/HomeScreenController.dart';
import 'package:notepad/controller/NoteController/NoteController.dart';

import '../../controller/FullPageNoteController/FullPageNoteController.dart';

class FullPageNote extends StatelessWidget {
  const FullPageNote({super.key});

  @override
  Widget build(BuildContext context) {
    NoteController noteController = Get.put(NoteController());
    FullPageNoteController fullPageNoteController =

        Get.put(FullPageNoteController());
    HomeScreenController homeScreenController = Get.put(HomeScreenController());

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
                  Icons.logout_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  homeScreenController.signOut();
                }),]
        ),
        body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fullPageNoteController.TitleController.text =
                              "${Get.arguments["title"].toString()}",
                          style: TextStyle(
                              fontFamily:
                                  Fonts_Size_Constants.heading_font_family,
                              fontWeight: FontWeight.bold,
                              color: Colors_Constants.app_black_color,
                              fontSize:
                                  Fonts_Size_Constants.heading_font_size.sp),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.grey,
                        ),
                        Text(
                          fullPageNoteController.TitleController.text =
                              "${Get.arguments["content"].toString()}",
                          style: TextStyle(
                              fontFamily:
                                  Fonts_Size_Constants.regular_font_family,
                              color: Colors_Constants.app_black_color,
                              fontSize: Fonts_Size_Constants
                                  .sub_heading_font_size.sp),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )));
  }
}
