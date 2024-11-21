import 'package:academyapp/utils/routs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansElbasanTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: '/login', // Set initial route
      getPages: Approutes.routes, // Register routes here
    );
  }
}
