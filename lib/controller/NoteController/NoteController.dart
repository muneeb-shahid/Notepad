import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../constants/colors_constants/colors_constants.dart';

class NoteController extends GetxController {
  TextEditingController _nameController = TextEditingController();
  get NameController => _nameController;

  TextEditingController _priceController = TextEditingController();
  get PriceController => _priceController;

  FocusNode _focusNode1 = FocusNode();
  get focusNode1 => _focusNode1;
  FocusNode _focusNode2 = FocusNode();
  get focusNode2 => _focusNode2;



  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  get formKey => _formKey;
  CollectionReference _products =
      FirebaseFirestore.instance.collection('products');

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();

    super.dispose();
  }

  // Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
  //   await showModalBottomSheet(
  //       isScrollControlled: true,
  //       context: context,
  //       builder: (BuildContext ctx) {
  //         return Padding(
  //           padding: EdgeInsets.only(
  //               top: 20,
  //               left: 20,
  //               right: 20,
  //               bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               TextField(
  //                 controller: _nameController,
  //                 decoration: const InputDecoration(labelText: 'Name'),
  //               ),
  //               TextField(
  //                 keyboardType:
  //                     const TextInputType.numberWithOptions(decimal: true),
  //                 controller: _priceController,
  //                 decoration: const InputDecoration(
  //                   labelText: 'Price',
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 20,
  //               ),
  //               ElevatedButton(
  //                 child: const Text('Create'),
  //                 onPressed: () async {
  //                   final String name = _nameController.text;
  //                   final double? price =
  //                       double.tryParse(_priceController.text);
  //                   if (price != null) {
  //                     await _products.add({"name": name, "price": price});

  //                     _nameController.text = '';
  //                     _priceController.text = '';
  //                     Navigator.of(context).pop();
  //                   }
  //                 },
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }

  // Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
  //   if (documentSnapshot != null) {
  //     _nameController.text = documentSnapshot['name'];
  //     _priceController.text = documentSnapshot['price'].toString();
  //   }
  //   await showModalBottomSheet(
  //       isScrollControlled: true,
  //       context: context,
  //       builder: (BuildContext ctx) {
  //         return Padding(
  //           padding: EdgeInsets.only(
  //               top: 20,
  //               left: 20,
  //               right: 20,
  //               bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               TextField(
  //                 controller: _nameController,
  //                 decoration: const InputDecoration(labelText: 'Name'),
  //               ),
  //               TextField(
  //                 keyboardType:
  //                     const TextInputType.numberWithOptions(decimal: true),
  //                 controller: _priceController,
  //                 decoration: const InputDecoration(
  //                   labelText: 'Price',
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 20,
  //               ),
  //               ElevatedButton(
  //                 child: const Text('Update'),
  //                 onPressed: () async {
  //                   final String name = _nameController.text;
  //                   final double? price =
  //                       double.tryParse(_priceController.text);
  //                   if (price != null) {
  //                     await _products
  //                         .doc(documentSnapshot!.id)
  //                         .update({"name": name, "price": price});
  //                     _nameController.text = '';
  //                     _priceController.text = '';
  //                     Navigator.of(context).pop();
  //                   }
  //                 },
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }

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

  Future<void> delete(String productId) async {
    await _products.doc(productId).delete();

    Get.snackbar(
      'successfully deleted', //Snackbar title
      'You have successfully deleted a Note', // Snackbar message
      icon: const Icon(Icons.delete, color: Colors.black),
      backgroundColor: Colors_Constants.app_white_color,
      colorText: Colors.black,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(
          seconds: 3), // Duration for which the Snackbar is shown
    );
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
