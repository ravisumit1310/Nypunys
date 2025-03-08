import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:academyapp/models/event_model.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controllers/eventController.dart';
import '../fragments/eventCard.dart';

class EventsPage extends StatelessWidget {
  final EventController eventController = Get.put(EventController());

  EventsPage({super.key}) {
    eventController.fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("School Events Calendar"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Obx(() {
        Map<DateTime, List<Event>> eventsMap = {};
        for (var event in eventController.events) {
          DateTime eventDate =
              DateTime(event.date.year, event.date.month, event.date.day);
          eventsMap[eventDate] = eventsMap[eventDate] ?? [];
          eventsMap[eventDate]!.add(event);
        }

        return Column(
          children: [
            // Calendar Section
            Card(
              margin: const EdgeInsets.all(12),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: TableCalendar(
                  focusedDay: eventController.selectedDate.value,
                  firstDay: DateTime(2020),
                  lastDay: DateTime(2030),
                  selectedDayPredicate: (day) =>
                      isSameDay(day, eventController.selectedDate.value),
                  eventLoader: (day) => eventsMap[day] ?? [],
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.blue.shade300,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: BoxDecoration(
                      color: Colors.green.shade400,
                      shape: BoxShape.circle,
                    ),
                    defaultTextStyle: TextStyle(fontSize: 16),
                  ),
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    eventController.selectedDate.value = selectedDay;
                  },
                  onPageChanged: (focusedDay) {
                    eventController.selectedMonth.value = focusedDay;
                  },
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      if (events.isNotEmpty) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.green.shade700,
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ),
            ),

            // Holiday/Event List - Scrollable if overflow
            Expanded(
              child: Obx(() {
                DateTime currentMonth = eventController.selectedMonth.value;
                List<Event> selectedEvents =
                    eventController.getEventsForMonth(currentMonth);

                return selectedEvents.isEmpty
                    ? const Center(
                        child: Text(
                          "No events this month",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 8),
                          itemCount: selectedEvents.length,
                          itemBuilder: (context, index) {
                            Event event = selectedEvents[index];
                            return buildEventCard(event, index);
                          },
                        ),
                      );
              }),
            ),
          ],
        );
      }),
    );
  }
}
