import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/studentData_Controller.dart';

class StudentProfilePage extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    studentController.fetchStudentDetails();

    return Scaffold(
      appBar: AppBar(
        title: Text("Student Profile"),
        actions: [
          // Notification bell icon
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      body: Obx(() {
        if (studentController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (studentController.student.value == null) {
          return Center(child: Text("No data available"));
        }

        final student = studentController.student.value!;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile header
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Profile picture
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage("assets/images/profile_image.png"),
                    ),
                    SizedBox(width: 16),
                    // Profile name and email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student.fathersName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          student.guardiansEmail,
                          style: TextStyle(
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
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("DOB: ${student.dateOfBirth.toLocal()}".split(' ')[0]),
                    SizedBox(height: 8),
                    Text("Contact: ${student.contactNo}"),
                    SizedBox(height: 8),
                    Text("Admission No: ${student.admissionNo}"),
                    SizedBox(height: 8),
                    Text("Guardian: ${student.guardiansEmail}"),
                    SizedBox(height: 8),
                    Text("Blood Group: ${student.bloodGroup}"),
                    SizedBox(height: 20),
                    // Privacy mode switch
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Privacy mode',
                          style: TextStyle(fontSize: 16),
                        ),
                        Switch(
                          value: false,
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
