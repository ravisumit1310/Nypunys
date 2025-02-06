import 'package:academyapp/controllers/sessionController.dart';
import 'package:get/get.dart';
import 'package:academyapp/utils/apicServices.dart';

import '../views/fragments/bottombarFrag.dart';

class loginController extends GetxController {
  final sessionController = Get.find<SessionController>();

  Future<bool> login(String id, String password) async {
    final apiService = Get.find<ApiService>();
    var resp = await apiService.post('/student/login/', {
      'id': id,
      'password': password,
    });

    if (resp != null && resp.containsKey('access_token')) {
      sessionController.saveSession(
          resp['access_token'], resp['refresh_token']);
      return true;
    }
    return false;
  }
}
