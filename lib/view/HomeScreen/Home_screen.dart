import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notepad/controller/HomeScreenController/HomeScreenController.dart';
import 'package:notepad/controller/NoteController/NoteController.dart';
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
    NoteController noteController = Get.put(NoteController());
    HomeScreenController homeScreenController = Get.put(HomeScreenController());

    var heightt = MediaQuery.of(context).size.height * 1;
    var widthh = MediaQuery.of(context).size.width * 1;
    CollectionReference _notes = FirebaseFirestore.instance.collection('notes');

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
                side: BorderSide(
                    width: 1, color: Colors_Constants.app_black_color),
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
                            fontFamily:
                                Fonts_Size_Constants.regular_font_family,
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
                            fontFamily:
                                Fonts_Size_Constants.regular_font_family,
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
                            fontFamily:
                                Fonts_Size_Constants.regular_font_family,
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
        body: SafeArea(
          top: true,
          child: StreamBuilder(
            stream: _notes.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshots) {
              if (streamSnapshots.hasData) {
                return ListView.builder(
                  itemCount: streamSnapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshots.data!.docs[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Card(
                        color: Colors.red,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(2, 5, 2, 5),
                          child: ListTile(
                              title: Text(
                                documentSnapshot['title'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontFamily: Fonts_Size_Constants
                                        .heading_font_family,
                                    fontWeight: FontWeight.bold,
                                    color: Colors_Constants.app_black_color,
                                    fontSize: Fonts_Size_Constants
                                        .heading_font_size.sp),
                              ),
                              subtitle: Text(
                                documentSnapshot['content'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                  fontFamily:
                                      Fonts_Size_Constants.regular_font_family,
                                  color: Colors_Constants.app_black_color,
                                ),
                              ),
                              trailing: SizedBox(
                                  width: 100,
                                  child: Row(children: [
                                    // IconButton(
                                    //     icon: const Icon(Icons.edit),
                                    //     onPressed: () => homeScreenController
                                    //         .updateNote(documentSnapshot)),
                                    IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          homeScreenController
                                              .delete(documentSnapshot.id);
                                        }),
                                  ]))),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    ),
                  ],
                );
              }
            },
          ),
        ));
  }
}
