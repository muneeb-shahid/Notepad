import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notepad/controller/HomeScreenController/HomeScreenController.dart';
import 'package:notepad/view/Note/Note.dart';

import '../../constants/colors_constants/colors_constants.dart';
import '../../constants/fonts_size_constant/fonts_size_constant.dart';
import '../../controller/LoginController/LoginController.dart';
import '../../controller/NoteController/NoteController.dart';
import '../../controller/SearchDelegate/searchDelegate.dart';
import '../Checklist/Checklist.dart';
import '../EditPost/EditPost.dart';
import '../Folder/Folder.dart';
import '../FullPageNote/FullPageNote.dart';

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeScreenController homeScreenController = Get.put(HomeScreenController());
    LoginController loginController = Get.put(LoginController());
    NoteController noteController = Get.put(NoteController());

    var heightt = MediaQuery.of(context).size.height * 1;
    var widthh = MediaQuery.of(context).size.width * 1;

    User? UserId = FirebaseAuth.instance.currentUser;
    final CollectionReference _notes =
        FirebaseFirestore.instance.collection('notes');

    Stream<QuerySnapshot> notesStream =
        _notes.where("UserId", isEqualTo: UserId!.uid).snapshots();

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
                }),
          ],
      
        ),
        drawer: Drawer(
          child: ElevatedButton(
            onPressed: () {
              // Call the showCustomDialog function to show the dialog
              // homeScreenController.showCustomDialog(context);
            },
            child: Text("Show Dialog"),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors_Constants.app_pink_color,
          onPressed: () async {
            Get.to(Note());
          },
          child: Icon(
            Icons.add,
            size: 30,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                    hintText: 'Search notes',
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
                      borderRadius: BorderRadius.circular(30),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(width: 2, color: Colors.white)),
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: notesStream,
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
                        "Error fetching data",
                        style: TextStyle(color: Colors.red, fontSize: 30),
                      ));
                    } else if (streamSnapshots.data!.docs.isEmpty) {
                      return Center(
                          child: Text(
                        "No data available",
                        style: TextStyle(color: Colors.red, fontSize: 30),
                      ));
                    }
                     else {
                      return ListView.builder(
                        itemCount: streamSnapshots.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshots.data!.docs[index];

                          final docId = streamSnapshots.data!.docs[index].id;
                          String position = documentSnapshot['title'];

                          bool doesNotContain = !position
                              .toLowerCase()
                              .contains(homeScreenController
                                  .SearchController.text
                                  .toString()
                                  .toLowerCase());

                          if (homeScreenController
                              .SearchController.text.isEmpty) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Card(
                                color: Colors_Constants.app_grey_color,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(2, 5, 2, 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => FullPageNote(), arguments: {
                                        "title": documentSnapshot['title'],
                                        "content": documentSnapshot['content'],
                                      });
                                    },
                                    child: ListTile(
                                        title: Text(
                                          documentSnapshot['title'],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontFamily: Fonts_Size_Constants
                                                  .heading_font_family,
                                              fontWeight: FontWeight.bold,
                                              color: Colors_Constants
                                                  .app_black_color,
                                              fontSize: Fonts_Size_Constants
                                                  .heading_font_size.sp),
                                        ),
                                        subtitle: Text(
                                          documentSnapshot['content'],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(
                                            fontFamily: Fonts_Size_Constants
                                                .regular_font_family,
                                            color: Colors_Constants
                                                .app_black_color,
                                          ),
                                        ),
                                        trailing: SizedBox(
                                            width: 100,
                                            child: Row(children: [
                                              IconButton(
                                                  icon: const Icon(Icons.edit),
                                                  onPressed: () async {
                                                    Get.to(EditPost(),
                                                        arguments: {
                                                          'title':
                                                              documentSnapshot[
                                                                  'title'],
                                                          'content':
                                                              documentSnapshot[
                                                                  'content'],
                                                          "docId": docId
                                                        });
                                                  }),
                                              IconButton(
                                                  icon:
                                                      const Icon(Icons.delete),
                                                  onPressed: () {
                                                    homeScreenController.delete(
                                                        documentSnapshot.id);
                                                  }),
                                            ]))),
                                  ),
                                ),
                              ),
                            );
                          } else if (position.toLowerCase().contains(
                              homeScreenController.SearchController.text
                                  .toString()
                                  .toLowerCase())) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Card(
                                color: Colors.red,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(2, 5, 2, 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => FullPageNote(), arguments: {
                                        "title": documentSnapshot['title'],
                                        "content": documentSnapshot['content'],
                                      });
                                    },
                                    child: ListTile(
                                        title: Text(
                                          documentSnapshot['title'],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontFamily: Fonts_Size_Constants
                                                  .heading_font_family,
                                              fontWeight: FontWeight.bold,
                                              color: Colors_Constants
                                                  .app_blue_color,
                                              fontSize: Fonts_Size_Constants
                                                  .heading_font_size.sp),
                                        ),
                                        subtitle: Text(
                                          documentSnapshot['content'],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(
                                            fontFamily: Fonts_Size_Constants
                                                .regular_font_family,
                                            color: Colors_Constants
                                                .app_black_color,
                                          ),
                                        ),
                                        trailing: SizedBox(
                                            width: 100,
                                            child: Row(children: [
                                              IconButton(
                                                  icon: const Icon(Icons.edit),
                                                  onPressed: () async {
                                                    Get.to(EditPost(),
                                                        arguments: {
                                                          'title':
                                                              documentSnapshot[
                                                                  'title'],
                                                          'content':
                                                              documentSnapshot[
                                                                  'content'],
                                                          "docId": docId
                                                        });
                                                  }),
                                              IconButton(
                                                  icon:
                                                      const Icon(Icons.delete),
                                                  onPressed: () {
                                                    homeScreenController.delete(
                                                        documentSnapshot.id);
                                                  }),
                                            ]))),
                                  ),
                                ),
                              ),
                            );
                          } else if (doesNotContain) {
                            return Center(
                              child: Text(
                                "Not found",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: Fonts_Size_Constants
                                        .heading_font_size.sp),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
