import 'package:academyapp/utils/appTheme.dart';
import 'package:academyapp/views/fragments/bottombarFrag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../controllers/logincontroller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final LoginController loginController = Get.put(LoginController());

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true, // Ensure keyboard doesn't hide inputs
        body: Stack(
          children: [
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  'assets/logos/logonypunya.png',
                  width: screenWidth * 0.7,
                  height: screenWidth * 0.4,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutCubic,
              bottom: MediaQuery.of(context).viewInsets.bottom > 0
                  ? 10
                  : -30, // Adjust position when keyboard appears
              left: 0,
              right: 0,
              child: SlideTransition(
                position: _slideAnimation,
                child: Container(
                  height: screenHeight * 0.65,
                  width: screenWidth * 0.95,
                  padding: const EdgeInsets.all(20),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    // Allow scrolling when keyboard appears
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hi👋, Welcome",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "Nypunya Connect",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 20),

                        // Email Input
                        TextField(
                          controller: loginController.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "Mobile Number/Email",
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 16.0),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),

                        const SizedBox(height: 20),

                        // Password Input
                        Obx(() => TextField(
                              controller: loginController.passwordController,
                              obscureText:
                                  !loginController.isPasswordVisible.value,
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    loginController.isPasswordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                  onPressed:
                                      loginController.togglePasswordVisibility,
                                ),
                              ),
                              style: const TextStyle(color: Colors.white),
                            )),

                        const SizedBox(height: 10),

                        // Remember Me & Forgot Password Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() => Row(
                                  children: [
                                    Checkbox(
                                      value: loginController.rememberMe.value,
                                      onChanged: (bool? value) {
                                        loginController.rememberMe.value =
                                            value!;
                                      },
                                    ),
                                    const Text("Remember Me",
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                )),
                            TextButton(
                              onPressed: () {
                                Get.snackbar("Forgot Password",
                                    "Password request sent to your admin.",
                                    backgroundColor: Colors.orange,
                                    colorText: Colors.white);
                              },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              final email =
                                  loginController.emailController.text.trim();
                              final password = loginController
                                  .passwordController.text
                                  .trim();

                              if (email.isEmpty || password.isEmpty) {
                                Get.snackbar("Error",
                                    "Email and password cannot be empty.",
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white);
                                return;
                              }

                              loginController.saveEmail();
                              bool success = await loginController.login();
                              if (success) {
                                Get.off(() => BottomFragment());
                              } else {
                                Get.snackbar("Login Failed",
                                    "Invalid credentials or server error.",
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue.shade700,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'SIGN IN',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Transform.scale(
                                  scaleX: 1.5,
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
