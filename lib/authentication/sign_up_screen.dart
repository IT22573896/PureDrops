import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscureText = true;

  // Custom function to show SnackBars
  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
    ));
  }

  // Validate form fields
  bool _validateInputs() {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String contact = _contactController.text.trim();
    String password = _passwordController.text.trim();

    if (name.isEmpty) {
      _showSnackBar('Please enter your name', isError: true);
      return false;
    }

    if (email.isEmpty) {
      _showSnackBar('Please enter your email', isError: true);
      return false;
    }

    if (!RegExp(r'^[\w-]+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$').hasMatch(email)) {
      _showSnackBar('Please enter a valid email', isError: true);
      return false;
    }

    if (contact.isEmpty) {
      _showSnackBar('Please enter your contact number', isError: true);
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

  Future<void> _signUpUser() async {
    if (!_validateInputs()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Create a new user in FirebaseAuth
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {
        String uid = user.uid;

        // Store user data in Firestore
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'name': _nameController.text.trim(),
          'email': user.email,
          'contact': _contactController.text.trim(),
        });

        // Show success message
        _showSnackBar('Sign-Up successful!');

        // Smooth transition to the profile page
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pushReplacementNamed(context, '/profile');
        });
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getFriendlyErrorMessage(e);
      _showSnackBar('Sign-Up failed: $errorMessage', isError: true);
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
      case 'email-already-in-use':
        return 'This email is already in use. Please try a different email.';
      case 'invalid-email':
        return 'Invalid email format. Please check your email.';
      case 'weak-password':
        return 'Your password is too weak. Please choose a stronger password.';
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
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Baloo 2',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF03045E),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  "Create your account",
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
                      "Enter your name",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontFamily: 'SpaceGrotesk'),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                // Name Input Field
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Full name",
                    prefixIcon:
                        const Icon(Icons.person, color: Color(0xFF03045E)),
                    filled: true,
                    fillColor: const Color(0xffCAF0F8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Email TextField
                const Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 15)),
                    Text(
                      "Full name",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontFamily: 'SpaceGrotesk'),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                // Email Input Field
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

                // Password TextField
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

                // Password InputField
                TextField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: "******",
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

                const SizedBox(height: 20),

                // Contact TextField
                const Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 15)),
                    Text(
                      "Enter your contact No.",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontFamily: 'SpaceGrotesk'),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                // Contact Input Field
                TextField(
                  controller: _contactController,
                  decoration: InputDecoration(
                    hintText: "0##-#######",
                    prefixIcon:
                        const Icon(Icons.phone, color: Color(0xFF03045E)),
                    filled: true,
                    fillColor: const Color(0xffCAF0F8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // Sign Up Button or Lottie Loader when loading
                _isLoading
                    ? Lottie.asset(
                        'assets/loading/water.json',
                        width: 100,
                        height: 100,
                      )
                    : ElevatedButton(
                        onPressed: _signUpUser,
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
                          "Sign Up",
                          style:
                              TextStyle(color: Color(0xffFFFFFF), fontSize: 16),
                        ),
                      ),
                const SizedBox(height: 20),
                // Already have an account? Sign In link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(fontFamily: 'RobotoMono'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signin');
                      },
                      child: const Text(
                        "Sign In",
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
