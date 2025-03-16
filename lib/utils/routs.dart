import 'package:academyapp/views/fragments/bottombarFrag.dart';
import 'package:academyapp/views/pages/attendance.dart';
import 'package:academyapp/views/pages/authpage.dart';
import 'package:academyapp/views/pages/homePage.dart';
import 'package:academyapp/views/pages/profile.dart';
import 'package:get/get.dart';

import '../views/pages/events.dart';
import '../views/pages/examReport.dart';
import '../views/pages/homeworkAndTasks.dart';
import '../views/pages/messages.dart';
import '../views/pages/profileDetails.dart';
import '../views/pages/schoolNotification.dart';
import '../views/pages/timeTable.dart';

class Approutes {
  static final routes = [
    GetPage(name: '/home', page: () => HomePage()),
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(name: '/profile', page: () => ProfilePage()),
    GetPage(name: '/attendance', page: () => const AttendancePage()),
    GetPage(name: '/report', page: () => const MessagePage()),
    GetPage(name: '/bottomFragment', page: () => BottomFragment()),
    GetPage(name: '/studentDetails', page: () => StudentProfilePage()),
    GetPage(name: '/schoolNotification', page: () => NotificationsPage()),
    GetPage(name: '/events', page: () => EventsPage()),
    GetPage(name: '/tt', page: () => const TimetableScreen()),
    GetPage(name: '/results', page: () => ExamResultsScreen()),
    GetPage(name: '/homework', page: () => HomeworkRankingPage()),
  ];
}
