import 'package:academyapp/views/pages/attendance.dart';
import 'package:academyapp/views/pages/authpage.dart';
import 'package:academyapp/views/pages/homePage.dart';
import 'package:academyapp/views/pages/profile.dart';
import 'package:academyapp/views/pages/work.dart';
import 'package:get/get.dart';

import '../views/pages/messages.dart';

class Approutes {
  static final routes = [
    GetPage(name: '/home', page: () => HomePage()),
    GetPage(name: '/login', page: () => ForgotPasswordPage()),
    GetPage(name: '/profile', page: () => ProfilePage()),
    GetPage(name: '/work', page: () => HomeWork()),
    GetPage(name: '/attendance', page: () => AttendancePage()),
    GetPage(name: '/report', page: () => MessagePage()),
  ];
}
