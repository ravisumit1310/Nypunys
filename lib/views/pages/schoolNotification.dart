import 'package:academyapp/views/fragments/appbarFrag.dart';
import 'package:academyapp/views/widget/refreshWrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/notificationController.dart';

import '../widget/notificationDetails.dart';

class NotificationsPage extends StatelessWidget {
  NotificationsPage({super.key});

  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const CustomAppBar(
        title: "School Notification",
        showBackButton: true,
      ),
      body: PullToRefreshWrapper(
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
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(notification.title[0]),
                ),
                title: Text(
                  notification.title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        NotificationCard(notification: notification),
                  );
                },
              );
            },
          );
        }),
      ),
    );
  }
}
