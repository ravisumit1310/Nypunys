import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  var tab = 0.obs;

  void changeIndex(int index) {
    tab.value = index;
  }
}
