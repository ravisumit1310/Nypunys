import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  // Boolean to manage the visibility of Forgot Password form
  var showForgotPasswordForm = false.obs;

  // Function to toggle the form visibility
  void toggleForgotPasswordForm() {
    showForgotPasswordForm.value = !showForgotPasswordForm.value;
  }
}

class AuthController extends GetxController {
  RxBool isLogin = true.obs;

  void toggleForm() {
    isLogin.value = !isLogin.value;
  }
}
