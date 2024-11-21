import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 4,
      leading: showBackButton
          ? IconButton(
              onPressed: () {
                print("Navigating back: ${Navigator.canPop(context)}");
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ))
          : const Icon(
              Icons.person,
              color: Colors.black,
            ),
      title: Text(
        title,
        style: GoogleFonts.itim(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// appBar: CustomAppBar(
// title: 'My App',
// showBackButton: true,
// ),
