import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferecesServices {
static String? token;
  Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString(TextStrings.authToken);
    return token;
  }
}
