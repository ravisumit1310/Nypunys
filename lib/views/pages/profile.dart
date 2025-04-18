import 'package:academyapp/controllers/sessionController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/appTheme.dart';
import '../fragments/changePasswordCard.dart';
import '../widget/switch_account_card.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final sessionController = Get.find<SessionController>();

  @override
  Widget build(BuildContext context) {
    double sWidth = MediaQuery.of(context).size.width;
    double sHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        final student = sessionController.studentProfile;

        if (student == null) {
          return const Center(
            child: Text(
              "Session Expired! Please log in again.",
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
          );
        }

        return SingleChildScrollView(
          child: Container(
            width: sWidth,
            height: sHeight,
            decoration: const BoxDecoration(
              gradient: AppColors.customGradientHome,
            ),
            padding:
                const EdgeInsets.only(top: 25, left: 0, right: 0, bottom: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 130,
                      width: 130,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Center(
                          child: Image(
                            image: AssetImage('assets/images/id_image.jpg'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      student.name ?? "Token Expired",
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.grey,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      student.admissionNo ?? "No Admission Number",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      student.email ?? "No Email Available",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      child: const Icon(
                        Icons.person,
                        color: Colors.purple,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.withOpacity(0.1),
                      ),
                    ),
                    title: const Text("your Details"),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    ),
                    onTap: () => Get.toNamed('/studentDetails'),
                  ),
                ),
                Divider(
                  height: 1,
                  color: Colors.grey.shade300,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      child: const Icon(
                        Icons.person,
                        color: Colors.purple,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.withOpacity(0.1),
                      ),
                    ),
                    title: const Text("Parents Section"),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: Colors.grey.shade300,
                ),

                //Password
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      child: const Icon(
                        Icons.password,
                        color: Colors.purple,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.withOpacity(0.1),
                      ),
                    ),
                    title: const Text("Change Password"),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) => ChangePasswordCard(),
                      );
                    },
                  ),
                ),
                Divider(
                  height: 1,
                  color: Colors.grey.shade300,
                ),

                //notification
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      child: const Icon(
                        Icons.notification_add,
                        color: Colors.purple,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.withOpacity(0.1),
                      ),
                    ),
                    title: const Text("School Notifications"),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    ),
                    onTap: () => Get.toNamed('/schoolNotification'),
                  ),
                ),
                Divider(
                  height: 1,
                  color: Colors.grey.shade300,
                ),
                //Help
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      child: const Icon(
                        Icons.account_circle_outlined,
                        color: Colors.purple,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.withOpacity(0.1),
                      ),
                    ),
                    title: const Text("Switch account"),
                    trailing: const Icon(
                      Icons.loop,
                      color: Colors.black,
                    ),
                    onTap: () => showAccountSwitcher(context),
                  ),
                ),
                Divider(
                  height: 1,
                  color: Colors.grey.shade300,
                ),

                //Logout
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      child: const Icon(
                        Icons.logout,
                        color: Colors.purple,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.withOpacity(0.1),
                      ),
                    ),
                    title: const Text("LogOut"),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    ),
                    onTap: () {
                      final logoutService = SessionController();
                      // Perform logout -> which is in the apicServices
                      logoutService.logout();
                      // Navigate to the login page using GetX route
                      Get.offNamed('/login');
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

// class ProfilePage extends StatelessWidget {
//   ProfilePage({super.key});
//
//   final sessionController = Get.find<SessionController>();
//   final studentController = Get.put(StudentController());
//
//   @override
//   Widget build(BuildContext context) {
//     double sWidth = MediaQuery.of(context).size.width;
//     double sHeight = MediaQuery.of(context).size.height;
//
//     studentController.fetchStudentDetails();
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Obx(() {
//         if (studentController.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         final student = studentController.student.value;
//         if (student == null) {
//           return const Center(
//             child: Text(
//               "Session Expired! Please log in again.",
//               style: TextStyle(color: Colors.red, fontSize: 18),
//             ),
//           );
//         }
//
//         return SingleChildScrollView(
//           child: Container(
//             width: sWidth,
//             height: sHeight,
//             decoration: const BoxDecoration(
//               gradient: AppColors.customGradientHome,
//             ),
//             padding:
//                 const EdgeInsets.only(top: 25, left: 0, right: 0, bottom: 15),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: 130,
//                       width: 130,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(100),
//                         child: const Center(
//                           child: Image(
//                             image: AssetImage('assets/images/id_image.jpg'),
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       student.name ?? "Token Expired",
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w800,
//                         color: Colors.grey,
//                         fontSize: 22,
//                       ),
//                     ),
//                     Text(
//                       student.admissionNo ?? "No Admission Number",
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black87,
//                         fontSize: 18,
//                       ),
//                     ),
//                     Text(
//                       student.email ?? "No Email Available",
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black87,
//                         fontSize: 16,
//                       ),
//                     ),
//                     Divider(
//                       height: 1,
//                       color: Colors.grey.shade300,
//                     ),
//                     const SizedBox(height: 10),
//                   ],
//                 ),
//
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ListTile(
//                     leading: Container(
//                       height: 50,
//                       width: 50,
//                       child: const Icon(
//                         Icons.person,
//                         color: Colors.purple,
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100),
//                         color: Colors.grey.withOpacity(0.1),
//                       ),
//                     ),
//                     title: const Text("your Details"),
//                     trailing: const Icon(
//                       Icons.navigate_next,
//                       color: Colors.black,
//                     ),
//                     onTap: () => Get.toNamed('/studentDetails'),
//                   ),
//                 ),
//                 Divider(
//                   height: 1,
//                   color: Colors.grey.shade300,
//                 ),
//
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ListTile(
//                     leading: Container(
//                       height: 50,
//                       width: 50,
//                       child: const Icon(
//                         Icons.person,
//                         color: Colors.purple,
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100),
//                         color: Colors.grey.withOpacity(0.1),
//                       ),
//                     ),
//                     title: const Text("Parents Section"),
//                     trailing: const Icon(
//                       Icons.navigate_next,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 Divider(
//                   height: 1,
//                   color: Colors.grey.shade300,
//                 ),
//
//                 //Grades
//                 // Padding(
//                 //   padding: const EdgeInsets.all(8.0),
//                 //   child: ListTile(
//                 //     leading: Container(
//                 //       height: 50,
//                 //       width: 50,
//                 //       child: const Icon(
//                 //         Icons.file_present_rounded,
//                 //         color: Colors.purple,
//                 //       ),
//                 //       decoration: BoxDecoration(
//                 //         borderRadius: BorderRadius.circular(100),
//                 //         color: Colors.grey.withOpacity(0.1),
//                 //       ),
//                 //     ),
//                 //     title: const Text("School Grades"),
//                 //     trailing: const Icon(
//                 //       Icons.navigate_next,
//                 //       color: Colors.black,
//                 //     ),
//                 //   ),
//                 // ),
//                 // Divider(
//                 //   height: 1,
//                 //   color: Colors.grey.shade300,
//                 // ),
//
//                 //notification
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ListTile(
//                     leading: Container(
//                       height: 50,
//                       width: 50,
//                       child: const Icon(
//                         Icons.notification_add,
//                         color: Colors.purple,
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100),
//                         color: Colors.grey.withOpacity(0.1),
//                       ),
//                     ),
//                     title: const Text("School Notifications"),
//                     trailing: const Icon(
//                       Icons.navigate_next,
//                       color: Colors.black,
//                     ),
//                     onTap: () => Get.toNamed('/schoolNotification'),
//                   ),
//                 ),
//                 Divider(
//                   height: 1,
//                   color: Colors.grey.shade300,
//                 ),
//                 //Help
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ListTile(
//                     leading: Container(
//                       height: 50,
//                       width: 50,
//                       child: const Icon(
//                         Icons.help,
//                         color: Colors.purple,
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100),
//                         color: Colors.grey.withOpacity(0.1),
//                       ),
//                     ),
//                     title: const Text("Need Help!"),
//                     trailing: const Icon(
//                       Icons.navigate_next,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 Divider(
//                   height: 1,
//                   color: Colors.grey.shade300,
//                 ),
//
//                 //Logout
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ListTile(
//                     leading: Container(
//                       height: 50,
//                       width: 50,
//                       child: const Icon(
//                         Icons.logout,
//                         color: Colors.purple,
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100),
//                         color: Colors.grey.withOpacity(0.1),
//                       ),
//                     ),
//                     title: const Text("LogOut"),
//                     trailing: const Icon(
//                       Icons.navigate_next,
//                       color: Colors.black,
//                     ),
//                     onTap: () {
//                       final logoutService = SessionController();
//                       // Perform logout -> which is in the apicServices
//                       logoutService.logout();
//                       // Navigate to the login page using GetX route
//                       Get.offNamed('/login');
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
