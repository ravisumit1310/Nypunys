import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SessionController extends GetxController {
  final _storage = GetStorage();
  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    isLoggedIn.value = _storage.hasData('access_token');
  }

  void saveSession(String accessToken, String refreshToken) {
    _storage.write('access_token', accessToken);
    _storage.write('refresh_token', refreshToken);
    isLoggedIn.value = true;
  }

  String? get accessToken => _storage.read('access_token');
  String? get refreshToken => _storage.read('refresh_token');

  void logout() {
    _storage.erase();
    isLoggedIn.value = false;
  }
}
