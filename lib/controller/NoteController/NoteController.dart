import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class NoteController extends GetxController {
  late QuillEditorController controller;
  bool _hasFocus = false;
  get hasFocus => _hasFocus;

  @override
  void onInit() {
    super.onInit();
    controller = QuillEditorController();
    controller.onTextChanged((text) {
      print('listening to $text');
    });
    controller.onEditorLoaded(() {
      print('Editor Loaded :)');
    });
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  void getHtmlText() async {
    String? htmlText = await controller.getText();
    print(htmlText);
  }

  void setHtmlText(String text) async {
    await controller.setText(text);
  }

  void insertNetworkImage(String url) async {
    await controller.embedImage(url);
  }

  void insertVideoURL(String url) async {
    await controller.embedVideo(url);
  }

  void insertHtmlText(String text, {int? index}) async {
    await controller.insertText(text, index: index);
  }

  void clearEditor() => controller.clear();

  void enableEditor(bool enable) => controller.enableEditor(enable);

  void unFocusEditor() => controller.unFocus();
}
