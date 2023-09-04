import 'package:get/get.dart';

import '../../view/HomeScreen/Home_screen.dart';

class BottomNavController extends GetxController {
  int currentIndex = 0;
  final screens = [
    HomePage(),
    // Favourite(),
    
  ];

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }
}
