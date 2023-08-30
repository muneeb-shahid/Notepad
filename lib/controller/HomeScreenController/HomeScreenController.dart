import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../constants/colors_constants/colors_constants.dart';

class HomeScreenController extends GetxController {
  CollectionReference _notes = FirebaseFirestore.instance.collection('notes');

  Future<void> delete(String productId) async {
    await _notes.doc(productId).delete();

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



   
  // Future<void> updateNote([DocumentSnapshot? documentSnapshot]) async {
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

}
