import 'package:Puredrops/authentication/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscureText = true;

  bool _isChecked = false;

  // Custom function to show SnackBars
  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
    ));
  }

  // Validate email and password fields
  bool _validateInputs() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty) {
      _showSnackBar('Please enter your email', isError: true);
      return false;
    }

    if (!RegExp(r'^[\w-]+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$').hasMatch(email)) {
      _showSnackBar('Please enter a valid email', isError: true);
      return false;
    }

    if (password.isEmpty) {
      _showSnackBar('Please enter your password', isError: true);
      return false;
    }

    if (password.length < 6) {
      _showSnackBar('Password must be at least 6 characters long',
          isError: true);
      return false;
    }

    return true;
  }

  Future<void> _signInUser() async {
    if (!_validateInputs()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Sign in the user with FirebaseAuth
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {
        String uid = user.uid;

        // Fetch user data from Firestore
        DocumentSnapshot userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        String name = userDoc['name'];
        String email = user.email ?? '';
        String contact = userDoc['contact'];

        // Save user details in SharedPreferences
        await saveUserLocally(name, email, contact);

        // Display success message
        _showSnackBar('Sign-In successful!');

        // Smooth transition to the profile page
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pushReplacementNamed(context, '/home');
        });
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getFriendlyErrorMessage(e);
      _showSnackBar('Sign-In failed: $errorMessage', isError: true);
    } catch (e) {
      _showSnackBar('An unexpected error occurred', isError: true);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Friendly error messages based on FirebaseAuthException codes
  String _getFriendlyErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Invalid email format. Please check your email.';
      case 'user-not-found':
        return 'No user found with this email. Please sign up first.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'user-disabled':
        return 'This account has been disabled. Contact support for help.';
      default:
        return 'An unknown error occurred. Please try again later.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDFEFF), // Light blue background
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Water drop icon
                Image.asset('assets/authentication/sublogo.png', width: 100),
                const SizedBox(height: 20),
                const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Baloo 2',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF03045E),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  "Welcome back!",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      fontFamily: 'Outfit'),
                ),

                const SizedBox(height: 45),

                // Name TextField
                const Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 15)),
                    Text(
                      "Enter your email",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontFamily: 'SpaceGrotesk'),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                // Email TextField
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "example@gmail.com",
                    prefixIcon:
                        const Icon(Icons.email, color: Color(0xFF03045E)),
                    filled: true,
                    fillColor: const Color(0xffCAF0F8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Name TextField
                const Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 15)),
                    Text(
                      "Enter your password",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontFamily: 'SpaceGrotesk'),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                // Password TextField
                TextField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    prefixIcon:
                        const Icon(Icons.lock, color: Color(0xFF03045E)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: const Color(0xFF03045E),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    filled: true,
                    fillColor: const Color(0xffCAF0F8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Remember me and Forgot Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          checkColor: const Color(
                              0xffFFFFFF), // Color of the check inside the box
                          activeColor: const Color(0xff03045E),
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value ?? false;
                            });
                          },
                        ),
                        const Text(
                          "Remember me",
                          style: TextStyle(
                              color: Colors.black, fontFamily: 'RobotoMono'),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle forgot password
                      },
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(
                            color: Color(
                              0xFF03045E,
                            ),
                            fontFamily: 'RobotoMono'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                // Sign In Button or Lottie Loader when loading
                _isLoading
                    ? Lottie.asset(
                        'assets/loading/water.json',
                        width: 100,
                        height: 100,
                      )
                    : ElevatedButton(
                        onPressed: _signInUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF03045E), // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 18),
                        ),
                        child: const Text(
                          "Sign In",
                          style:
                              TextStyle(color: Color(0xffFFFFFF), fontSize: 16),
                        ),
                      ),
                const SizedBox(height: 20),
                // Don't have an account? Register link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(fontFamily: 'RobotoMono'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Baloo 2',
                          color: Color(0xFF03045E),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
