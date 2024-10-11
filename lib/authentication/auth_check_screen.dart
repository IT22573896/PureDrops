import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'shared_preferences_helper.dart';

class AuthCheckScreen extends StatefulWidget {
  const AuthCheckScreen({super.key});

  @override
  State<AuthCheckScreen> createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends State<AuthCheckScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    bool isLoggedIn = await isUserLoggedIn();
    if (isLoggedIn) {
      // Navigate to profile or home screen if user is logged in
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Navigate to sign-in screen if user is not logged in
      Navigator.pushReplacementNamed(context, '/start');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: Lottie.asset(
          'assets/loading/water.json',
          width: 150,
          height: 150,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
