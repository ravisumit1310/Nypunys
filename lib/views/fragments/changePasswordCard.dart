import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/passwordChange_Controller.dart';

class ChangePasswordCard extends StatefulWidget {
  @override
  State<ChangePasswordCard> createState() => _ChangePasswordCardState();
}

class _ChangePasswordCardState extends State<ChangePasswordCard> {
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  final ProfileUpdateController controller = Get.put(ProfileUpdateController());

  Color buttonColor = Colors.blue;
  bool isProcessing = false;

  void handleChangePassword() async {
    final oldPass = oldPassController.text.trim();
    final newPass = newPassController.text.trim();
    final confirmPass = confirmPassController.text.trim();

    if (oldPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
      Get.snackbar("Error", "All fields are required",
          backgroundColor: Colors.red[100]);
      return;
    }

    if (newPass != confirmPass) {
      Get.snackbar("Error", "New and confirm passwords do not match",
          backgroundColor: Colors.red[100]);
      return;
    }

    setState(() => isProcessing = true);

    controller.oldPasswordController.text = oldPass;
    controller.newPasswordController.text = newPass;

    final isSuccess = await controller.changePassword();

    if (isSuccess) {
      setState(() => buttonColor = Colors.green);
      Get.snackbar("Success", "Password changed successfully!",
          backgroundColor: Colors.green[100]);
      await Future.delayed(Duration(seconds: 1));
      Navigator.pop(context); // close the modal
    } else {
      setState(() => buttonColor = Colors.red);
      Get.snackbar("Error", "Failed to change password",
          backgroundColor: Colors.red[100]);
      await Future.delayed(Duration(seconds: 3));
      setState(() => buttonColor = Colors.blue);
    }

    setState(() => isProcessing = false);
  }

  @override
  Widget build(BuildContext context) {
    final sHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      height: sHeight * 0.55,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Close Button
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(height: 8),

            // 🔹 Title
            const Text(
              "Change Password",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),

            _buildTextField(
              controller: oldPassController,
              label: "Old Password",
              icon: Icons.lock_outline,
              obscureText: true,
            ),

            const SizedBox(height: 16),

            _buildTextField(
              controller: newPassController,
              label: "New Password",
              icon: Icons.lock_open,
              obscureText: true,
            ),

            const SizedBox(height: 16),

            _buildTextField(
              controller: confirmPassController,
              label: "Confirm Password",
              icon: Icons.check_circle_outline,
              obscureText: true,
            ),

            const SizedBox(height: 24),

            // 🔘 Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: isProcessing
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      )
                    : const Text("Change Your Password"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: isProcessing ? null : handleChangePassword,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blue),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

// class ChangePasswordCard extends StatelessWidget {
//   final PasswordChangeController controller =
//       Get.put(PasswordChangeController());
//
//   final TextEditingController oldPassController = TextEditingController();
//   final TextEditingController newPassController = TextEditingController();
//   final TextEditingController confirmPassController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final sHeight = MediaQuery.of(context).size.height;
//
//     // Inject the text controllers into the controller
//     controller.oldPasswordController.text = '';
//     controller.newPasswordContreller.text = '';
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
//       height: sHeight * 0.55,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Align(
//             alignment: Alignment.topRight,
//             child: IconButton(
//               icon: const Icon(Icons.close, color: Colors.grey),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ),
//           const SizedBox(height: 8),
//           const Text(
//             "Change Password",
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.blue,
//             ),
//           ),
//           const SizedBox(height: 16),
//           _buildTextField(
//             controller: oldPassController,
//             label: "Old Password",
//             icon: Icons.lock_outline,
//             obscureText: true,
//           ),
//           const SizedBox(height: 16),
//           _buildTextField(
//             controller: newPassController,
//             label: "New Password",
//             icon: Icons.lock_open,
//             obscureText: true,
//           ),
//           const SizedBox(height: 16),
//           _buildTextField(
//             controller: confirmPassController,
//             label: "Confirm Password",
//             icon: Icons.check_circle_outline,
//             obscureText: true,
//           ),
//           const SizedBox(height: 24),
//           Obx(() => SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton.icon(
//                   icon: controller.isLoading.value
//                       ? const SizedBox(
//                           height: 20,
//                           width: 20,
//                           child: CircularProgressIndicator(
//                               strokeWidth: 2, color: Colors.white),
//                         )
//                       : const Icon(Icons.save),
//                   label: const Text("Change Password"),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onPressed: controller.isLoading.value
//                       ? null
//                       : () async {
//                           final oldPass = oldPassController.text.trim();
//                           final newPass = newPassController.text.trim();
//                           final confirmPass = confirmPassController.text.trim();
//
//                           if (oldPass.isEmpty ||
//                               newPass.isEmpty ||
//                               confirmPass.isEmpty) {
//                             Get.snackbar("Error", "All fields are required");
//                             return;
//                           }
//
//                           if (newPass != confirmPass) {
//                             Get.snackbar("Error",
//                                 "New and confirm passwords must match");
//                             return;
//                           }
//
//                           controller.oldPasswordController.text = oldPass;
//                           controller.newPasswordContreller.text = newPass;
//
//                           await controller.changePassword();
//                         },
//                 ),
//               )),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     bool obscureText = false,
//   }) {
//     return TextField(
//       controller: controller,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: Colors.blue),
//         labelText: label,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//         focusedBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.blue),
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//   }
// }
