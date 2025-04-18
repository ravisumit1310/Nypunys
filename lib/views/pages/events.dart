import 'package:academyapp/utils/appTheme.dart';
import 'package:academyapp/views/widget/BaseScreen.dart';
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
    return BaseScreen(
        title: "Events",
        child: Obx(() {
          Map<DateTime, List<Event>> eventsMap = {};
          for (var event in eventController.events) {
            DateTime eventDate =
                DateTime(event.date.year, event.date.month, event.date.day);
            eventsMap[eventDate] = eventsMap[eventDate] ?? [];
            eventsMap[eventDate]!.add(event);
          }

          return Column(
            children: [
              Card(
                margin: const EdgeInsets.all(12),
                elevation: 0,
                color: Colors.transparent,
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
                        color: AppColors.green,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                      markerDecoration: BoxDecoration(
                        color: Colors.green.shade400,
                        shape: BoxShape.circle,
                      ),
                      cellMargin: EdgeInsets.zero,
                      tableBorder: TableBorder.all(
                        color: Colors.transparent,
                        width: 0,
                      ),
                      defaultTextStyle: const TextStyle(fontSize: 16),
                    ),
                    headerStyle: const HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                      titleTextStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    onDaySelected: (selectedDay, focusedDay) {
                      eventController.selectedDate.value = selectedDay;
                    },
                    onPageChanged: (focusedDay) {
                      eventController.selectedMonth.value = focusedDay;
                    },
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, date, _) {
                        DateTime normalizedDate =
                            DateTime(date.year, date.month, date.day);
                        if (eventsMap.containsKey(normalizedDate)) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${date.day}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                        return null; // fallback to default
                      },
                      markerBuilder: (context, date, events) {
                        if (events.isNotEmpty) {
                          return Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: 5,
                              height: 5,
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
        }));
  }
}
