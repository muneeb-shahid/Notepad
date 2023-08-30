import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference _products =
        FirebaseFirestore.instance.collection('products');

    TextEditingController _nameController = TextEditingController();

    TextEditingController _priceController = TextEditingController();

    Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
      await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext ctx) {
            return Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Create'),
                    onPressed: () async {
                      final String name = _nameController.text;
                      final double? price =
                          double.tryParse(_priceController.text);
                      if (price != null) {
                        await _products.add({"name": name, "price": price});

                        _nameController.text = '';
                        _priceController.text = '';
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              ),
            );
          });
    }

    Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
      if (documentSnapshot != null) {
        _nameController.text = documentSnapshot['name'];
        _priceController.text = documentSnapshot['price'].toString();
      }
      await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext ctx) {
            return Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Update'),
                    onPressed: () async {
                      final String name = _nameController.text;
                      final double? price =
                          double.tryParse(_priceController.text);
                      if (price != null) {
                        await _products
                            .doc(documentSnapshot!.id)
                            .update({"name": name, "price": price});
                        _nameController.text = '';
                        _priceController.text = '';
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              ),
            );
          });
    }

    Future<void> _delete(String productId) async {
      await _products.doc(productId).delete();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('You have successfully deleted a product')));
    }

    return Scaffold(
        backgroundColor: Colors.red,
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: Icon(Icons.create),
        ),

        body: SafeArea(
          top: true,
          child: StreamBuilder(
            stream: _products.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshots) {
              if (streamSnapshots.hasData) {
                return ListView.builder(
                  itemCount: streamSnapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshots.data!.docs[index];
                    return Card(
                      child: ListTile(
                          title: Text(
                            documentSnapshot['name'],
                            style: TextStyle(fontSize: 30, color: Colors.red),
                          ),
                          subtitle: Text(
                            documentSnapshot['price'].toString(),
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          trailing: SizedBox(
                              width: 100,
                              child: Row(children: [
                                IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () => _update(documentSnapshot)),
                                IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      _delete(documentSnapshot.id);
                                    }),
                              ]))),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        )
        );
  
  
  }
}
