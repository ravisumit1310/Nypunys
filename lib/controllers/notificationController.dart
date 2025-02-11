import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/notficationModel.dart';
import '../utils/apicServices.dart';

class NotificationController extends GetxController {
  var notifications = <NotificationModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading(true);
      final apiService = Get.find<ApiService>();

      final response = await apiService.get("/student/notifications/");
      print("Raw API Response: $response");

      if (response is Map<String, dynamic> &&
          response.containsKey("notifications")) {
        final List<dynamic> notificationsList = response["notifications"];

        notifications.value = notificationsList
            .map((json) => NotificationModel.fromJson(json))
            .toList();
      } else {
        Get.snackbar("Error", "Unexpected response format.");
      }
    } catch (e, stackTrace) {
      print("Error fetching notifications: $e");
      print(stackTrace);
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading(false);
    }
  }
}
