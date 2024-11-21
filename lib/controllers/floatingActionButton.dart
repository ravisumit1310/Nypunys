import 'package:get/get.dart';

class FloatingActionController extends GetxController {
  // This boolean will control whether the additional buttons are shown or not
  var isExpanded = false.obs;

  // Method to toggle the expanded state
  void toggle() {
    isExpanded.value = !isExpanded.value;
  }
}
