import 'package:academyapp/views/fragments/appbarFrag.dart';
import 'package:flutter/material.dart';

class Quiz extends StatelessWidget {
  const Quiz({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Quizes",
        showBackButton: true,
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/images/erroricon.png'),
            Text(
              "No Quizes yet!!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
