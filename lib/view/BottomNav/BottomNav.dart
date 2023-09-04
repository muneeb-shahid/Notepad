import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad/constants/colors_constants/colors_constants.dart';
import 'package:notepad/controller/BottomNavController/BottomNavController.dart';


class BottomNav extends StatelessWidget {
  BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    var heightt = MediaQuery.of(context).size.height * 1;
    var widthh = MediaQuery.of(context).size.width * 1;
    return GetBuilder<BottomNavController>(
        init: BottomNavController(),
        builder: (bottomNavController) {
          return Scaffold(
              backgroundColor: Colors_Constants.app_background_color,
              body:
                  bottomNavController.screens[bottomNavController.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                elevation: 5,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                selectedItemColor: Colors.black,
                showUnselectedLabels: false,
                currentIndex: bottomNavController.currentIndex,
                onTap: bottomNavController.changeIndex,
                items: [
              const    BottomNavigationBarItem(
                    activeIcon: Icon(Icons.note_add),
                    icon:  Icon(
                      Icons.note_add_outlined,
                      color: Colors.black,
                    ),
                    label: "Notes",
                  ),
          const        BottomNavigationBarItem(
                    activeIcon: Icon(Icons.check_circle),
                    icon: Icon(
                      Icons.check_circle_outline_outlined,
                      color: Colors.black,
                    ),
                    label: "To-dos",
                  ),
               
                ],
              ));
        });
  }
}