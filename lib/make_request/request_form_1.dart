import 'package:Puredrops/all_donations/map_sample.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Puredrops/make_request/request_form_2.dart';
import 'package:Puredrops/custom_navigation_bar.dart';
import 'package:Puredrops/settings_screen.dart';
import 'package:Puredrops/home_screen.dart';
import 'package:Puredrops/authentication/profile_screen.dart';
import 'package:Puredrops/donation_screen.dart';

class RequestForm1 extends StatefulWidget {
  const RequestForm1({super.key});

  @override
  _RequestForm1State createState() => _RequestForm1State();
}

class _RequestForm1State extends State<RequestForm1> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Handle navigation based on selected index
      switch (index) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DonationScreen()),
          );
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MapSample()),
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
          break;
      }
    });
  }

  final _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final RegExp emailRegExp =
      RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+$');
  final RegExp contactRegExp = RegExp(r'^[0-9]{10}$');
  String _waterType = 'Drinking'; // Default value for dropdown

  User? currentUser; // To store the current logged-in user

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  // Method to check if the user is logged in
  void _checkAuthentication() async {
    currentUser = _auth.currentUser;
    if (currentUser == null) {
      // If no user is logged in, navigate to the login screen
      Navigator.pushReplacementNamed(context, '/start');
    }
  }

  // Custom function to show SnackBars

  // Method to save form data to Firestore
  Future<void> _saveForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Add the data to Firestore, associated with the current user
        await _firestore.collection('requests').add({
          'uid': currentUser?.uid, // Associate request with user ID
          'name': _nameController.text,
          'email': _emailController.text,
          'contact': _contactController.text,
          'address': _addressController.text,
          'waterType': _waterType,
          'timestamp': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Request submitted successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting request: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image (You can modify this based on your needs)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Profile_Screen.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Overlay with widgets
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row with back and notifications button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(
                              context); // Navigate back to the previous screen
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xff90E0EF),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Color(0xFF02055A),
                            size: 24,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Implement navigation to Notifications screen
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.notifications,
                            color: Color(0xFF02055A),
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Title and subtitle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Make Request ',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Baloo 2',
                              color: Color(0xFF000000),
                            ),
                          ),
                          // Sub title
                          Padding(
                            padding: EdgeInsets.only(top: 1),
                            child: Text(
                              'Fill out the form to submit your clean \nwater request',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Outfit',
                                color: Color(0xFF757575),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 7),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SettingsScreen(),
                              ),
                            ); // Navigate to Settings screen
                          },
                          child: Transform.translate(
                            offset: const Offset(
                                0, -10), // Move the icon 10 pixels up
                            child: const Icon(
                              Icons.settings,
                              color: Colors.black,
                              size: 36,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Form section
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                hintText: "Enter your name",
                                prefixIcon: const Icon(Icons.person,
                                    color: Color(0xFF03045E)),
                                filled: true,
                                fillColor: const Color(0xffCAF0F8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText:
                                    "Enter your email", // Optional, if you want a hint text
                                prefixIcon: const Icon(Icons.email,
                                    color: Color(
                                        0xFF03045E)), // Optional icon for email
                                filled: true,
                                fillColor: const Color(0xffCAF0F8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                } else if (!emailRegExp.hasMatch(value)) {
                                  return 'Please enter a valid email address\n (e.g., someone@gmail.com)';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _contactController,
                              decoration: InputDecoration(
                                hintText:
                                    "Enter your contact no", // Optional, if you want a hint text
                                prefixIcon: const Icon(Icons.phone,
                                    color: Color(
                                        0xFF03045E)), // Optional icon for email
                                filled: true,
                                fillColor: const Color(0xffCAF0F8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your contact number';
                                } else if (!contactRegExp.hasMatch(value)) {
                                  return 'Please enter a valid 10-digit contact number';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _addressController,
                              decoration: InputDecoration(
                                hintText:
                                    "Enter your address", // Optional, if you want a hint text
                                prefixIcon: const Icon(Icons.location_city,
                                    color: Color(
                                        0xFF03045E)), // Optional icon for email
                                filled: true,
                                fillColor: const Color(0xffCAF0F8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            DropdownButtonFormField<String>(
                              value: _waterType,
                              decoration: InputDecoration(
                                hintText:
                                    "Enter type of water", // Optional, if you want a hint text
                                prefixIcon: const Icon(Icons.water_drop,
                                    color: Color(
                                        0xFF03045E)), // Optional icon for email
                                filled: true,
                                fillColor: const Color(0xffCAF0F8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(
                                    value: 'Drinking', child: Text('Drinking')),
                                DropdownMenuItem(
                                    value: 'Agriculture',
                                    child: Text('Agriculture')),
                                DropdownMenuItem(
                                    value: 'Sanitation',
                                    child: Text('Sanitation')),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _waterType = value!;
                                });
                              },
                            ),
                            const SizedBox(height: 40),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  // Navigate to the next form with saved data
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RequestForm2(
                                        name: _nameController.text,
                                        email: _emailController.text,
                                        contact: _contactController.text,
                                        address: _addressController
                                            .text, // Added address here
                                        waterType: _waterType,
                                      ),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF03045E),
                                // Button background color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 15), // Button padding
                              ),
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF), // Button text color
                                  fontSize: 16, // Button text size
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Bottom custom navigation bar
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}
