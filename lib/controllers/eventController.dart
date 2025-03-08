import 'dart:convert';
import 'package:academyapp/models/event_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/apicServices.dart';

class EventController extends GetxController {
  var events = <Event>[].obs;
  var selectedDate = DateTime.now().obs;
  var selectedMonth = DateTime.now().obs;

  Future<void> fetchEvents() async {
    try {
      final apiService = Get.find<ApiService>();
      final response = await apiService.get("/events/events/");

      print("🚀 API Raw Response: $response");

      if (response == null) {
        print("❌ API returned null. Check the API service or endpoint.");
        return;
      }

      if (response is List) {
        // ✅ API returned a List, so directly parse it
        events.value = response.map((event) => Event.fromJson(event)).toList();
      } else if (response is Map<String, dynamic> &&
          response.containsKey("data")) {
        // ✅ Handle case where API returns a map with a "data" key
        List<dynamic> data = response["data"];
        events.value = data.map((event) => Event.fromJson(event)).toList();
      } else {
        print("❌ Error: Unexpected response type: ${response.runtimeType}");
      }
    } catch (e) {
      print("❌ Error fetching events: $e");
    }
  }

  List<Event> getEventsForMonth(DateTime month) {
    return events
        .where((event) =>
            event.date.year == month.year && event.date.month == month.month)
        .toList();
  }
}
