import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference _products =
        FirebaseFirestore.instance.collection('products');

    return Scaffold(
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
                        title: Text(documentSnapshot['name'],style: TextStyle(fontSize: 30,color: Colors.red),),
                        subtitle: Text(documentSnapshot['price'].toString(),style: TextStyle(fontSize: 20,color: Colors.black),),
        
                      ),
                    );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
              },
            ),
        ));
  }
}
