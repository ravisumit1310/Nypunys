import 'package:academyapp/utils/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/ttController.dart';
import '../widget/BaseScreen.dart';
import '../widget/TimeTable_Card_widget.dart';

class TimetableScreen extends StatelessWidget {
  final TimetableController timetableController =
      Get.put(TimetableController());

  @override
  Widget build(BuildContext context) {
    double Lheight = MediaQuery.of(context).size.height;
    double Lwidth = MediaQuery.of(context).size.width;

    return BaseScreen(
      title: "Time Table",
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Obx(() {
                      if (timetableController.timetable.isEmpty) {
                        return const Center(child: Text("No Days Available"));
                      }

                      final uniqueDays = timetableController.timetable
                          .map((item) => item.day)
                          .toSet()
                          .toList();

                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 4),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.borderColor,
                            width: 1.5,
                          ),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection:
                              Axis.horizontal, // Enable horizontal scrolling
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.start, // Align to the left
                            children: uniqueDays.map((day) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: GestureDetector(
                                  onTap: () =>
                                      timetableController.changeDay(day),
                                  child: Obx(() => AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: timetableController
                                                      .selectedDay.value ==
                                                  day
                                              ? Colors.blue[300]
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Text(
                                          day,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: timetableController
                                                        .selectedDay.value ==
                                                    day
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      )),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 0),
                    Expanded(
                      child: Obx(() {
                        if (timetableController.isLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final filteredTimetable =
                            timetableController.getFilteredTimetable();
                        if (filteredTimetable.isEmpty) {
                          return const Center(
                              child: Text("No Timetable Found"));
                        }

                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: filteredTimetable.length,
                          itemBuilder: (context, index) {
                            final item = filteredTimetable[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildTimetableCard(
                                  "Period 1",
                                  item.period1,
                                  "8:00 AM - 9:00 AM",
                                  item.day,
                                ),
                                buildTimetableCard(
                                  "Period 2",
                                  item.period2,
                                  "9:00 AM - 10:00 AM",
                                  item.day,
                                ),
                                buildTimetableCard(
                                  "Period 3",
                                  item.period3,
                                  "10:00 AM - 11:00 AM",
                                  item.day,
                                ),
                                buildTimetableCard(
                                  "Period 4",
                                  item.period4,
                                  "11:00 AM - 12:00 PM",
                                  item.day,
                                ),
                                buildTimetableCard(
                                  "Period 5",
                                  item.period5,
                                  "12:00 PM - 1:00 PM",
                                  item.day,
                                ),
                                buildTimetableCard(
                                  "Period 6",
                                  item.period6,
                                  "1:00 PM - 2:00 PM",
                                  item.day,
                                ),
                                if (item.period7 != null)
                                  buildTimetableCard(
                                    "Period 7",
                                    item.period7,
                                    "2:00 PM - 3:00 PM",
                                    item.day,
                                  ),
                                if (item.period8 != null)
                                  buildTimetableCard(
                                    "Period 8",
                                    item.period8,
                                    "3:00 PM - 4:00 PM",
                                    item.day,
                                  ),
                              ],
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class TimetableScreen extends StatelessWidget {
//   const TimetableScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final TimetableController timetableController =
//         Get.put(TimetableController());
//
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16.0),
//             decoration: const BoxDecoration(
//               color: Colors.blue,
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(0),
//                 bottomRight: Radius.circular(0),
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 40),
//                 Row(
//                   children: [
//                     IconButton(
//                         onPressed: () {
//                           Get.back();
//                         },
//                         icon: const Icon(
//                           Icons.arrow_back_ios,
//                           color: AppColors.background,
//                         )),
//                     const Text(
//                       "Timetable",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(8.0),
//               clipBehavior: Clip.antiAlias,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     Obx(() {
//                       if (timetableController.timetable.isEmpty) {
//                         return const Center(child: Text("No Days Available"));
//                       }
//
//                       final uniqueDays = timetableController.timetable
//                           .map((item) => item.day)
//                           .toSet()
//                           .toList();
//
//                       return Container(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 8, horizontal: 4),
//                         decoration: BoxDecoration(
//                           color: AppColors.background,
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                             color: AppColors.borderColor,
//                             width: 1.5,
//                           ),
//                         ),
//                         child: SingleChildScrollView(
//                           scrollDirection:
//                               Axis.horizontal, // Enable horizontal scrolling
//                           child: Row(
//                             mainAxisAlignment:
//                                 MainAxisAlignment.start, // Align to the left
//                             children: uniqueDays.map((day) {
//                               return Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 4),
//                                 child: GestureDetector(
//                                   onTap: () =>
//                                       timetableController.changeDay(day),
//                                   child: Obx(() => AnimatedContainer(
//                                         duration:
//                                             const Duration(milliseconds: 300),
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 16, vertical: 8),
//                                         decoration: BoxDecoration(
//                                           color: timetableController
//                                                       .selectedDay.value ==
//                                                   day
//                                               ? Colors.blue[300]
//                                               : Colors.transparent,
//                                           borderRadius:
//                                               BorderRadius.circular(16),
//                                         ),
//                                         child: Text(
//                                           day,
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: timetableController
//                                                         .selectedDay.value ==
//                                                     day
//                                                 ? Colors.white
//                                                 : Colors.black,
//                                           ),
//                                         ),
//                                       )),
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       );
//                     }),
//                     const SizedBox(height: 0),
//                     Expanded(
//                       child: Obx(() {
//                         if (timetableController.isLoading.value) {
//                           return const Center(
//                               child: CircularProgressIndicator());
//                         }
//
//                         final filteredTimetable =
//                             timetableController.getFilteredTimetable();
//                         if (filteredTimetable.isEmpty) {
//                           return const Center(
//                               child: Text("No Timetable Found"));
//                         }
//
//                         return ListView.builder(
//                           physics: const BouncingScrollPhysics(),
//                           itemCount: filteredTimetable.length,
//                           itemBuilder: (context, index) {
//                             final item = filteredTimetable[index];
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 buildTimetableCard(
//                                   "Period 1",
//                                   item.period1,
//                                   "8:00 AM - 9:00 AM",
//                                   item.day,
//                                 ),
//                                 buildTimetableCard(
//                                   "Period 2",
//                                   item.period2,
//                                   "9:00 AM - 10:00 AM",
//                                   item.day,
//                                 ),
//                                 buildTimetableCard(
//                                   "Period 3",
//                                   item.period3,
//                                   "10:00 AM - 11:00 AM",
//                                   item.day,
//                                 ),
//                                 buildTimetableCard(
//                                   "Period 4",
//                                   item.period4,
//                                   "11:00 AM - 12:00 PM",
//                                   item.day,
//                                 ),
//                                 buildTimetableCard(
//                                   "Period 5",
//                                   item.period5,
//                                   "12:00 PM - 1:00 PM",
//                                   item.day,
//                                 ),
//                                 buildTimetableCard(
//                                   "Period 6",
//                                   item.period6,
//                                   "1:00 PM - 2:00 PM",
//                                   item.day,
//                                 ),
//                                 if (item.period7 != null)
//                                   buildTimetableCard(
//                                     "Period 7",
//                                     item.period7,
//                                     "2:00 PM - 3:00 PM",
//                                     item.day,
//                                   ),
//                                 if (item.period8 != null)
//                                   buildTimetableCard(
//                                     "Period 8",
//                                     item.period8,
//                                     "3:00 PM - 4:00 PM",
//                                     item.day,
//                                   ),
//                               ],
//                             );
//                           },
//                         );
//                       }),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildTimetableCard(
//       String period, String? subject, String time, String teacher) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: AppColors.background,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: AppColors.borderColor,
//           width: 1.5,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 6,
//             spreadRadius: 1,
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // **Subject Name (Top-Left)**
//           Text(
//             subject ?? "N/A",
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 4),
//
//           // **Time Duration**
//           Text(
//             time,
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.grey,
//             ),
//           ),
//
//           const SizedBox(height: 4),
//           Divider(
//             height: 2,
//           ),
//           const SizedBox(height: 4),
//
//           // **Bottom Row: Teacher Name (Left) | Period Number (Right)**
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 teacher,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               Text(
//                 period,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TimetableScreen extends StatelessWidget {
//   const TimetableScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final TimetableController timetableController =
//         Get.put(TimetableController());
//
//     return Scaffold(
//       appBar: const CustomAppBar(
//         title: "Time Table",
//         showBackButton: true,
//       ),
//       body: PullToRefreshWrapper(
//         onRefresh: () async {
//           await timetableController.fetchTimetable();
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Obx(() {
//                 if (timetableController.timetable.isEmpty) {
//                   return const Center(child: Text("No Days Available"));
//                 }
//
//                 final uniqueDays = timetableController.timetable
//                     .map((item) => item.day)
//                     .toSet()
//                     .toList();
//
//                 return SizedBox(
//                   height: 50,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: uniqueDays.length,
//                     itemBuilder: (context, index) {
//                       final day = uniqueDays[index];
//                       return GestureDetector(
//                         onTap: () => timetableController.changeDay(day),
//                         child: Obx(() => AnimatedContainer(
//                               duration: const Duration(milliseconds: 300),
//                               curve: Curves.easeInOut,
//                               margin:
//                                   const EdgeInsets.symmetric(horizontal: 4.0),
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 16.0, vertical: 10),
//                               decoration: BoxDecoration(
//                                 color:
//                                     timetableController.selectedDay.value == day
//                                         ? Colors.blue[300]
//                                         : Colors.grey[300],
//                                 borderRadius: BorderRadius.circular(12.0),
//                                 boxShadow: [
//                                   if (timetableController.selectedDay.value ==
//                                       day)
//                                     BoxShadow(
//                                       color: Colors.blue.withOpacity(0.4),
//                                       blurRadius: 6,
//                                       spreadRadius: 1,
//                                     ),
//                                 ],
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   day,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color:
//                                         timetableController.selectedDay.value ==
//                                                 day
//                                             ? Colors.white
//                                             : Colors.black,
//                                   ),
//                                 ),
//                               ),
//                             )),
//                       );
//                     },
//                   ),
//                 );
//               }),
//
//               const SizedBox(height: 20),
//
//               // **Timetable List with Animated Fade-in**
//               Expanded(
//                 child: Obx(() {
//                   if (timetableController.isLoading.value) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//
//                   final filteredTimetable =
//                       timetableController.getFilteredTimetable();
//
//                   if (filteredTimetable.isEmpty) {
//                     return const Center(child: Text("No Timetable Found"));
//                   }
//
//                   return AnimatedSwitcher(
//                     duration: const Duration(milliseconds: 500),
//                     transitionBuilder: (child, animation) {
//                       return FadeTransition(opacity: animation, child: child);
//                     },
//                     child: ListView.builder(
//                       key: ValueKey(timetableController.selectedDay.value),
//                       physics: const BouncingScrollPhysics(),
//                       itemCount: filteredTimetable.length,
//                       itemBuilder: (context, index) {
//                         final item = filteredTimetable[index];
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             buildAnimatedTimetableCard(
//                                 "Period 1: ${item.period1}",
//                                 "8:00 AM - 9:00 AM",
//                                 index),
//                             buildAnimatedTimetableCard(
//                                 "Period 2: ${item.period2}",
//                                 "9:00 AM - 10:00 AM",
//                                 index),
//                             buildAnimatedTimetableCard(
//                                 "Period 3: ${item.period3}",
//                                 "10:00 AM - 11:00 AM",
//                                 index),
//                             buildAnimatedTimetableCard(
//                                 "Period 4: ${item.period4}",
//                                 "11:00 AM - 12:00 PM",
//                                 index),
//                             buildAnimatedTimetableCard(
//                                 "Period 5: ${item.period5}",
//                                 "12:00 PM - 1:00 PM",
//                                 index),
//                             buildAnimatedTimetableCard(
//                                 "Period 6: ${item.period6}",
//                                 "1:00 PM - 2:00 PM",
//                                 index),
//                             if (item.period7 != null)
//                               buildAnimatedTimetableCard(
//                                   "Period 7: ${item.period7}",
//                                   "2:00 PM - 3:00 PM",
//                                   index),
//                             if (item.period8 != null)
//                               buildAnimatedTimetableCard(
//                                   "Period 8: ${item.period8}",
//                                   "3:00 PM - 4:00 PM",
//                                   index),
//                           ],
//                         );
//                       },
//                     ),
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
