import 'package:academyapp/controllers/sessionController.dart';
import 'package:academyapp/utils/apicServices.dart';
import 'package:academyapp/utils/routs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  Get.put(SessionController());
  Get.put(ApiService(Get.find<SessionController>()));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sessionController = Get.find<SessionController>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false, // ✅ Removes debug banner
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansElbasanTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute:
          sessionController.isLoggedIn.value ? '/bottomFragment' : '/login',
      getPages: Approutes.routes, // Register routes here
    );
  }
}
