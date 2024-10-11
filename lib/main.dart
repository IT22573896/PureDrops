import 'package:Puredrops/authentication/auth_check_screen.dart';
import 'package:Puredrops/authentication/profile_screen.dart';
import 'package:Puredrops/authentication/sign_in_screen.dart';
import 'package:Puredrops/authentication/sign_up_screen.dart';
import 'package:Puredrops/consts.dart';
import 'package:Puredrops/get_started_screen.dart';
import 'package:Puredrops/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() async {
  Gemini.init(apiKey: GEMINI_API_KEY);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PureDrops',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AuthCheckScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/start': (context) => const GetStartedScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/signin': (context) => const SignInScreen(),
        '/profile': (context) => const ProfileScreen()
      },
    );
  }
}
