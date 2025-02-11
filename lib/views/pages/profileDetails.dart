import 'package:academyapp/views/fragments/appbarFrag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/studentData_Controller.dart';
import '../fragments/columnFormat.dart';

class StudentProfilePage extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    studentController.fetchStudentDetails();

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Student Profile",
        showBackButton: true,
      ),
      body: Obx(() {
        if (studentController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (studentController.student.value == null) {
          return const Center(child: Text("No data available"));
        }

        final student = studentController.student.value!;

        return SingleChildScrollView(
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
                    buildInfoRow("Age", student.age.toString()),
                    buildDivider(),
                    buildInfoRow(
                        "DOB",
                        DateFormat('dd-MM-yyyy').format(
                            student.dateOfBirth is String
                                ? DateTime.parse(student.dateOfBirth as String)
                                : student.dateOfBirth)),
                    buildDivider(),
                    buildInfoRow("Contact", student.contactNo),
                    buildDivider(),
                    buildInfoRow("Admission No", student.admissionNo),
                    buildDivider(),
                    buildInfoRow("Father's Name", student.fathersName),
                    buildDivider(),
                    buildInfoRow("Mother's name", student.mothersName),
                    buildDivider(),
                    buildInfoRow("Address", student.contactAddress),
                    buildDivider(),
                    buildInfoRow("Father's Number", student.fathersMobile),
                    buildDivider(),
                    buildInfoRow("Mother's Number", student.mothersMobile),
                    buildDivider(),
                    buildInfoRow("Blood Group", student.bloodGroup),
                    buildDivider(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // Container(
              //   padding: EdgeInsets.all(16),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "DOB: ${DateFormat('dd-MM-yyyy').format(student.dateOfBirth is String ? DateTime.parse(student.dateOfBirth as String) : student.dateOfBirth)}",
              //       ),
              //       SizedBox(height: 8),
              //       Divider(
              //         height: 2,
              //       ),
              //       SizedBox(height: 8),
              //       Text("Contact: ${student.contactNo}"),
              //       SizedBox(height: 8),
              //       Divider(
              //         height: 2,
              //       ),
              //       SizedBox(height: 8),
              //       Text("Admission No: ${student.admissionNo}"),
              //       SizedBox(height: 8),
              //       Divider(
              //         height: 2,
              //       ),
              //       SizedBox(height: 8),
              //       Text("Guardian: ${student.guardiansEmail}"),
              //       SizedBox(height: 8),
              //       Divider(
              //         height: 2,
              //       ),
              //       SizedBox(height: 8),
              //       Text("Blood Group: ${student.bloodGroup}"),
              //       SizedBox(height: 8),
              //       Divider(
              //         height: 2,
              //       ),
              //       SizedBox(height: 20),
              //       // Privacy mode switch
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text(
              //             'Privacy mode',
              //             style: TextStyle(fontSize: 16),
              //           ),
              //           Switch(
              //             value: false,
              //             onChanged: (value) {},
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        );
      }),
    );
  }
}

// class StudentProfilePage extends StatelessWidget {
//   final StudentController studentController = Get.put(StudentController());
//
//   @override
//   Widget build(BuildContext context) {
//     studentController.fetchStudentDetails();
//
//     return Scaffold(
//       appBar: AppBar(title: Text("Student Profile")),
//       body: Obx(() {
//         if (studentController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }
//
//         if (studentController.student.value == null) {
//           return Center(child: Text("No data available"));
//         }
//
//         final student = studentController.student.value!;
//
//         return ListView(
//           padding: EdgeInsets.all(16),
//           children: [
//             Text("Name: ${student.fathersName}",
//                 style: TextStyle(fontSize: 18)),
//             Text("DOB: ${student.dateOfBirth.toLocal()}".split(' ')[0]),
//             Text("Contact: ${student.contactNo}"),
//             Text("Admission No: ${student.admissionNo}"),
//             Text("Guardian: ${student.guardiansEmail}"),
//             Text("Blood Group: ${student.bloodGroup}"),
//           ],
//         );
//       }),
//     );
//   }
// }
