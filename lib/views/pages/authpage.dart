import 'package:academyapp/views/fragments/bottombarFrag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/logincontroller.dart';

class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Center(
                child: Image.asset('assets/logos/logonypunya.png', width: 150)),
            SizedBox(height: 40),
            Text("Hi👋, Welcome",
                style: TextStyle(fontSize: 18, color: Colors.black)),
            Text("Nypunya Connect",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),

            // Email Input
            Text('Mobile Number or Email',
                style: TextStyle(fontSize: 12, color: Colors.black)),
            SizedBox(height: 10),
            TextField(
              controller: loginController.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email, color: Colors.blue),
                hintText: "Enter your email",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 20),

            // Password Input with Visibility Toggle
            Text('Password',
                style: TextStyle(fontSize: 12, color: Colors.black)),
            SizedBox(height: 10),
            Obx(() => TextField(
                  controller: loginController.passwordController,
                  obscureText: !loginController.isPasswordVisible.value,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.blue),
                    suffixIcon: IconButton(
                      icon: Icon(
                        loginController.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.blue,
                      ),
                      onPressed: loginController.togglePasswordVisibility,
                    ),
                    hintText: "Enter your password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )),
            SizedBox(height: 10),

            // Remember Me Checkbox
            Obx(() => Row(
                  children: [
                    Checkbox(
                      value: loginController.rememberMe.value,
                      onChanged: (bool? value) {
                        loginController.rememberMe.value = value!;
                      },
                    ),
                    Text("Remember Me"),
                  ],
                )),
            SizedBox(height: 20),

            // Login Button
            ElevatedButton(
              onPressed: () async {
                final email = loginController.emailController.text.trim();
                final password = loginController.passwordController.text.trim();

                if (email.isEmpty || password.isEmpty) {
                  Get.snackbar("Error", "Email and password cannot be empty.",
                      backgroundColor: Colors.red, colorText: Colors.white);
                  return;
                }

                loginController.saveEmail();

                bool success = await loginController.login();
                if (success) {
                  Get.off(() => BottomFragment());
                } else {
                  Get.snackbar(
                      "Login Failed", "Invalid credentials or server error.",
                      backgroundColor: Colors.red, colorText: Colors.white);
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text("Login",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            SizedBox(height: 10),

            // Forgot Password
            Center(
              child: TextButton(
                onPressed: () {
                  Get.snackbar(
                      "Forgot Password", "Password request sent to your admin.",
                      backgroundColor: Colors.orange, colorText: Colors.white);
                },
                child: Text('Forgot Password',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class LoginPage extends StatelessWidget {
//   final loginController authController = Get.put(loginController());
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   LoginPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset: true,
//       body: Stack(
//         children: [
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
//               ),
//             ),
//           ),
//           Positioned(
//             top: height * 0.05,
//             left: height * 0.07,
//             child: SizedBox(
//               width: height * 0.3,
//               child: Image.asset('assets/logos/logonypunya.png'),
//             ),
//           ),
//           Positioned(
//             left: 0,
//             right: 0,
//             top: height * 0.25,
//             height: height * 0.8,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: const Color(0xFF6487CA),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.25),
//                     blurRadius: 5,
//                     offset: const Offset(5, 4),
//                   ),
//                 ],
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             left: 32,
//             top: height * 0.27,
//             child: Text(
//               "Hi👋, Welcome",
//               style: TextStyle(fontSize: 18, color: Colors.white),
//             ),
//           ),
//           Positioned(
//             left: 31,
//             top: height * 0.3,
//             child: Text(
//               "Nypunya Connect",
//               style: TextStyle(fontSize: 28, color: Colors.white),
//             ),
//           ),
//           Positioned(
//             top: height * 0.45,
//             left: 23,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Mobile Number or Email',
//                     style: TextStyle(fontSize: 12, color: Colors.white)),
//                 SizedBox(height: 10),
//                 Container(
//                   width: 315,
//                   height: 62,
//                   child: TextField(
//                     controller: emailController,
//                     decoration: InputDecoration(
//                       hintText: " ",
//                       hintStyle: TextStyle(color: Colors.white),
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                       focusedBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.blue),
//                       ),
//                     ),
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 Text('Password',
//                     style: TextStyle(fontSize: 12, color: Colors.white)),
//                 SizedBox(height: 10),
//                 Container(
//                   width: 315,
//                   height: 62,
//                   child: TextField(
//                     controller: passwordController,
//                     decoration: InputDecoration(
//                       labelText: " ",
//                       labelStyle: TextStyle(color: Colors.white),
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                       focusedBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.blue),
//                       ),
//                     ),
//                     obscureText: true,
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 Column(
//                   children: [
//                     ElevatedButton(
//                       onPressed: () async {
//                         final email = emailController.text.trim();
//                         final password = passwordController.text.trim();
//
//                         if (email.isEmpty || password.isEmpty) {
//                           Get.snackbar(
//                             "Error",
//                             "Email and password cannot be empty.",
//                             backgroundColor: Colors.red,
//                             colorText: Colors.white,
//                           );
//                           return;
//                         }
//
//                         bool success =
//                             await authController.login(email, password);
//                         if (success) {
//                           Get.off(() => BottomFragment());
//                         } else {
//                           Get.snackbar(
//                             "Login Failed",
//                             "Invalid credentials or server error.",
//                             backgroundColor: Colors.red,
//                             colorText: Colors.white,
//                           );
//                         }
//                       },
//                       style: ButtonStyle(
//                         minimumSize:
//                             WidgetStateProperty.all(const Size(250, 50)),
//                         backgroundColor: WidgetStateProperty.all(Colors.white),
//                         shape: WidgetStateProperty.all(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Login',
//                             style: GoogleFonts.robotoCondensed(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const Icon(
//                             Icons.arrow_forward,
//                             color: Colors.blue,
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     TextButton(
//                       onPressed: () {
//                         Get.snackbar(
//                           "Forgot Password",
//                           "Password request sent to your admin.",
//                           backgroundColor: Colors.orange,
//                           colorText: Colors.white,
//                         );
//                       },
//                       child: Text(
//                         'Forgot Password',
//                         style: GoogleFonts.robotoCondensed(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
