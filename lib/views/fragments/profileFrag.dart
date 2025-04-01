import 'package:flutter/material.dart';

class UserInfoFragment extends StatelessWidget {
  final String userName;
  final String userClass;
  final String? section;
  final String? rollNo;
  final String profileImageUrl;
  final Color backgroundColor;
  final bool showSchoolName;

  const UserInfoFragment({
    Key? key,
    required this.userName,
    required this.userClass,
    this.section,
    this.rollNo,
    required this.profileImageUrl,
    required this.backgroundColor,
    this.showSchoolName = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.13,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // User Info Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // For HomePage (Purple BG)
                  ),
                ),
                Text(
                  'Class: $userClass' +
                      (section != null ? ' | Section: $section' : ''),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70, // Adjust based on background
                  ),
                ),
                if (rollNo != null)
                  Text(
                    'Roll No: $rollNo',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                if (showSchoolName)
                  const Text(
                    "Nypunya School Of Excellence, Dattagalli",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),
              ],
            ),
          ),

          // Profile Picture
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(profileImageUrl),
          ),
        ],
      ),
    );
  }
}
