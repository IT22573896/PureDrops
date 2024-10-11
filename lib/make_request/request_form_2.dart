import 'package:Puredrops/all_donations/map_sample.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth for authentication
import 'package:Puredrops/make_request/request_form_3.dart';
import 'package:Puredrops/settings_screen.dart';
import 'package:Puredrops/custom_navigation_bar.dart';
import 'package:Puredrops/home_screen.dart';
import 'package:Puredrops/authentication/profile_screen.dart';
import 'package:Puredrops/donation_screen.dart';

class RequestForm2 extends StatefulWidget {
  final String name;
  final String email;
  final String contact;
  final String address;
  final String waterType;

  const RequestForm2({
    super.key,
    required this.name,
    required this.email,
    required this.contact,
    required this.address,
    required this.waterType,
  });

  @override
  _RequestForm2State createState() => _RequestForm2State();
}

class _RequestForm2State extends State<RequestForm2> {
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

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();

  int _currentLevel = 0; // 0: Normal, 1: Urgent, 2: Critical
  final List<String> urgencyLevels = ['Normal', 'Urgent', 'Critical'];
  final int maxLevel = 2; // Maximum level

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Firestore instance
  final FirebaseAuth _auth =
      FirebaseAuth.instance; // FirebaseAuth instance for authentication

  User? _user; // User object to track the current logged-in user

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser; // Get the current authenticated user (if any)
  }

  void _increaseLevel() {
    setState(() {
      if (_currentLevel < maxLevel) {
        _currentLevel++;
      }
    });
  }

  void _decreaseLevel() {
    setState(() {
      if (_currentLevel > 0) {
        _currentLevel--;
      }
    });
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
                              'You are almost there! Continue to \nprovide a few more details',
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

                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _descriptionController,
                              decoration: InputDecoration(
                                hintText:
                                    "Enter descrption", // Optional, if you want a hint text
                                prefixIcon: const Icon(Icons.description,
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
                                  return 'Please enter a description';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),

                            // Water Glass Representation
                            Container(
                              decoration: BoxDecoration(
                                color: Colors
                                    .white, // White background for the entire box
                                borderRadius: BorderRadius.circular(
                                    16), // Rounded corners for the box
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), // Shadow for depth
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset:
                                        const Offset(0, 3), // Shadow position
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(
                                  16.0), // Padding inside the white box
                              child: Column(
                                children: [
                                  const Align(
                                    alignment: Alignment
                                        .centerLeft, // Adjust alignment as needed (e.g., Alignment.centerRight or Alignment.center)
                                    child: Text(
                                      'Urgency Level',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'Baloo 2',
                                        color: Color(0xFF000000),
                                      ),
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment
                                        .centerLeft, // Adjust alignment as needed (e.g., Alignment.centerRight or Alignment.center)
                                    child: Text(
                                      'Normal, Urgent or Critical',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF757575),
                                      ),
                                    ),
                                  ),

                                  // The water level control row
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF03045E),
                                        ),
                                        onPressed: _decreaseLevel,
                                        child: const Text('-',
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: Color(0xFFFFFFFF),
                                            )),
                                      ),
                                      const SizedBox(
                                          width:
                                              10), // Space between button and glass
                                      Container(
                                        width: 85, // Width of the glass
                                        height: 300, // Height of the glass
                                        decoration: BoxDecoration(
                                          color: Colors
                                              .white, // White background for the glass
                                          border: Border.all(
                                            color: Colors
                                                .white, // Blue border for the glass
                                            width: 1, // Border thickness
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              16), // Rounded glass edges
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blueGrey.withOpacity(
                                                  0.3), // Subtle shadow for depth
                                              blurRadius: 12, // Softer shadow
                                              spreadRadius: 4,
                                              offset: const Offset(
                                                  0, 8), // Slight shadow offset
                                            ),
                                          ],
                                        ),
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            // Animated Water Level
                                            AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 600),
                                              height: (320 / (maxLevel + 1)) *
                                                  (_currentLevel +
                                                      1), // Dynamic height for water level
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    255,
                                                    108,
                                                    216,
                                                    238), // Solid blue color for the water
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(
                                                      12), // Smooth corners for the water level
                                                  topRight: Radius.circular(12),
                                                ),
                                              ),
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  // Water Bubbles - White bubbles
                                                  Positioned(
                                                    top: 20,
                                                    child: Icon(
                                                      Icons.bubble_chart,
                                                      size: 30,
                                                      color: Colors.white
                                                          .withOpacity(
                                                              0.8), // White bubble
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 70,
                                                    child: Icon(
                                                      Icons.bubble_chart,
                                                      size: 24,
                                                      color: Colors.white
                                                          .withOpacity(
                                                              0.7), // Another white bubble
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 120,
                                                    child: Icon(
                                                      Icons.bubble_chart,
                                                      size: 18,
                                                      color: Colors.white
                                                          .withOpacity(
                                                              0.6), // Smaller white bubble
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Glass overlay to simulate refraction
                                            Container(
                                              width: 100,
                                              height: 320,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.white.withOpacity(
                                                        0.1), // Transparent white overlay
                                                    Colors.white
                                                        .withOpacity(0.2),
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                ),
                                                borderRadius: BorderRadius.circular(
                                                    16), // Matching the outer glass radius
                                              ),
                                            ),
                                            // Optional: Highlight to simulate glass reflection
                                            Positioned(
                                              top: 30,
                                              left: 10,
                                              child: Container(
                                                width: 20,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.white.withOpacity(
                                                          0.5), // White highlight for reflection
                                                      Colors.transparent,
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ),
                                            // Glass shadow for realistic effect
                                            Positioned(
                                              bottom: 0,
                                              child: Container(
                                                width: 120,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                  gradient: RadialGradient(
                                                    colors: [
                                                      Colors.blueGrey
                                                          .withOpacity(0.3),
                                                      Colors.transparent,
                                                    ],
                                                    radius: 0.6,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                          width:
                                              10), // Space between glass and button
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF03045E),
                                        ),
                                        onPressed: _increaseLevel,
                                        child: const Text('+',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Color(0xFFFFFFFF),
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF03045E),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // Ensure user is authenticated before saving
                                  if (_user != null) {
                                    try {
                                      // Optional: Save the data to Firestore
                                      await _firestore
                                          .collection('requests_temp')
                                          .add({
                                        'name': widget.name,
                                        'email': widget.email,
                                        'contact': widget.contact,
                                        'address': widget.address,
                                        'waterType': widget.waterType,
                                        'description':
                                            _descriptionController.text,
                                        'urgencyLevel': urgencyLevels[
                                            _currentLevel], // Save the urgency level as a string
                                        'userId': _user!
                                            .uid, // Store user ID in the request
                                      });

                                      // Navigate to the next screen with collected data
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RequestForm3(
                                            name: widget.name,
                                            email: widget.email,
                                            contact: widget.contact,
                                            address: widget.address,
                                            waterType: widget.waterType,
                                            description:
                                                _descriptionController.text,
                                            urgencyLevel: urgencyLevels[
                                                _currentLevel], // Pass urgency level
                                          ),
                                        ),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Error saving request: $e')),
                                      );
                                    }
                                  } else {
                                    // Show message if the user is not authenticated
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'User not authenticated. Please log in to continue.')),
                                    );
                                  }
                                }
                              },
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
