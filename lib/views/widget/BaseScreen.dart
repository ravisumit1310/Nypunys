import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseScreen extends StatelessWidget {
  final String title;
  final Widget child;
  final bool showBackButton;
  final bool showBottomImage;
  final Widget? floatingActionButton;

  const BaseScreen({
    super.key,
    required this.title,
    required this.child,
    this.showBackButton = true,
    this.showBottomImage = true,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    double sHeight = MediaQuery.of(context).size.height;
    double sWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        if (showBackButton && Get.previousRoute.isNotEmpty) {
          Get.back();
          return false;
        }
        return true;
      },
      child: Scaffold(
        floatingActionButton: floatingActionButton,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: sHeight,
              color: Colors.blue,
            ),
            Positioned(
              top: 130,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: child,
              ),
            ),
            if (showBottomImage)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Opacity(
                  opacity: 0.9,
                  child: Image.asset(
                    'assets/images/BottomImg.png',
                    width: sWidth,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Positioned(
              top: 40,
              left: 8,
              right: 8,
              child: Row(
                children: [
                  if (showBackButton && Get.previousRoute.isNotEmpty)
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                  Expanded(
                    child: Text(
                      title,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class BaseScreen extends StatelessWidget {
//   final String title;
//   final Widget child;
//   final bool showBackButton;
//   final bool showBottomImage;
//
//   const BaseScreen({
//     super.key,
//     required this.title,
//     required this.child,
//     this.showBackButton = true,
//     this.showBottomImage = true,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     double sHeight = MediaQuery.of(context).size.height;
//     double sWidth = MediaQuery.of(context).size.width;
//
//     return WillPopScope(
//       onWillPop: () async {
//         // Handle back button manually
//         if (showBackButton && Get.previousRoute.isNotEmpty) {
//           Get.back();
//           return false;
//         }
//         return true;
//       },
//       child: Scaffold(
//         body: Stack(
//           children: [
//             Container(
//               width: double.infinity,
//               height: sHeight,
//               color: Colors.blue,
//             ),
//             // ---------------------------- White base
//             Positioned(
//               top: 130,
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(8.0),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: child,
//               ),
//             ),
//             // ---------------------------- bottom base
//             if (showBottomImage)
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: Opacity(
//                   opacity: 0.9,
//                   child: Image.asset(
//                     'assets/images/BottomImg.png',
//                     width: sWidth,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             Positioned(
//               top: 40,
//               left: 8,
//               right: 8,
//               child: Row(
//                 children: [
//                   if (showBackButton && Get.previousRoute.isNotEmpty)
//                     IconButton(
//                       onPressed: () {
//                         Get.back();
//                       },
//                       icon:
//                           const Icon(Icons.arrow_back_ios, color: Colors.white),
//                     ),
//                   // SizedBox(width: 10,),
//                   Expanded(
//                     child: Text(
//                       title,
//                       textAlign: TextAlign.left,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
