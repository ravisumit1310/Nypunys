import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controllers/sessionController.dart';
import '../../models/studentDetails_Model.dart';

void showAccountSwitcher(BuildContext context) {
  final sessionController = Get.find<SessionController>();
  final currentProfile = sessionController.studentProfile;
  final accounts = sessionController.getSavedAccounts();

  if (currentProfile == null && accounts.isEmpty) {
    Get.offAllNamed('/login');
    return;
  }

  sessionController.saveCurrentAccount();

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          children: [
            Text("Switch Account",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...accounts.map((acc) {
              final profile = acc["profile"];
              final isCurrent = currentProfile?.id == profile?['id'];

              return ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: Icon(Icons.account_circle,
                      color: isCurrent ? Colors.blue : Colors.grey),
                ),
                title: Text(profile?['name'] ?? "Unknown"),
                trailing: isCurrent
                    ? Icon(Icons.check_circle, color: Colors.green)
                    : null,
                onTap: isCurrent
                    ? null
                    : () async {
                        Navigator.pop(context);
                        final accessToken = acc["access_token"];
                        final refreshToken = acc["refresh_token"];
                        final profileData = acc["profile"];

                        final isValid = await sessionController
                            .isAccessTokenValid(accessToken);

                        if (isValid) {
                          sessionController.saveSession(
                            accessToken,
                            refreshToken,
                            profileData,
                          );
                        } else {
                          sessionController.studentProfile =
                              StudentDetailsModel.fromJson(profileData);
                          await sessionController.refreshAccessToken();
                        }
                      },
              );
            }).toList(),
            const Divider(height: 20),
            ListTile(
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.green.withOpacity(0.1),
                ),
                child: Icon(Icons.add, color: Colors.green),
              ),
              title: Text("Add another account"),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed('/login');
              },
            ),
          ],
        ),
      );
    },
  );
}

// void showAccountSwitcher(BuildContext context) {
//   final storage = GetStorage();
//   final sessionController = Get.find<SessionController>();
//   final currentProfile = sessionController.studentProfile;
//   final savedMap =
//       (storage.read("saved_nicknames") as Map?)?.cast<String, String>() ?? {};
//   final savedAccounts =
//       savedMap.entries.map((e) => {'key': e.key, 'name': e.value}).toList();
//   print("savedAccounts -- $savedAccounts");
//
//   if (currentProfile == null && savedAccounts.isEmpty) {
//     Get.offAllNamed('/login');
//     return;
//   }
//
//   showModalBottomSheet(
//     context: context,
//     backgroundColor: Colors.white,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     builder: (context) {
//       return Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Wrap(
//           children: [
//             Text("Switch Account",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 10),
//             ...savedAccounts.map((acc) {
//               final savedDataRaw = storage.read(acc['key']!);
//               final savedData =
//                   savedDataRaw != null ? jsonDecode(savedDataRaw) : null;
//               final savedProfileId =
//                   savedData?['student_profile']?['id']?.toString();
//
//               final isCurrent = currentProfile?.id.toString() == savedProfileId;
//
//               return ListTile(
//                 leading: Container(
//                   height: 50,
//                   width: 50,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(100),
//                     color: Colors.grey.withOpacity(0.1),
//                   ),
//                   child: Icon(Icons.account_circle,
//                       color: isCurrent ? Colors.blue : Colors.grey),
//                 ),
//                 title: Text(acc['name'] ?? "Unknown"),
//                 trailing: isCurrent
//                     ? Icon(Icons.check_circle, color: Colors.green)
//                     : null,
//                 onTap: isCurrent
//                     ? null
//                     : () {
//                         sessionController.saveSession(
//                           savedData['access_token'],
//                           savedData['refresh_token'],
//                           savedData['student_profile'],
//                         );
//                         Navigator.pop(context);
//                       },
//               );
//             }).toList(),
//
//             const Divider(height: 20),
//
//             // + Add Account button
//             ListTile(
//               leading: Container(
//                 height: 50,
//                 width: 50,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   color: Colors.green.withOpacity(0.1),
//                 ),
//                 child: Icon(Icons.add, color: Colors.green),
//               ),
//               title: Text("Add another account"),
//               onTap: () {
//                 Navigator.pop(context); // Close bottom sheet first
//                 Get.toNamed('/login'); // Then go to login screen
//               },
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
