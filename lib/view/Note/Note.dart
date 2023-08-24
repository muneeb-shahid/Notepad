import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import '../../constants/colors_constants/colors_constants.dart';

class Note extends StatelessWidget {
  const Note({super.key});

  @override
  Widget build(BuildContext context) {
    HtmlEditorController controller = HtmlEditorController();
    return Scaffold(
      backgroundColor: Colors.red,
        // backgroundColor: Colors_Constants.app_black_color,
        appBar: AppBar(
          backgroundColor: Colors_Constants.app_pink_color,
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.save_rounded)),
        ),
        body: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    HtmlEditor(
      controller: controller,
      htmlEditorOptions: HtmlEditorOptions(
        hint: 'Your text here...',
        shouldEnsureVisible: true,
        //initialText: "<p>text content initial, if any</p>",
      ),
      htmlToolbarOptions: HtmlToolbarOptions(
        toolbarPosition: ToolbarPosition.custom, //required to place toolbar anywhere!
        //other options
      ),
      otherOptions: OtherOptions(height: 550),
    ),
    //other widgets here
   
    ToolbarWidget(
      controller: controller,
      htmlToolbarOptions: HtmlToolbarOptions(
        toolbarPosition: ToolbarPosition.custom, //required to place toolbar anywhere!
        //other options
      ), callbacks: null,
    )
  ]
),
        );
  }
}
