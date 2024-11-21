import 'package:academyapp/views/fragments/appbarFrag.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheingt = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Student Profile",
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: swidth,
          padding: EdgeInsets.only(top: 5, left: 0, right: 0, bottom: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //this is the icon and the name roll thing
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Center(
                        child: const Image(
                          image: AssetImage('assets/images/id_image.jpg'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Name of Child",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.grey,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    "Roll no - 21",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Class - VI 'C'",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(height: 10),
                ],
              ),

              //This is the list tiles of profile section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    child: Icon(
                      Icons.person,
                      color: Colors.purple,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                  ),
                  title: Text("Parents Section"),
                  trailing: Icon(
                    Icons.navigate_next,
                    color: Colors.black,
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey.shade300,
              ),

              //Grades
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    child: Icon(
                      Icons.file_present_rounded,
                      color: Colors.purple,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                  ),
                  title: Text("School Grades"),
                  trailing: Icon(
                    Icons.navigate_next,
                    color: Colors.black,
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey.shade300,
              ),

              //notification
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    child: Icon(
                      Icons.notification_add,
                      color: Colors.purple,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                  ),
                  title: Text("School Notifications"),
                  trailing: Icon(
                    Icons.navigate_next,
                    color: Colors.black,
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey.shade300,
              ),

              //Help
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    child: Icon(
                      Icons.help,
                      color: Colors.purple,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                  ),
                  title: Text("Need Help!"),
                  trailing: Icon(
                    Icons.navigate_next,
                    color: Colors.black,
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey.shade300,
              ),

              //Logout
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    child: Icon(
                      Icons.logout,
                      color: Colors.purple,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                  ),
                  title: Text("LogOut"),
                  trailing: Icon(
                    Icons.navigate_next,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
