import 'package:Puredrops/all_donations/map_sample.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Puredrops/make_request/request_details.dart';
import 'package:Puredrops/settings_screen.dart';
import 'package:Puredrops/custom_navigation_bar.dart';
import 'package:Puredrops/home_screen.dart';
import 'package:Puredrops/authentication/profile_screen.dart';
import 'package:Puredrops/donation_screen.dart';

class RequestsListPage extends StatefulWidget {
  const RequestsListPage({super.key});

  @override
  _RequestsListPageState createState() => _RequestsListPageState();
}

class _RequestsListPageState extends State<RequestsListPage> {
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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser; // Get the current user
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
                image: AssetImage('assets/Home_Screen.png'),
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
                            'My Requests ',
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
                              'View, manage and track all your water \nsupply requests in one place',
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
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('requests')
                          .where('uid',
                              isEqualTo: _currentUser?.uid) // Filter by user ID
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(
                              child: Text('No requests found.'));
                        }

                        // Displaying the list of requests
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var requestData = snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;
                            String requestId = snapshot.data!.docs[index]
                                .id; // Get the request document ID

                            return GestureDetector(
                              onTap: () {
                                // Navigate to the details page when a request is tapped
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RequestDetailsPage(
                                      requestData: requestData,
                                      requestId:
                                          requestId, // Pass the requestId to the details page
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal:
                                        16.0), // Add margin around the card
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      12), // Rounded corners
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueGrey
                                          .withOpacity(0.2), // Shadow for depth
                                      blurRadius: 8.0,
                                      spreadRadius: 1.0,
                                      offset:
                                          const Offset(2, 2), // Shadow offset
                                    ),
                                  ],
                                  gradient: const LinearGradient(
                                    colors: [
                                      Colors
                                          .white, // More white, slightly transparent
                                      Color.fromARGB(
                                          255, 81, 179, 225), // Dark blue
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    stops: [
                                      0.4,
                                      3.0
                                    ], // Adjusting stops for more white
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      16.0), // Padding inside the card
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        requestData['waterType'] ??
                                            'Unknown Type',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87, // Text color
                                        ),
                                      ),
                                      const SizedBox(
                                          height:
                                              8.0), // Space between title and description
                                      Text(
                                        requestData['urgencyLevel'] ??
                                            'Urgency level not provided',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors
                                              .black54, // Lighter text color for description
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
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
