import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:academyapp/views/fragments/appbarFrag.dart';
import 'package:academyapp/views/widget/refreshWrapper.dart';
import '../../controllers/ttController.dart';
import '../widget/animatedTimeTableCards.dart';

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
      body: PullToRefreshWrapper(
        onRefresh: () async {
          await timetableController.fetchTimetable();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // **Day Selection Bar with Animation**
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
                        child: Obx(() => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 10),
                              decoration: BoxDecoration(
                                color:
                                    timetableController.selectedDay.value == day
                                        ? Colors.blue[300]
                                        : Colors.grey[300],
                                borderRadius: BorderRadius.circular(12.0),
                                boxShadow: [
                                  if (timetableController.selectedDay.value ==
                                      day)
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.4),
                                      blurRadius: 6,
                                      spreadRadius: 1,
                                    ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  day,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        timetableController.selectedDay.value ==
                                                day
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            )),
                      );
                    },
                  ),
                );
              }),

              const SizedBox(height: 20),

              // **Timetable List with Animated Fade-in**
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

                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: ListView.builder(
                      key: ValueKey(timetableController.selectedDay.value),
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredTimetable.length,
                      itemBuilder: (context, index) {
                        final item = filteredTimetable[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildAnimatedTimetableCard(
                                "Period 1: ${item.period1}",
                                "8:00 AM - 9:00 AM",
                                index),
                            buildAnimatedTimetableCard(
                                "Period 2: ${item.period2}",
                                "9:00 AM - 10:00 AM",
                                index),
                            buildAnimatedTimetableCard(
                                "Period 3: ${item.period3}",
                                "10:00 AM - 11:00 AM",
                                index),
                            buildAnimatedTimetableCard(
                                "Period 4: ${item.period4}",
                                "11:00 AM - 12:00 PM",
                                index),
                            buildAnimatedTimetableCard(
                                "Period 5: ${item.period5}",
                                "12:00 PM - 1:00 PM",
                                index),
                            buildAnimatedTimetableCard(
                                "Period 6: ${item.period6}",
                                "1:00 PM - 2:00 PM",
                                index),
                            if (item.period7 != null)
                              buildAnimatedTimetableCard(
                                  "Period 7: ${item.period7}",
                                  "2:00 PM - 3:00 PM",
                                  index),
                            if (item.period8 != null)
                              buildAnimatedTimetableCard(
                                  "Period 8: ${item.period8}",
                                  "3:00 PM - 4:00 PM",
                                  index),
                          ],
                        );
                      },
                    ),
                  );
                }),
              ),

              // **Exchange Request Button**
              ElevatedButton(
                onPressed: () {},
                child: const Text('Exchange Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
