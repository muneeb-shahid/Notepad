import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  get formKey => _formKey;
  final TextEditingController _login_NameTextEditingController =
      TextEditingController();
  get NameTextEditingController => _login_NameTextEditingController;

  final TextEditingController _login_EmailTextEditingController =
      TextEditingController();
  get emailAddress => _login_EmailTextEditingController;

  final TextEditingController _login_PasswordTextEditingController =
      TextEditingController();
  get password => _login_PasswordTextEditingController;

  FocusNode _focusNode1 = FocusNode();
  get focusNode1 => _focusNode1;
  FocusNode _focusNode2 = FocusNode();
  get focusNode2 => _focusNode2;

}
