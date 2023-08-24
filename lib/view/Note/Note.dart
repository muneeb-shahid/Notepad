import 'package:flutter/material.dart';

class Note extends StatelessWidget {
  const Note({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Note",style: TextStyle(fontSize: 100),),
    );
  }
}
