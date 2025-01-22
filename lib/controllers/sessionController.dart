import 'package:academyapp/utils/apicServices.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SessionController extends GetxController {
  final GetStorage _storage = GetStorage();

  var isLoggedIn = false.obs;
  var accessToken = ''.obs;
  var refreshToken = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSession();
  }

  void _loadSession() {
    accessToken.value = _storage.read('access_token') ?? 'No Token';
    refreshToken.value = _storage.read('refresh_token') ?? 'No Refresh Token';
    isLoggedIn.value = accessToken.isNotEmpty;
  }

  // Function to login and store tokens
  void login(String newAccessToken, String newRefreshToken) {
    accessToken.value = newAccessToken;
    refreshToken.value = newRefreshToken;

    _storage.write('access_token', newAccessToken);
    _storage.write('refresh_token', newRefreshToken);

    isLoggedIn.value = true;
  }

  // Function to refresh the access token using the refresh token
  Future<void> refreshAccessToken() async {
    final response = await ApiService().refreshAccessToken(refreshToken.value);
    if (response != null) {
      accessToken.value = response['access_token'];
      _storage.write('access_token', accessToken.value);
    } else {
      // Handle token refresh failure (e.g., force logout)
      logout();
    }
  }

  // Function to check if the access token is expired (you can add your own logic for this)
  bool isAccessTokenExpired() {
    return false;
  }

  // Logout function
  void logout() {
    accessToken.value = '';
    refreshToken.value = '';
    _storage.remove('access_token');
    _storage.remove('refresh_token');
    isLoggedIn.value = false;
  }

  String getAccessToken() => accessToken.value;
  String getRefreshToken() => refreshToken.value;
}
