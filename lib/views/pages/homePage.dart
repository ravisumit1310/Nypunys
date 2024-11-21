import 'package:academyapp/views/fragments/appbarFrag.dart';
import 'package:academyapp/views/pages/messages.dart';
import 'package:academyapp/views/widget/bottomsheetWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/floatingActionButton.dart';

class HomePage extends StatelessWidget {
  // Instantiate the controller
  final FloatingActionController fabController =
      Get.put(FloatingActionController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Home Page",
        showBackButton: true,
      ),
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Positioned(
              top: height * 0.05,
              left: height * 0.07,
              child: Container(
                width: height * 0.3,
                child: Image.asset('assets/logos/logonypunya.png'),
              ),
            ),
            Positioned(
              top: 230,
              left: 0,
              right: 0,
              child: Container(
                height: height * 0.5,
                width: height * 0.47,
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                  crossAxisCount: 3,
                  children: <Widget>[
                    _buildGridItem(
                      Icons.mail_outline_sharp,
                      'Message',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MessagePage()),
                        );
                      },
                    ),
                    _buildGridItem(Icons.calendar_month_sharp, 'Calender',
                        onTap: () {}),
                    _buildGridItem(Icons.apps_outage, 'time table',
                        onTap: () {}),
                    _buildGridItem(Icons.monetization_on_rounded, 'Fees',
                        onTap: () {}),
                    _buildGridItem(
                        Icons.directions_bus_filled_outlined, 'Transport',
                        onTap: () {}),
                    _buildGridItem(Icons.menu_book, 'HomeWork', onTap: () {}),
                    _buildGridItem(Icons.list_alt, 'Reports', onTap: () {}),
                    _buildGridItem(Icons.image, 'Gallery', onTap: () {}),
                    _buildGridItem(Icons.headset_mic_rounded, 'Help',
                        onTap: () {})
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // Allow full-screen height if needed
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              return CustomBottomSheet(
                options: [
                  {
                    "icon": Icons.group,
                    "label": "Chat",
                    "onTap": () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MessagePage()),
                      );
                    },
                  },
                  {
                    "icon": Icons.event,
                    "label": "Events",
                    "onTap": () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MessagePage()),
                      );
                    },
                  },
                  {
                    "icon": Icons.share,
                    "label": "Invite",
                    "onTap": () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MessagePage()),
                      );
                    },
                  },
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      // floatingActionButton: Obx(() {
      //   return Stack(
      //     children: [
      //       // Task FAB 1
      //       if (fabController.isExpanded.value) ...[
      //         Positioned(
      //           bottom: 100,
      //           right: 16,
      //           child: FloatingActionButton(
      //             heroTag: "task1",
      //             onPressed: () {
      //               // Handle task 1
      //             },
      //             child: Icon(Icons.task),
      //           ),
      //         ),
      //         // Task FAB 2
      //         Positioned(
      //           bottom: 160,
      //           right: 16,
      //           child: FloatingActionButton(
      //             heroTag: "task2",
      //             onPressed: () {
      //               // Handle task 2
      //             },
      //             child: Icon(Icons.alarm),
      //           ),
      //         ),
      //       ],
      //       // Main FAB (Calendar Icon)
      //       Positioned(
      //         bottom: 0,
      //         right: 6,
      //         child: FloatingActionButton(
      //           onPressed: () {
      //             fabController.toggle();
      //           },
      //           child: Icon(Icons.add),
      //         ),
      //       ),
      //     ],
      //   );
      // }),
    );
  }

  // Updated helper method to include navigation
  Widget _buildGridItem(IconData icon, String label,
      {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.green.shade900,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildGridItem(IconData icon, String label) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(2),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.3),
  //           spreadRadius: 1,
  //           blurRadius: 1,
  //           offset: Offset(0, 1),
  //         ),
  //       ],
  //     ),
  //     padding: const EdgeInsets.all(8),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Icon(
  //           icon,
  //           size: 50,
  //           color: Colors.green.shade900,
  //         ),
  //         SizedBox(
  //           height: 15,
  //         ),
  //         Text(
  //           label,
  //           style: TextStyle(
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
