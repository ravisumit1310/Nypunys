import 'package:academyapp/utils/appTheme.dart';
import 'package:academyapp/views/fragments/formatDate.dart';
import 'package:academyapp/views/widget/BaseScreen.dart';
import 'package:academyapp/views/widget/refreshWrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/passwordChange_Controller.dart';
import '../../controllers/studentData_Controller.dart';
import '../widget/profileEditPopup.dart';

class StudentProfilePage extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());
  final ProfileUpdateController profileController =
      Get.put(ProfileUpdateController());
  //await profileController.updateProfile();

  @override
  Widget build(BuildContext context) {
    double Lheight = MediaQuery.of(context).size.height;
    double Lwidth = MediaQuery.of(context).size.width;

    return BaseScreen(
      title: "Student Profile",
      showBottomImage: false,
      child: Obx(() {
        if (studentController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (studentController.student.value == null) {
          return const Center(child: Text("No Data Found!"));
        }

        final student = studentController.student.value!;

        return RefreshIndicator(
          onRefresh: () async {
            await studentController.fetchStudentDetails();
          },
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.blue),
                  borderRadius: BorderRadius.circular(18),
                  color: AppColors.background,
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        "assets/images/id_image.png",
                        width: Lwidth * 0.12,
                        height: Lheight * 0.07,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // 🔹 Student Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                student.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 22,
                                ),
                              ),
                              const SizedBox(width: 10),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.camera_alt),
                              ),
                            ],
                          ),
                          const Divider(height: 1.5),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Class ${student.className}"),
                              const Text(" | "),
                              Text("Admission No. ${student.admissionNo}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Adhar No.",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textSecondary),
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.only(bottom: 3),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: AppColors.textSecondary,
                                    width: 1), // Bottom line
                              ),
                            ),
                            child: Text(
                              student.adharCardNo ??
                                  "293849823798", // Aadhaar number
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date of Birth",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textSecondary),
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.only(bottom: 3),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: AppColors.textSecondary, width: 1),
                              ),
                            ),
                            child: Text(
                              formatDate(student.dateOfBirth) ?? "NA",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Class",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textSecondary),
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.only(
                                bottom: 3), // Spacing between text and line
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: AppColors.textSecondary, width: 1),
                              ),
                            ),
                            child: Text(
                              student.className ?? "NA",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Blood Group",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textSecondary),
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.only(bottom: 3),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: AppColors.textSecondary,
                                    width: 1), // Bottom line
                              ),
                            ),
                            child: Text(
                              student.bloodGroup ?? "NA",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Age",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textSecondary),
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.only(bottom: 3),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: AppColors.textSecondary,
                                    width: 1), // Bottom line
                              ),
                            ),
                            child: Text(
                              student.age.toString() ?? "NA",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              buildLabeledRow(
                label: "Name",
                value: student.name ?? "NA",
                fieldKey: "name",
                onEdit: null,
              ),
              const SizedBox(height: 20),
              buildLabeledRow(
                label: "Registerd WhatsApp No.",
                value: student.whatsappNo ?? "NA",
                fieldKey: "whatsApp_no",
                onEdit: (label, fieldKey, currentValue) =>
                    showEditPopupCard(context, label, fieldKey, currentValue),
              ),
              const SizedBox(height: 20),
              buildLabeledRow(
                label: "Your Mail ID",
                value: student.email ?? "NA",
                fieldKey: "mail",
                onEdit: (label, fieldKey, currentValue) =>
                    showEditPopupCard(context, label, fieldKey, currentValue),
              ),
              const SizedBox(height: 20),
              buildLabeledRow(
                label: "Father's Name",
                value: student.fathersName ?? "NA",
                fieldKey: "father_name",
                onEdit: null,
              ),
              const SizedBox(height: 20),
              buildLabeledRow(
                label: "Father's Email",
                value: student.email ?? "NA",
                fieldKey: "father_email",
                onEdit: (label, fieldKey, currentValue) =>
                    showEditPopupCard(context, label, fieldKey, currentValue),
              ),
              const SizedBox(height: 20),
              buildLabeledRow(
                label: "Mother's Name",
                value: student.mothersName ?? "NA",
                fieldKey: "mother_name",
                onEdit: null,
              ),
              const SizedBox(height: 20),
              buildLabeledRow(
                label: "Mother's Mail",
                value: student.mothersEmail ?? "NA",
                fieldKey: "mother_mail",
                onEdit: null,
              ),
              const SizedBox(height: 20),
              buildLabeledRow(
                label: "Father's Mobile No.",
                value: student.fathersMobile ?? "NA",
                fieldKey: "father_mobile",
                onEdit: (label, fieldKey, currentValue) =>
                    showEditPopupCard(context, label, fieldKey, currentValue),
              ),
              const SizedBox(height: 20),
              buildLabeledRow(
                label: "Mother's Mobile No.",
                value: student.mothersMobile ?? "NA",
                fieldKey: "mother_mobile",
                onEdit: (label, fieldKey, currentValue) =>
                    showEditPopupCard(context, label, fieldKey, currentValue),
              ),
              const SizedBox(height: 20),
              buildLabeledRow(
                label: "Guardian's Mobile No.",
                value: student.guardiansMobile ?? "NA",
                fieldKey: "father_mobile",
                onEdit: null,
              ),
              const SizedBox(height: 20),
              buildLabeledRow(
                label: "Father's Occupation",
                value: student.fathersOccupation ?? "NA",
                fieldKey: "father_occupation",
                onEdit: null,
              ),
              const SizedBox(height: 20),
              buildLabeledRow(
                label: "Mother's Occupation",
                value: student.mothersOccupation ?? "NA",
                fieldKey: "mother_occupation",
                onEdit: null,
              ),
              const SizedBox(height: 20),
              buildLabeledRow(
                label: "Parmanent Address",
                value: student.permanentAddress ?? "NA",
                fieldKey: "parmanent_Add",
                onEdit: null,
              ),
              const SizedBox(height: 20),
              buildLabeledRow(
                label: "Contact Address",
                value: student.contactAddress ?? "NA",
                fieldKey: "contact_Add",
                onEdit: (label, fieldKey, currentValue) =>
                    showEditPopupCard(context, label, fieldKey, currentValue),
              ),
            ],
          ),
        );
      }),
    );
  }

  void showEditPopupCard(
    BuildContext context,
    String label,
    String fieldKey,
    String currentValue,
  ) {
    final TextEditingController controller =
        TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit $label"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: "Enter new $label",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                String newValue = controller.text.trim();

                if (newValue.isNotEmpty) {
                  await profileController.updateProfile(fieldKey, newValue);
                  Navigator.of(context).pop();
                  await studentController.fetchStudentDetails();
                }
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }
}

