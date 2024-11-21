import 'package:academyapp/utils/errorAnimation.dart';
import 'package:academyapp/views/fragments/appbarFrag.dart';
import 'package:academyapp/views/fragments/customtabFrag.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Message Page"),
        backgroundColor: Colors.blue,
      ),
      body: CustomTabFragment(
        tabTitles: ["Private Messages", "Group Messages"],
        tabContent: [
          // Content for Private Messages
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    // Header Section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Rounded Icon with Text
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
                        SizedBox(width: 10), // Space between icon and text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Grade - 7",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                "Parents teacher meeting - reminder #important",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines:
                                    2, // Ensures the text doesn't overflow
                              ),
                              Text(
                                "Jul 19, 2024 by Ritha",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.mail_outline_sharp,
                            size: 24, color: Colors.blue),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      height: 20,
                    ),
                    // Email Body Section
                    Container(
                      width: double.infinity,
                      height: 205,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white
                            .withOpacity(0.1), // Slightly lighter color
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          "Hello Parent,\n\nWe are writing to remind you about the upcoming Parents-Teachers meeting scheduled for Grade 7 students. "
                          "This meeting is an opportunity to discuss your child’s progress and address any concerns you might have.\n\n"
                          "📅 Date: July 19, 2024\n🕒 Time: 10:00 AM - 12:00 PM\n📍 Venue: School Auditorium\n\n"
                          "Looking forward to seeing you there!\n\nWarm Regards,\nRitha",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.5, // Line height for better readability
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content for Group Messages (Add Placeholder)
          Center(
            child: Text(
              "No Group Messages yet!",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
        ],
        tabBodyHeight: sheight * 0.4,
      ),
    );
  }
}

// class MessagePage extends StatelessWidget {
//   const MessagePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final sheight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text("Message Page"),
//         backgroundColor: Colors.blue,
//       ),
//       body: CustomTabFragment(
//         tabTitles: ["Private Messages", "Group Messages"],
//         tabContent: [
//           // Content for Private Messages
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               height: 120, // Adjusted for content
//               width: double.infinity, // Matches parent width
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 color: Colors.green,
//                 border: Border.all(color: Colors.black87),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Icon(Icons.person, size: 40, color: Colors.white),
//                     SizedBox(width: 10), // Space between icon and text
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Grade - 7",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                               color: Colors.white,
//                             ),
//                           ),
//                           Text(
//                             "Parents teacher meeting - reminder #important",
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.white70,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 2, // Ensures the text doesn't overflow
//                           ),
//                           Text(
//                             "Jul 19, 2024 by Ritha",
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.white54,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Icon(Icons.mail_outline_sharp,
//                         size: 24, color: Colors.white),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
