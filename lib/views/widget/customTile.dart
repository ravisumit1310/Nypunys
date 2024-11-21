import 'package:flutter/material.dart';

class CustomNeumorphicTile extends StatelessWidget {
  final String title;
  final Icon leadingIcon;
  final Icon trailingIcon;
  final VoidCallback onTap;

  const CustomNeumorphicTile({
    Key? key,
    required this.title,
    required this.leadingIcon,
    this.trailingIcon = const Icon(Icons.navigate_next, color: Colors.black),
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.white, // Light shadow
                offset: Offset(-1, -3),
                blurRadius: 3,
              ),
              BoxShadow(
                color: Colors.grey.shade600, // Dark shadow
                offset: Offset(0, 3),
                blurRadius: 5,
              ),
            ],
          ),
          child: ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
                boxShadow: [
                  BoxShadow(
                    color: Colors.white, // Light shadow
                    offset: Offset(-1, -3),
                    blurRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.grey.shade400, // Dark shadow
                    offset: Offset(1, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: leadingIcon,
            ),
            title: Text(
              title,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            trailing: trailingIcon,
          ),
        ),
      ),
    );
  }
}
