import 'package:academyapp/views/fragments/appbarFrag.dart';
import 'package:academyapp/views/pages/messages.dart';
import 'package:academyapp/views/widget/bottomsheetWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/floatingActionButton.dart';
import '../../utils/appTheme.dart';
import '../fragments/profileFrag.dart';

class HomePage extends StatelessWidget {
  // Instantiate the controller
  final FloatingActionController fabController =
      Get.put(FloatingActionController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double Swidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: CustomAppBar(
      //   title: "Home Page",
      //   showBackButton: false,
      // ),
      body: SafeArea(
        child: SizedBox(
          height: height,
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Container(
                width: Swidth,
                height: height,
                decoration: const BoxDecoration(
                  gradient: AppColors.customGradientHome,
                ),
              ),
              Positioned(
                top: height * 0.02,
                left: height * 0.07,
                child: Container(
                  width: height * 0.3,
                  child: Image.asset('assets/logos/logonypunya.png'),
                ),
              ),
              // Positioned(
              //   top: height * 0.18,
              //   // left: height * 0.07,
              //   child: UserInfoFragment(
              //     userName: "John Doe",
              //     userClass: "10th Grade",
              //     profileImageUrl: "https://example.com/user.jpg",
              //     backgroundColor: AppColors.blue,
              //     showSchoolName: true,
              //   ),
              // ),

              // UserInfoFragment(
              //   userName: "John Doe",
              //   userClass: "10th Grade",
              //   section: "B",
              //   rollNo: "21",
              //   profileImageUrl: "https://example.com/user.jpg",
              //   backgroundColor: Colors.grey[300]!, // Grey BG for Profile
              //   showSchoolName: false, // Don't show school name in Profile
              // ),

              Positioned(
                top: 300,
                left: 0,
                right: 0,
                child: Container(
                  height: height * 0.5,
                  width: height * 0.5,
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 25,
                    crossAxisCount: 3,
                    children: <Widget>[
                      _buildGridItem(
                        Icons.mail_outline_sharp,
                        'Message',
                        Colors.purple,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MessagePage()),
                          );
                        },
                      ),
                      _buildGridItem(
                        Icons.calendar_month_sharp,
                        'Calender',
                        Colors.lightBlueAccent,
                        onTap: () => Get.toNamed('/events'),
                      ),
                      _buildGridItem(
                        Icons.apps_outage,
                        'time table',
                        Colors.orangeAccent,
                        onTap: () => Get.toNamed('/tt'),
                      ),
                      _buildGridItem(
                        Icons.screen_search_desktop,
                        'Attendance',
                        Colors.green,
                        onTap: () => Get.toNamed('/attendance'),
                      ),
                      _buildGridItem(Icons.directions_bus_filled_outlined,
                          'Transport', Colors.pinkAccent,
                          onTap: () {}),
                      _buildGridItem(
                        Icons.list_alt,
                        'Reports',
                        Colors.purple,
                        onTap: () => Get.toNamed('/results'),
                      ),
                      _buildGridItem(
                        Icons.menu_book,
                        'HomeWork',
                        Colors.deepOrangeAccent,
                        onTap: () => Get.toNamed('/homework'),
                      ),
                      _buildGridItem(
                          Icons.image, 'Gallery', Colors.lightBlueAccent,
                          onTap: () {}),
                      _buildGridItem(Icons.currency_rupee, 'Fee', Colors.green,
                          onTap: () {})
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(IconData icon, String label, Color color,
      {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
              color: color, // Set custom color
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
}
