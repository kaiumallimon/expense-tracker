import 'package:shared_preferences/shared_preferences.dart';

class UserDataRepository {
  Future<Map<String, dynamic>> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String name = prefs.getString('name') ?? '';
    final String email = prefs.getString('email') ?? '';
    final String uid = prefs.getString('uid') ?? '';
    final String phone = prefs.getString('phone') ?? '';
    final String location = prefs.getString('location') ?? '';

    return {
      'name': name,
      'email': email,
      'uid': uid,
      'phone': phone,
      'location': location
    };
  }

  Future<String> getUserUID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid') ??
        ''; // Return empty string if UID is not set
  }
}
