import 'package:academyapp/controllers/logincontroller.dart';
import 'package:academyapp/controllers/sessionController.dart';
import 'package:academyapp/utils/apicServices.dart';
import 'package:academyapp/views/fragments/appbarFrag.dart';
import 'package:academyapp/views/fragments/bottombarFrag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatelessWidget {
  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());

  final SessionController sessionController = Get.put(SessionController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
              ),
            ),
          ),
          Positioned(
            top: height * 0.05,
            left: height * 0.07,
            child: Container(
              width: height * 0.3,
              child: Image.asset('assets/logos/logonypunya.png'),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: height * 0.25,
            height: height * 0.8,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF6487CA),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 5,
                    offset: Offset(5, 4),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          ),
          Positioned(
            left: 32,
            top: height * 0.27,
            child: Text(
              "Hi👋, Welcome",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: 31,
            top: height * 0.3,
            child: Text(
              "Nypunya Connect",
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
          ),
          Obx(() {
            if (!controller.showForgotPasswordForm.value) {
              // Sign-in form
              return Positioned(
                top: height * 0.45,
                left: 23,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mobile Number or Email',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 315,
                      height: 62,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: " ",
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Password',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 315,
                      height: 62,
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: " ",
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        obscureText: true, // Hide password input
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 30),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();

                            if (email.isEmpty || password.isEmpty) {
                              Get.snackbar(
                                "Error",
                                "Email and password cannot be empty.",
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                              return;
                            }

                            try {
                              final apiService = ApiService();
                              final response = await apiService.studentLogin(
                                  email, password);
                              if (response.containsKey('access_token')) {
                                // Store the token
                                final token = response['access_token'];
                                apiService.storage
                                    .write("student_token", token);

                                // Navigate to the next screen
                                Get.to(() => BottomFragment());
                              } else {
                                // Handle unexpected API response
                                Get.snackbar(
                                  "Error",
                                  "Unexpected response from server.",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              }
                            } catch (e) {
                              // Handle login failure
                              Get.snackbar(
                                "Login Failed",
                                e.toString(),
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            }
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                                Size(250, 50)), // Set fixed size
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Distribute items in Row
                            children: [
                              Text(
                                'Login',
                                style: GoogleFonts.robotoCondensed(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextButton(
                          onPressed: () {
                            controller.toggleForgotPasswordForm();
                          },
                          child: Text(
                            'Forgot Password',
                            style: GoogleFonts.robotoCondensed(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              final emailController = TextEditingController();
              final nameController = TextEditingController();
              final dobController = TextEditingController();

              // Function to pick a date from the calendar
              Future<void> _selectDate(BuildContext context) async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  dobController.text = "${pickedDate.toLocal()}"
                      .split(' ')[0]; // Update TextField
                }
              }

              // Forgot Password form
              return Positioned(
                top: height * 0.37,
                left: 23,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Mobile Number or Email',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 315,
                      height: 62,
                      // decoration: BoxDecoration(
                      //   border: Border(
                      //     bottom: BorderSide(color: Colors.white),
                      //   ),
                      // ),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        obscureText: true, // Hide password input
                        style: TextStyle(color: Colors.white), // Text color
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Student's Name",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 315,
                      height: 62,
                      // decoration: BoxDecoration(
                      //   border: Border(
                      //     bottom: BorderSide(color: Colors.white),
                      //   ),
                      // ),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        obscureText: true, // Hide password input
                        style: TextStyle(color: Colors.white), // Text color
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Student's DOB",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 315,
                      height: 62,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white),
                        ),
                      ),
                      child: TextField(
                        controller: dobController,
                        readOnly: true, // To prevent manual input
                        decoration: InputDecoration(
                          labelText: "Select Date of Birth",
                          labelStyle: TextStyle(color: Colors.white),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        style: TextStyle(color: Colors.white), // Text color
                        onTap: () {
                          _selectDate(context); // Open date picker on tap
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            print('Email/Phone-> ${emailController}');
                            print('Name-> ${nameController}');
                            print('DOB-> ${dobController}');
                            Get.to(() => BottomFragment());
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                                Size(250, 50)), // Broader width
                            backgroundColor: MaterialStateProperty.all(Colors
                                .white), // Transparent to let gradient show
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Same reduced radius
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Sign In',
                                style: GoogleFonts.robotoCondensed(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: height * 0.25,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        TextButton(
                          onPressed: () {
                            controller.toggleForgotPasswordForm();
                          },
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  controller.toggleForgotPasswordForm();
                                },
                                child: Text(
                                  'Login Page',
                                  style: GoogleFonts.robotoCondensed(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: height * 0.2),
                              Text(
                                'Help!',
                                style: GoogleFonts.robotoCondensed(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
