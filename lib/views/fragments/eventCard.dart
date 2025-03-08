import 'package:flutter/material.dart';

import '../../models/event_model.dart';

Widget buildEventCard(Event event, int index) {
  List<Color> cardColors = [
    Colors.blue.shade300,
    Colors.pink.shade300,
    Colors.green.shade300,
    Colors.orange.shade300,
    Colors.purple.shade300,
  ];

  return Card(
    elevation: 4,
    margin: const EdgeInsets.symmetric(vertical: 6),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    color: cardColors[index % cardColors.length],
    child: ListTile(
      contentPadding: const EdgeInsets.all(10),
      title: Text(
        event.title,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      subtitle: Text(
        event.description,
        style: const TextStyle(fontSize: 14, color: Colors.white70),
      ),
      leading: const Icon(Icons.event, color: Colors.white),
    ),
  );
}
