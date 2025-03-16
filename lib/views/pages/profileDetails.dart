import 'package:academyapp/views/fragments/appbarFrag.dart';
import 'package:academyapp/views/widget/refreshWrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/studentData_Controller.dart';
import '../fragments/columnFormat.dart';

class StudentProfilePage extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());

  StudentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    studentController.fetchStudentDetails();

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Student Profile",
        showBackButton: true,
      ),
      body: PullToRefreshWrapper(
        onRefresh: () async {
          await studentController.fetchStudentDetails();
        },
        child: Obx(() {
          if (studentController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (studentController.student.value == null) {
            return const Center(child: Text("No data available"));
          }

          final student = studentController.student.value!;

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile header
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Profile picture
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage("assets/images/profile_image.png"),
                      ),
                      const SizedBox(width: 16),
                      // Profile name and email
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            student.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            student.email,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Divider
                Divider(
                  height: 1,
                  color: Colors.grey[300],
                ),
                // Profile details

                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildInfoRow(context, "Age", student.age.toString()),
                      buildDivider(),
                      buildInfoRow(
                          context,
                          "DOB",
                          DateFormat('dd-MM-yyyy').format(student.dateOfBirth
                                  is String
                              ? DateTime.parse(student.dateOfBirth as String)
                              : student.dateOfBirth)),
                      buildDivider(),
                      buildInfoRow(context, "Contact", student.contactNo),
                      buildDivider(),
                      buildInfoRow(
                          context, "Admission No", student.admissionNo),
                      buildDivider(),
                      buildInfoRow(
                          context, "Father's Name", student.fathersName),
                      buildDivider(),
                      buildInfoRow(
                          context, "Mother's name", student.mothersName),
                      buildDivider(),
                      buildInfoRow(context, "Address", student.contactAddress),
                      buildDivider(),
                      buildInfoRow(
                          context, "Father's Number", student.fathersMobile),
                      buildDivider(),
                      buildInfoRow(
                          context, "Mother's Number", student.mothersMobile),
                      buildDivider(),
                      buildInfoRow(context, "Blood Group", student.bloodGroup),
                      buildDivider(),
                      buildInfoRow(context, "Class", student.className),
                      buildDivider(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
