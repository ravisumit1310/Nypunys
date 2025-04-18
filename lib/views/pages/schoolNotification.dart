import 'package:academyapp/utils/appTheme.dart';
import 'package:academyapp/views/fragments/appbarFrag.dart';
import 'package:academyapp/views/widget/refreshWrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/notificationController.dart';

import '../../models/notficationModel.dart';
import '../fragments/formatDate.dart';
import '../widget/BaseScreen.dart';
import '../widget/notificationDetails.dart';

class NotificationsPage extends StatelessWidget {
  NotificationsPage({super.key});

  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "School Notification",
      child: PullToRefreshWrapper(
        onRefresh: () async {
          await controller.fetchNotifications();
        },
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.notifications.isEmpty) {
            return const Center(child: Text("No notifications available"));
          }

          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: controller.notifications.length,
            itemBuilder: (context, index) {
              final notification = controller.notifications[index];
              return NotificationCardUI(notification: notification);
            },
          );
        }),
      ),
    );
  }
}

class NotificationCardUI extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCardUI({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => NotificationCard(notification: notification),
        );
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: Colors.blue,
                    size: 16.0,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    formatDate(notification.createdAt) ?? "",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 30,
                    child: Icon(Icons.notifications, color: Colors.white),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Text(
                      notification.message,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class NotificationsPage extends StatelessWidget {
//   NotificationsPage({super.key});
//
//   final NotificationController controller = Get.put(NotificationController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: const CustomAppBar(
//         title: "School Notification",
//         showBackButton: true,
//       ),
//       body: PullToRefreshWrapper(
//         onRefresh: () async {
//           await controller.fetchNotifications();
//         },
//         child: Obx(() {
//           if (controller.isLoading.value) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (controller.notifications.isEmpty) {
//             return const Center(child: Text("No notifications available"));
//           }
//
//           return ListView.builder(
//             physics: const AlwaysScrollableScrollPhysics(),
//             itemCount: controller.notifications.length,
//             itemBuilder: (context, index) {
//               final notification = controller.notifications[index];
//               return ListTile(
//                 leading: CircleAvatar(
//                   backgroundColor: Colors.blue,
//                   child: Text(notification.title[0]),
//                 ),
//                 title: Text(
//                   notification.title,
//                   style: const TextStyle(
//                       fontSize: 14, fontWeight: FontWeight.bold),
//                 ),
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) =>
//                         NotificationCard(notification: notification),
//                   );
//                 },
//               );
//             },
//           );
//         }),
//       ),
//     );
//   }
// }
