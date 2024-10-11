import 'package:Puredrops/authentication/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Puredrops/home_screen.dart';
import 'package:Puredrops/notifications_screen.dart';
import 'package:Puredrops/settings_screen.dart';
import 'package:Puredrops/custom_navigation_bar.dart';
import 'package:Puredrops/all_donations/donor_rank.dart';
import 'package:Puredrops/all_donations/map_sample.dart';
import 'package:Puredrops/all_donations/donation_history.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  int _selectedIndex = 0;
  int _totalDonations = 0; // Variable to store the total donation count

  @override
  void initState() {
    super.initState();
    _fetchTotalDonations(); // Fetch the total donations when the widget is initialized
  }

  // Method to fetch total donations from Firestore
  Future<void> _fetchTotalDonations() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('donations').get();
      setState(() {
        _totalDonations = snapshot.docs.length; // Update the count
      });
    } catch (e) {
      print("Error fetching total donations: $e");
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Water_Consumption_Feature.png'),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationsScreen(),
                            ),
                          ); // Navigate to Notifications screen
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
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Make Donation',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Baloo 2',
                              color: Color(0xFF000000),
                            ),
                          ),
                          // Sub title
                          Padding(
                            padding: EdgeInsets.only(top: 1),
                            child: Text(
                              'Explore the Features',
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

                  //Search Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 300,
                        height: 37,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFCAF0F8),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3)),
                          ],
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                'Search',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Total Donations & Best Donation labels + containers
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _infoColumn("Total donations",
                          _totalDonations.toString()), // Use the count here
                      _infoColumn("Best donation", "LKR 75000"),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Recent activities section
                  const Text(
                    "Recent Activities",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 10, 120, 139),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _activityCard(
                          "Bottle donations", "55%", Icons.water_drop),
                      _activityCard(
                          "Supply donations", "45%", Icons.local_shipping),
                    ],
                  ),

                  const SizedBox(height: 50),

                  // Action buttons (Donation Map, Donor Rank, Donations History)
                  _actionButton("Donation Map", context),
                  _actionButton("Donor Rank",
                      context), // This will navigate to req_form.dart
                  _actionButton("Donations History", context),

                  const Spacer(),
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

// Helper function for info cards (Total donations, Best donation)
// Helper function for info columns
Widget _infoColumn(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // The label text like "Total donations" or "Best donation"
      Text(
        label,
        style: const TextStyle(
          fontFamily: 'Baloo 2',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 10, 120, 139),
        ),
      ),
      const SizedBox(height: 10),

      // The card containing the value
      Container(
        width: 160,
        height: 70,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFCAF0F8),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Container(
            width: 155,
            height: 55,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:
                  const Color(0xff90E0EF), // Outer container background color
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Space Grotesk',
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 16, 89, 102),
                ),
              ),
            ),
          ),
        ),
      )
    ],
  );
}

Widget _activityCard(String label, String value, IconData icon) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15), // Card border radius
    ),
    child: Container(
      // Use a Container to apply background color and border radius
      decoration: BoxDecoration(
        color: const Color(0xFFCAF0F8), // Set the background color
        borderRadius: BorderRadius.circular(15), // Apply border radius here
      ),
      width: 175, // Adjusted width to accommodate the icon container
      height: 110,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Donation type label (e.g., Bottle donations)
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Percentage (e.g., 55%, 45%)
                  Center(
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 16, 89, 102),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color:
                        Colors.blueAccent.withOpacity(0.2), // Background color
                    borderRadius:
                        BorderRadius.circular(10), // Icon container radius
                  ),
                  child: Icon(
                    icon,
                    size: 30,
                    color: const Color.fromARGB(255, 24, 79, 173),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// Helper function for action buttons (Donation Map, Donor Rank, etc.)
Widget _actionButton(String label, BuildContext context) {
  return Center(
    // Center the button horizontally
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 360,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF03045E), // Dark blue
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          // Check the label to determine the navigation action
          if (label == "Donation Map") {
            // Navigate to the map_locations_view.dart file
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MapSample(),
              ),
            );
          } else if (label == "Donor Rank") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const DonorRank(), // Navigate to ReqForm screen
              ),
            );
          } else if (label == "Donations History") {
            // Navigate to donation_history.dart
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DonationHistory(),
              ),
            );
          }
        },
        child: Text(
          label,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    ),
  );
}
