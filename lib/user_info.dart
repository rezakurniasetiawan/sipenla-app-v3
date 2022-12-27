import 'package:shared_preferences/shared_preferences.dart';

// get passwordlogin
Future<String> getPhotoUser() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString('photoUser') ?? '';
}
