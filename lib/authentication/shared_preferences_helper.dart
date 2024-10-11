import 'package:shared_preferences/shared_preferences.dart';

// Save user details in SharedPreferences
Future<void> saveUserLocally(String name, String email, String contact) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('name', name);
  await prefs.setString('email', email);
  await prefs.setString('contact', contact);
}

// Retrieve user details from SharedPreferences
Future<Map<String, String?>> getUserDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? name = prefs.getString('name');
  String? email = prefs.getString('email');
  String? contact = prefs.getString('contact');
  return {'name': name, 'email': email, 'contact': contact};
}

// Check if user is logged in
Future<bool> isUserLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('email'); // Check if email exists in prefs
}

// Clear user data (for logging out)
Future<void> clearUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
