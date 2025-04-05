import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/passwordChange_Controller.dart';
import '../../utils/appTheme.dart';

void showChangePasswordPopup() {
  final ProfileUpdateController profileController = Get.find();

  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Change Password",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),

          // Old Password
          TextField(
            controller: profileController.oldPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Old Password",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 15),

          // New Password
          TextField(
            controller: profileController.newPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "New Password",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 20),

          Obx(() => ElevatedButton(
                onPressed: profileController.isChangingPassword.value
                    ? null
                    : () async {
                        final success =
                            await profileController.changePassword();
                        if (success) {
                          Get.snackbar(
                              "Success", "Password changed successfully");
                          Get.back();
                        } else {
                          Get.snackbar("Error", "Failed to change password");
                        }
                      },
                child: profileController.isChangingPassword.value
                    ? const CircularProgressIndicator()
                    : const Text("Save"),
              )),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}

Widget buildLabeledRow({
  required String label,
  required String value,
  required String fieldKey,
  void Function(String label, String fieldKey, String currentValue)? onEdit,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondary,
        ),
      ),
      const SizedBox(height: 10),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 3),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.textSecondary,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 40, // fixed width for icon alignment
              child: Center(
                child: onEdit != null
                    ? IconButton(
                        onPressed: () => onEdit(label, fieldKey, value),
                        icon: const Icon(
                          Icons.lock_open_outlined,
                          color: AppColors.textSecondary,
                        ),
                      )
                    : Text(""),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// void showEditPopupCard(String label, String fieldKey, String currentValue) {
//   final TextEditingController controller =
//       TextEditingController(text: currentValue);
//   final StudentController studentController = Get.find();
//
//   Get.bottomSheet(
//     Container(
//       padding: const EdgeInsets.all(20),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text("Edit $label",
//               style:
//                   const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 15),
//           TextField(
//             controller: controller,
//             decoration: InputDecoration(
//               labelText: label,
//               border:
//                   OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//             ),
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () async {
//               final newValue = controller.text.trim();
//               if (newValue.isNotEmpty && newValue != currentValue) {
//                 await studentController.updateStudentProfile({
//                   fieldKey: newValue,
//                 });
//                 Get.back();
//               } else {
//                 Get.back();
//               }
//             },
//             child: const Text("Save"),
//           ),
//         ],
//       ),
//     ),
//     isScrollControlled: true,
//   );
// }
