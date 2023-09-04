import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notepad/controller/LoginController/LoginController.dart';
import 'package:notepad/view/EditPost/EditPost.dart';

import '../../constants/colors_constants/colors_constants.dart';
import '../../constants/fonts_size_constant/fonts_size_constant.dart';
import '../../controller/FolderController/FolderController.dart';
import '../../controller/HomeScreenController/HomeScreenController.dart';
import '../../controller/SearchDelegate/searchDelegate.dart';
import '../Checklist/Checklist.dart';
import '../Folder_InsertNotes.dart/folder_insertNote.dart';
import '../FullPageNote/FullPageNote.dart';
import '../HomeScreen/Home_screen.dart';
import '../Note/Note.dart';

enum _menuValues { Note, Checklist, Folder }

class Folder_Sub_Notes extends StatelessWidget {
  const Folder_Sub_Notes({super.key});

  @override
  Widget build(BuildContext context) {
    FolderController folderController = Get.put(FolderController());
    HomeScreenController homeScreenController = Get.put(HomeScreenController());
    LoginController loginController = Get.put(LoginController());
    var heightt = MediaQuery.of(context).size.height * 1;

    var widthh = MediaQuery.of(context).size.width * 1;

    User? UserId = FirebaseAuth.instance.currentUser;
    final CollectionReference _folder =
        FirebaseFirestore.instance.collection('folder');

    Stream<QuerySnapshot> folder_Stream =
        _folder.where("UserId", isEqualTo: UserId!.uid).snapshots();

    return Scaffold(
        backgroundColor: Colors_Constants.app_background_color,
        appBar: AppBar(
          backgroundColor: Colors_Constants.app_pink_color,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.white,
              )),
          title: Text(
            "${Get.arguments["folderName"]}",
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
              ],
              onSelected: (value) {
                switch (value) {
                  case _menuValues.Note:
                    Get.to(Folder_InsertNote());
                    break;
                  case _menuValues.Checklist:
                    Get.to(Checklist());
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
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                  ),
                ),
              ),
           
              // Expanded(
              //   child: StreamBuilder(
              //     stream: folder_Stream,
              //     builder:
              //         (context, AsyncSnapshot<QuerySnapshot> streamSnapshots) {
              //       if (streamSnapshots.connectionState ==
              //           ConnectionState.waiting) {
              //         return Center(
              //             child: CircularProgressIndicator(color: Colors.red));
              //       } else if (streamSnapshots.hasError) {
              //         return Center(
              //             child: Text(
              //           "Error fetching data",
              //           style: TextStyle(color: Colors.red, fontSize: 30),
              //         ));
              //       } else if (streamSnapshots.data!.docs.isEmpty) {
              //         return Center(
              //             child: Text(
              //           "No data available",
              //           style: TextStyle(color: Colors.red, fontSize: 30),
              //         ));
              //       } else {
              //         return ListView.builder(
              //           itemCount: streamSnapshots.data!.docs.length,
              //           itemBuilder: (context, index) {
              //             final DocumentSnapshot documentSnapshot =
              //                 streamSnapshots.data!.docs[index];
              //             final docId = streamSnapshots.data!.docs[index].id;
              //             String position = documentSnapshot['folderName'];
              //             bool doesNotContain = !position
              //                 .toUpperCase()
              //                 .contains(homeScreenController
              //                     .SearchController.text
              //                     .toString()
              //                     .toUpperCase());

              //             // Debugging: Print document data.
              //             print("Document data: ${documentSnapshot.data()}");
              //             if (homeScreenController
              //                 .SearchController.text.isEmpty) {
              //               if (documentSnapshot.exists) {
              //                 return GestureDetector(
              //                   onTap: () {
              //                     Get.to(() => Folder_Sub_Notes(), arguments: {
              //                       'folderName':
              //                           documentSnapshot['folderName'],
              //                     });
              //                   },
              //                   child: ClipRRect(
              //                     borderRadius: BorderRadius.circular(20),
              //                     child: Card(
              //                       child: ListTile(
              //                           leading: Icon(Icons.folder),
              //                           title: Text(
              //                             documentSnapshot['title'],
              //                             style: TextStyle(
              //                                 fontFamily: Fonts_Size_Constants
              //                                     .heading_font_family,
              //                                 fontWeight: FontWeight.bold,
              //                                 color: Colors_Constants
              //                                     .app_black_color,
              //                                 fontSize: Fonts_Size_Constants
              //                                     .sub_heading_font_size.sp),
              //                           ),
              //                           trailing: SizedBox(
              //                               width: widthh * 0.3.sp,
              //                               child: Row(children: [
              //                                 IconButton(
              //                                     icon: const Icon(Icons.edit),
              //                                     onPressed: () async {
              //                                       folderController
              //                                           .updateFolderName(
              //                                               documentSnapshot
              //                                                   .id);
              //                                     }),
              //                                 IconButton(
              //                                     icon:
              //                                         const Icon(Icons.delete),
              //                                     onPressed: () {
              //                                       folderController.delete(
              //                                           documentSnapshot.id);
              //                                     }),
              //                               ]))),
              //                     ),
              //                   ),
              //                 );
              //               } else {
              //                 return Container(); // Handle non-existing document.
              //               }
              //             } else if (position.toUpperCase().contains(
              //                 homeScreenController.SearchController.text
              //                     .toString())) {
              //               if (documentSnapshot.exists) {
              //                 return ClipRRect(
              //                   borderRadius: BorderRadius.circular(20),
              //                   child: Card(
              //                     child: ListTile(
              //                         leading: Icon(Icons.folder),
              //                         title: Text(
              //                           documentSnapshot['folderName']
              //                               .toUpperCase(),
              //                           style: TextStyle(
              //                               fontFamily: Fonts_Size_Constants
              //                                   .heading_font_family,
              //                               fontWeight: FontWeight.bold,
              //                               color:
              //                                   Colors_Constants.app_blue_color,
              //                               fontSize: Fonts_Size_Constants
              //                                   .sub_heading_font_size.sp),
              //                         ),
              //                         trailing: SizedBox(
              //                             width: widthh * 0.3.sp,
              //                             child: Row(children: [
              //                               IconButton(
              //                                   icon: const Icon(Icons.edit),
              //                                   onPressed: () async {
              //                                     folderController
              //                                         .updateFolderName(
              //                                             documentSnapshot.id);
              //                                   }),
              //                               IconButton(
              //                                   icon: const Icon(Icons.delete),
              //                                   onPressed: () {
              //                                     folderController.delete(
              //                                         documentSnapshot.id);
              //                                   }),
              //                             ]))),
              //                   ),
              //                 );
              //               } else {
              //                 return Container(); // Handle non-existing document.
              //               }
              //             } else if (doesNotContain) {
              //               return Center(
              //                 child: Text(
              //                   "Not found",
              //                   style: TextStyle(
              //                       color: Colors.red,
              //                       fontSize: Fonts_Size_Constants
              //                           .heading_font_size.sp),
              //                 ),
              //               );
              //             }
              //           },
              //         );
              //       }
              //     },
              //   ),
              // ),
           
            ],
          ),
        ));
  }
}
