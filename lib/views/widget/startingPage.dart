import 'package:academyapp/utils/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/authpage.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Column(
        children: [
          // Top background + LOGO
          Container(
            width: screenWidth * 0.6,
            height: screenHeight * 0.3,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(60),
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/logos/nypunya_Icon.png',
                width: screenWidth * 0.8,
                height: screenWidth * 0.8,
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(height: 70),

          //Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              width: screenWidth * 0.8,
              child: ElevatedButton(
                // onPressed: () {
                //   Get.to(() => LoginPage());
                // },
                onPressed: () {
                  Get.to(() => LoginPage(),
                      transition: Transition.fadeIn,
                      duration: Duration(milliseconds: 600));
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange,
                  foregroundColor: AppColors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Illustration Image
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/images/loginKid.png',
                width: screenWidth,
                height: screenHeight * 0.7,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
