import 'package:academyapp/controllers/sessionController.dart';
import 'package:academyapp/utils/routs.dart';
import 'package:academyapp/views/fragments/bottombarFrag.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle background messages
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  await GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sessionController = Get.put(SessionController());

    return GetMaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansElbasanTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute:
          sessionController.isLoggedIn.value ? '/bottomFragment' : '/login',
      // initialRoute: '/login',
      getPages: Approutes.routes, // Register routes here
    );
  }
}
