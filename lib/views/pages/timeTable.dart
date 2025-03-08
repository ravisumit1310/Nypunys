import 'package:academyapp/views/fragments/appbarFrag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/ttController.dart';
import '../widget/ttCard.dart';

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TimetableController timetableController =
        Get.put(TimetableController());

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Time Table",
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // **Day Selection Bar**
            Obx(() {
              if (timetableController.timetable.isEmpty) {
                return const Center(child: Text("No Days Available"));
              }

              final uniqueDays = timetableController.timetable
                  .map((item) => item.day)
                  .toSet()
                  .toList();

              return SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: uniqueDays.length,
                  itemBuilder: (context, index) {
                    final day = uniqueDays[index];
                    return GestureDetector(
                      onTap: () => timetableController.changeDay(day),
                      child: Obx(() => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              color:
                                  timetableController.selectedDay.value == day
                                      ? Colors.blue[100]
                                      : Colors.grey[200],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                day,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          )),
                    );
                  },
                ),
              );
            }),

            const SizedBox(height: 20),

            // **Timetable List**
            Expanded(
              child: Obx(() {
                if (timetableController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final filteredTimetable =
                    timetableController.getFilteredTimetable();

                if (filteredTimetable.isEmpty) {
                  return const Center(child: Text("No Timetable Found"));
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredTimetable.length,
                  itemBuilder: (context, index) {
                    final item = filteredTimetable[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TimetableCard(
                            title: "Period 1: ${item.period1}",
                            time: "8:00 AM - 9:00 AM"),
                        TimetableCard(
                            title: "Period 2: ${item.period2}",
                            time: "9:00 AM - 10:00 AM"),
                        TimetableCard(
                            title: "Period 3: ${item.period3}",
                            time: "10:00 AM - 11:00 AM"),
                        TimetableCard(
                            title: "Period 4: ${item.period4}",
                            time: "11:00 AM - 12:00 PM"),
                        TimetableCard(
                            title: "Period 5: ${item.period5}",
                            time: "12:00 PM - 1:00 PM"),
                        TimetableCard(
                            title: "Period 6: ${item.period6}",
                            time: "1:00 PM - 2:00 PM"),
                        if (item.period7 != null)
                          TimetableCard(
                              title: "Period 7: ${item.period7}",
                              time: "2:00 PM - 3:00 PM"),
                        if (item.period8 != null)
                          TimetableCard(
                              title: "Period 8: ${item.period8}",
                              time: "3:00 PM - 4:00 PM"),
                      ],
                    );
                  },
                );
              }),
            ),

            ElevatedButton(
              onPressed: () {},
              child: const Text('Exchange Request'),
            ),
          ],
        ),
      ),
    );
  }
}