// class StudentProfilePage extends StatelessWidget {
//   final StudentController studentController = Get.put(StudentController());
//
//   StudentProfilePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     studentController.fetchStudentDetails();
//
//     return Scaffold(
//       appBar: const CustomAppBar(
//         title: "Student Profile",
//         showBackButton: true,
//       ),
//       body: PullToRefreshWrapper(
//         onRefresh: () async {
//           await studentController.fetchStudentDetails();
//         },
//         child: Obx(() {
//           if (studentController.isLoading.value) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (studentController.student.value == null) {
//             return const Center(child: Text("No data available"));
//           }
//
//           final student = studentController.student.value!;
//
//           return SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Profile header
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   child: Row(
//                     children: [
//                       // Profile picture
//                       const CircleAvatar(
//                         radius: 30,
//                         backgroundImage:
//                             AssetImage("assets/images/profile_image.png"),
//                       ),
//                       const SizedBox(width: 16),
//                       // Profile name and email
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             student.name,
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             student.email,
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Divider
//                 Divider(
//                   height: 1,
//                   color: Colors.grey[300],
//                 ),
//                 // Profile details
//
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       buildInfoRow(context, "Age", student.age.toString()),
//                       buildDivider(),
//                       buildInfoRow(
//                           context,
//                           "DOB",
//                           DateFormat('dd-MM-yyyy').format(student.dateOfBirth
//                                   is String
//                               ? DateTime.parse(student.dateOfBirth as String)
//                               : student.dateOfBirth)),
//                       buildDivider(),
//                       buildInfoRow(context, "Contact", student.contactNo),
//                       buildDivider(),
//                       buildInfoRow(
//                           context, "Admission No", student.admissionNo),
//                       buildDivider(),
//                       buildInfoRow(
//                           context, "Father's Name", student.fathersName),
//                       buildDivider(),
//                       buildInfoRow(
//                           context, "Mother's name", student.mothersName),
//                       buildDivider(),
//                       buildInfoRow(context, "Address", student.contactAddress),
//                       buildDivider(),
//                       buildInfoRow(
//                           context, "Father's Number", student.fathersMobile),
//                       buildDivider(),
//                       buildInfoRow(
//                           context, "Mother's Number", student.mothersMobile),
//                       buildDivider(),
//                       buildInfoRow(context, "Blood Group", student.bloodGroup),
//                       buildDivider(),
//                       buildInfoRow(context, "Class", student.className),
//                       buildDivider(),
//                       const SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }
