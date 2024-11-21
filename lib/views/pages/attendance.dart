import 'package:academyapp/views/fragments/appbarFrag.dart';
import 'package:flutter/material.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Attendance",
        showBackButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Attendance",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                      color: Colors.blue),
                ),
                Text("Please check attendance report of your child."),
                Row(
                  children: [
                    Icon(Icons.calendar_month_sharp),
                    SizedBox(
                      width: 10,
                    ),
                    Text("21-Oct-2024 to 21-Nov-2024"),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.personal_injury_outlined),
                    Text("Regular")
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue, // Background color
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "G7", // Text inside the circle
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Krish Kumar",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        Text(
                          "Attendance Summary : 2/2",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.purple, // Background color
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "100%", // Text inside the circle
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 2,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),

      // body: Center(
      //   child: Image.asset('assets/images/erroricon.png'),
      // ),
    );
  }
}
