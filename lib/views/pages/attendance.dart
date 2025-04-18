import 'package:academyapp/utils/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/attendance_Controller.dart';
import '../../models/attendance_Model.dart';
import '../widget/BaseScreen.dart';
import 'package:intl/intl.dart';

class AttendancePage extends StatelessWidget {
  AttendancePage();

  @override
  Widget build(BuildContext context) {
    final AttendanceController controller = Get.put(AttendanceController());

    return BaseScreen(
      title: "Attendance",
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final AttendanceModel? attendanceData = controller.attendanceData.value;
        if (attendanceData == null) {
          return Center(child: Text("No attendance data available"));
        }

        DateTime now = DateTime.now();
        String formattedMonth = DateFormat('MMMM yyyy').format(now);

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.chevron_left),
                  Text(
                    formattedMonth, // Dynamic Month
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
            SizedBox(height: 8.0),

            // 🔹 Calendar Grid
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 31, // Maximum days
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7, // 7 days a week
                childAspectRatio: 1.2,
              ),
              itemBuilder: (context, index) {
                String day = (index + 1).toString().padLeft(2, '0');
                String date =
                    "${now.year}-${now.month.toString().padLeft(2, '0')}-$day";

                Color bgColor = Colors.transparent;
                Color textColor = Colors.black;

                // 🟥 Mark Absent Days (Red)
                if (attendanceData.absentDates.contains(date)) {
                  bgColor = Colors.red[500]!;
                  textColor = Colors.white;
                }
                // 🟨 Mark Late Days (Yellow)
                else if (attendanceData.lateDates.contains(date)) {
                  bgColor = Colors.yellow[700]!;
                }

                return Center(
                  child: Container(
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      color: bgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(color: textColor, fontSize: 14.0),
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 12),

            // 🔹 Attendance Summary
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ❌ Absent Days
                      if (attendanceData.absentDates.isNotEmpty) ...[
                        Text("❌ Absent Days",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        ...attendanceData.absentDates
                            .map((date) => _buildAttendanceTile(
                                  date: date,
                                  status: "Absent",
                                  color: Colors.red,
                                  icon: Icons.cancel,
                                )),
                        Divider(),
                      ],

                      // ⚠️ Late Days
                      if (attendanceData.lateDates.isNotEmpty) ...[
                        Text("⚠️ Late Days",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        ...attendanceData.lateDates
                            .map((date) => _buildAttendanceTile(
                                  date: date,
                                  status: "Late",
                                  color: Colors.yellow[700]!,
                                  icon: Icons.access_time,
                                )),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
      showBackButton: false,
    );
  }

  // 🎨 Custom Styled Attendance Tile
  Widget _buildAttendanceTile({
    required String date,
    required String status,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // 🔹 Colored Left Strip
          Container(
            width: 6,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
            ),
          ),
          SizedBox(width: 12),

          // 🔹 Icon
          Icon(icon, color: color),

          SizedBox(width: 12),

          // 🔹 Text Info
          Expanded(
            child: Text(
              "$status on $date",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

// class AttendancePage extends StatelessWidget {
//   const AttendancePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: CustomAppBar(
//       //   title: "Attendance",
//       //   showBackButton: false,
//       // ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Attendance",
//                   style: TextStyle(
//                       fontWeight: FontWeight.w900,
//                       fontSize: 28,
//                       color: Colors.blue),
//                 ),
//                 Text("Please check attendance report of your child."),
//                 Row(
//                   children: [
//                     Icon(Icons.calendar_month_sharp),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text("21-Oct-2024 to 21-Nov-2024"),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Icon(Icons.personal_injury_outlined),
//                     Text("Regular")
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Divider(
//                   height: 2,
//                   color: Colors.grey,
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: 40,
//                       width: 40,
//                       decoration: BoxDecoration(
//                         color: Colors.blue, // Background color
//                         shape: BoxShape.circle,
//                       ),
//                       alignment: Alignment.center,
//                       child: Text(
//                         "G7", // Text inside the circle
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Krish Kumar",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 12),
//                         ),
//                         Text(
//                           "Attendance Summary : 2/2",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 10),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       width: 70,
//                     ),
//                     Container(
//                       height: 40,
//                       width: 80,
//                       decoration: BoxDecoration(
//                         color: Colors.purple, // Background color
//                         shape: BoxShape.rectangle,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       alignment: Alignment.center,
//                       child: Text(
//                         "100%", // Text inside the circle
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Divider(
//                   height: 2,
//                   color: Colors.grey,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//
//       // body: Center(
//       //   child: Image.asset('assets/images/erroricon.png'),
//       // ),
//     );
//   }
// }
