import 'package:academyapp/views/fragments/appbarFrag.dart';
import 'package:flutter/material.dart';

class ProfileFragWidget extends StatelessWidget {
  const ProfileFragWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile section'),
    );
  }
}
