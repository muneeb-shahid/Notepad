import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullPageNoteController extends GetxController{

  TextEditingController _titleController = TextEditingController();
  get TitleController => _titleController;

  TextEditingController _contentController = TextEditingController();
  get ContentController => _contentController;

  
}