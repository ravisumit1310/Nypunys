import 'package:academyapp/controllers/bottomNavigation_Controller.dart';
import 'package:academyapp/views/pages/attendance.dart';
import 'package:academyapp/views/pages/homePage.dart';
import 'package:academyapp/views/pages/profile.dart';
import 'package:academyapp/views/pages/messages.dart';
import 'package:academyapp/views/pages/quiz.dart';
import 'package:academyapp/views/pages/work.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomFragment extends StatelessWidget {
  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.grey.withOpacity(0.7),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  bottomMenu(BuildContext context, BottomNavigationController controller) {
    return Obx(
      () => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: SizedBox(
            height: 54,
            child: BottomNavigationBar(
              showUnselectedLabels: true,
              showSelectedLabels: true,
              onTap: (index) {
                controller.tab(index);
              },
              currentIndex: controller.tab.value,
              backgroundColor: Colors.blueGrey.shade500,
              unselectedItemColor: Colors.grey.withOpacity(0.9),
              selectedItemColor: Colors.purpleAccent,
              unselectedLabelStyle: unselectedLabelStyle,
              selectedLabelStyle: selectedLabelStyle,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.quiz_outlined),
                  label: 'Quiz',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_chart_outlined),
                  label: 'Attendance',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationController landingPageController =
        Get.put(BottomNavigationController(), permanent: false);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: bottomMenu(context, landingPageController),
        body: Obx(
          () => IndexedStack(
            index: landingPageController.tab.value,
            children: [
              HomePage(),
              Quiz(),
              AttendancePage(),
              ProfilePage(),
            ],
          ),
        ),
      ),
    );
  }
}
