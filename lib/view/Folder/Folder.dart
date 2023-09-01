import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notepad/controller/HomeScreenController/HomeScreenController.dart';
import 'package:notepad/view/HomeScreen/Home_screen.dart';
import 'package:notepad/view/Note/Note.dart';

import '../../constants/colors_constants/colors_constants.dart';
import '../../constants/fonts_size_constant/fonts_size_constant.dart';
import '../../controller/FolderController/FolderController.dart';
import '../../controller/LoginController/LoginController.dart';
import '../../controller/SearchDelegate/searchDelegate.dart';
import '../Checklist/Checklist.dart';

enum _menuValues { Note, Checklist, Folder }

class Folder extends StatelessWidget {
  const Folder({super.key});

  @override
  Widget build(BuildContext context) {
    FolderController folderController = Get.put(FolderController());
    HomeScreenController homeScreenController = Get.put(HomeScreenController());
    User? UserId = FirebaseAuth.instance.currentUser;
    LoginController loginController = Get.put(LoginController());

    var heightt = MediaQuery.of(context).size.height * 1;

    final CollectionReference _folder =
        FirebaseFirestore.instance.collection('folder');

    Stream<QuerySnapshot> folderStream =
        _folder.where("UserId", isEqualTo: UserId!.uid).snapshots();

    return Scaffold(
        backgroundColor: Colors_Constants.app_background_color,
        appBar: AppBar(
          backgroundColor: Colors_Constants.app_pink_color,
          leading: IconButton(
              onPressed: () {
                Get.offAll(() => HomePage());
              },
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.white,
              )),
          title: Text(
            "${Get.arguments['folderName']}",
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
                }),
            IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  showSearch(context: context, delegate: Search());
                  // homeScreenController.showCustomTextFormField();
                  // TextFormField();
                }),
            PopupMenuButton<_menuValues>(
              offset: Offset(0, heightt * 0.08),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1, color: Colors_Constants.app_black_color),
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.white,
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: _menuValues.Note,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
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
                    Get.to(() => Folder());
                    // homeScreenController.showCustomDialog(context);
                    break;
                  default:
                }
              },
            ),
          ],
        ),
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: TextFormField(
                  controller: homeScreenController.SearchController,
                  focusNode: loginController.focusNode1,
                  onChanged: (val) {
                    homeScreenController.search.value = val.toString();
                  },
                  onFieldSubmitted: (value) {
                    FocusScope.of(context)
                        .requestFocus(loginController.focusNode2);
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors_Constants.app_black_color),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    suffixIcon: IconButton(
                      onPressed: () {
                        homeScreenController.SearchController.text != null
                            ? homeScreenController.SearchController.clear()
                            : null;
                      },
                      icon: Icon(
                        Icons.clear,
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 2, color: Colors.white)),
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                  ),
                ),
              ),
              Expanded(
                  child: StreamBuilder(
                stream: folderStream,
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshots) {
                  if (streamSnapshots.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(color: Colors.red));
                  }
                  if (streamSnapshots.hasError) {
                    return Center(
                      child: Text(
                        "Error fetching data: ${streamSnapshots.error.toString()}",
                        style: TextStyle(color: Colors.red, fontSize: 30),
                      ),
                    );
                  }
                  if (!streamSnapshots.hasData ||
                      streamSnapshots.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        "No data available",
                        style: TextStyle(color: Colors.red, fontSize: 30),
                      ),
                    );
                  }

                  // Debugging: Print the number of documents retrieved.
                  print(
                      "Number of documents: ${streamSnapshots.data!.docs.length}");

                  return ListView.builder(
                    itemCount: streamSnapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshots.data!.docs[index];

                      final docId = streamSnapshots.data!.docs[index].id;

                      // Debugging: Print document data.
                      print("Document data: ${documentSnapshot.data()}");

                      if (documentSnapshot.exists) {
                        // Adjust this part based on your document structure.
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Card(
                            child: ListTile(
                                title: Text(
                                  "${documentSnapshot['folderName']}",
                                  style: TextStyle(
                                      fontFamily: Fonts_Size_Constants
                                          .heading_font_family,
                                      fontWeight: FontWeight.bold,
                                      color: Colors_Constants.app_black_color,
                                      fontSize: Fonts_Size_Constants
                                          .heading_font_size.sp),
                                ),
                                trailing: SizedBox(
                                    width: 100,
                                    child: Row(children: [
                                      IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () async {
                                            folderController
                                                .showCustomDialog(context);
                                            // Get.to(EditPost(), arguments: {
                                            //   'folderName':
                                            //       documentSnapshot['folderName'],

                                            //   "docId": docId
                                            // });
                                          }),
                                      IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {
                                            folderController
                                                .delete(documentSnapshot.id);
                                          }),
                                    ]))),
                          ),
                        );
                      } else {
                        return Container(); // Handle non-existing document.
                      }
                    },
                  );
                },
              )),
            ],
          ),
        ));
  }
}
