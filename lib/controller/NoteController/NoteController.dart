import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../constants/colors_constants/colors_constants.dart';

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


  // QuillEditorController controller = QuillEditorController();

  // bool _hasFocus = false;
  // get hasFocus => _hasFocus;

  // @override
  // void onInit() {
  //   super.onInit();
  //   controller = QuillEditorController();

  //   controller.onTextChanged((text) {
  //     print('listening to $text');
  //   });
  //   controller.onEditorLoaded(() {
  //     print('Editor Loaded :)');
  //   });
  // }

  // @override
  // void onClose() {
  //   controller.dispose();
  //   super.onClose();
  // }

  // void getHtmlText() async {
  //   String? htmlText = await controller.getText();
  //   print(htmlText);
  // }

  // void setHtmlText(String text) async {
  //   await controller.setText(text);
  // }

  // void insertNetworkImage(String url) async {
  //   await controller.embedImage(url);
  // }

  // void insertVideoURL(String url) async {
  //   await controller.embedVideo(url);
  // }

  // void insertHtmlText(String text, {int? index}) async {
  //   await controller.insertText(text, index: index);
  // }

  // void clearEditor() => controller.clear();

  // void enableEditor(bool enable) => controller.enableEditor(enable);

  // void unFocusEditor() => controller.unFocus();
}
