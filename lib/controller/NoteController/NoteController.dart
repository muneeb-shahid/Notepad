import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';


class NoteController extends GetxController {
  TextEditingController _titleController = TextEditingController();
  get TitleController => _titleController;

  TextEditingController _contentController = TextEditingController();
  get ContentController => _contentController;

  FocusNode _focusNode1 = FocusNode();
  get focusNode1 => _focusNode1;
  FocusNode _focusNode2 = FocusNode();
  get focusNode2 => _focusNode2;



  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  get formKey => _formKey;
  CollectionReference _notes =
      FirebaseFirestore.instance.collection('notes');

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

   String? validateContent(String? input) {
    if (input == null || input.isEmpty) {
      return 'Content is required.';
    }

    return null;
  }



}
