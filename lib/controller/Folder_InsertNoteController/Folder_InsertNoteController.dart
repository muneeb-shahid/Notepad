import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Folder_InsertNoteController extends GetxController {
  TextEditingController _titleController = TextEditingController();
  get TitleController => _titleController;

  TextEditingController _contentController = TextEditingController();
  get ContentController => _contentController;

  TextEditingController _UserIdController = TextEditingController();
  get UserIdController => _UserIdController;

  FocusNode _focusNode1 = FocusNode();
  get focusNode1 => _focusNode1;

  FocusNode _focusNode2 = FocusNode();
  get focusNode2 => _focusNode2;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  get formKey => _formKey;
  CollectionReference _folder = FirebaseFirestore.instance.collection('folder');

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();

    super.dispose();
  }

  String? validateTitle(String? input) {
    if (input == null || input.isEmpty) {
      return 'Title is required.';
    }

    return null;
  }

  String UserId = FirebaseAuth.instance.currentUser!.uid;
  insertData() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final String title = _titleController.text;
      final String content = _contentController.text;

      if (content != null) {
        await _folder
            .add({"title": title, "content": content, "UserId": UserId});

        _titleController.text = '';
        _contentController.text = '';
        _UserIdController.text = '';

        Get.back();
      }
    }
  }
}
