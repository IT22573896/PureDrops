import 'package:Puredrops/all_donations/map_sample.dart';
import 'package:Puredrops/donation_screen.dart';
import 'package:Puredrops/home_screen.dart';
import 'package:Puredrops/settings_screen.dart';
import 'package:Puredrops/water_intake_list.dart';
import 'package:flutter/material.dart';
import 'chatbot.dart'; // Import ChatBot page
import 'package:Puredrops/district_graph_screen.dart'; // Import District details page
import 'package:Puredrops/districtdeatils_screen.dart'; // Import Graph screen
import 'custom_navigation_bar.dart'; // Import custom bottom navigation bar
import 'package:Puredrops/authentication/profile_screen.dart';

class DistrictHomeScreen extends StatefulWidget {
  const DistrictHomeScreen({super.key});

  @override
  State<DistrictHomeScreen> createState() => _DistrictHomeScreenState();
}

class _DistrictHomeScreenState extends State<DistrictHomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/District.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top bar with back and notification icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
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
                          // Handle notifications tap
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
                  // Heading and subheading
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Resources',
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
                              'Learn more about water and sanitation',
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

                  const SizedBox(height: 12),
                  // Updated water detail card
                  Card(
                    color: const Color(
                        0xFF00509E), // Light teal background for the card
                    elevation: 4.0,
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'In the Knowledge section, you can explore ,',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Outfit',
                              color: Color.fromARGB(255, 204, 235, 244),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '1. AI-powered Exploration: Learn not only about clean water and sanitation, but also gain broader insights through interactive AI chat.\n\n'
                            '2. Clean Water Access (2010–2022): View progress on clean water availability over the years \n\n'
                            '3. District-wise Details: Explore water and sanitation Details for each district.\n\n'
                            '4. Daily Water Drinking: Note down how many liters did you drink',
                            style: TextStyle(
                                fontFamily: 'Outfit',
                                color: Color.fromARGB(255, 249, 248, 248)),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  // Updated buttons section right after the card
                  _buildNavigationButton(
                    context,
                    'Explore Clean Water & Sanitation\n (Gemini AI)', // Shortened title
                    const ChatBot(),
                  ),
                  const SizedBox(height: 10),
                  _buildNavigationButton(
                    context,
                    'Clean Water Details\nby District', // Shortened title
                    const DistrictdetailsScreen(),
                  ),
                  const SizedBox(height: 10),
                  _buildNavigationButton(
                    context,
                    'Clean Water Access\n(Last 12 Years)', // Shortened title
                    const GraphScreen(),
                  ),
                  const SizedBox(height: 10),
                  _buildNavigationButton(
                    context,
                    'Water Intake List', // New button title
                    const WaterIntakeList(), // Navigate to WaterIntakeList
                  ),
                ],
              ),
            ),
          ),
          // Custom Bottom Navigation Bar
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

  Widget _buildNavigationButton(
      BuildContext context, String text, Widget destination) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            const Color.fromARGB(255, 14, 123, 232), // Dark blue color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        minimumSize: const Size(
            double.infinity, 45), // Adjusted button height for compactness
        padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10.0), // Reduced padding to avoid overflow
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            // Make text flexible to avoid overflow
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white, // White text color
                fontFamily: 'Baloo 2', // Use Baloo 2 for button text
              ),
              textAlign: TextAlign.left, // Left-align text in the button
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Colors.white, // Icon color white
          ),
        ],
      ),
    );
  }
}
