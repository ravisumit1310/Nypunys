import 'package:academyapp/views/widget/ttCard.dart';
import 'package:flutter/material.dart';

Widget buildAnimatedTimetableCard(String title, String time, int index) {
  return TweenAnimationBuilder(
    duration: Duration(milliseconds: 300 + (index * 100)),
    tween: Tween<double>(begin: 0, end: 1),
    curve: Curves.bounceInOut,
    builder: (context, value, child) {
      return Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, (1 - value) * 10),
          child: TimetableCard(title: title, time: time),
        ),
      );
    },
  );
}
