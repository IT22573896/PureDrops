import 'package:Puredrops/all_donations/map_sample.dart';
import 'package:Puredrops/authentication/profile_screen.dart';
import 'package:Puredrops/chatbot.dart';
import 'package:Puredrops/custom_navigation_bar.dart';
import 'package:Puredrops/district_home_screen.dart';
import 'package:Puredrops/donation_screen.dart';
import 'package:Puredrops/notifications_screen.dart';
import 'package:Puredrops/request_screen.dart';
import 'package:Puredrops/settings_screen.dart';
import 'package:Puredrops/water_consumption_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _hasNewNotification = false;

  Color cardColor = const Color(0xFFCAF0F8);
  String cardTitle = "Critical Water Demand Zones";
  String cardSubtitle = "Urgent Water Supply";
  String cardDescription =
      "Identify and explore zones with critical water shortages.\nThis map highlights regions where water supply is a priority, helping you make informed decisions on where assistance is needed most. Explore zones with critical water shortages to prioritize assistance where water supply is most needed";

// Example of multiple card data for dynamic content
  List<Map<String, String>> cardContent = [
    {
      "title": "Critical Water Demand Zones",
      "subtitle": "Urgent Water Supply",
      "description":
          "Identify and explore zones with critical water shortages.\nThis map highlights regions where water supply is a priority, helping you make informed decisions on where assistance is needed most. Explore zones with critical water shortages to prioritize assistance where water supply is most needed",
    },
    {
      "title": "Water Conservation Efforts",
      "subtitle": "Save Water, Save Lives",
      "description":
          "Discover effective strategies and innovative methods to conserve water in your community. \nThis guide provides practical tips and actionable steps to reduce water consumption, helping you make a significant impact on sustainable water use. ",
    },
    {
      "title": "Global Water Crisis",
      "subtitle": "Understanding the Challenges",
      "description":
          "Delve into the complexities of the global water crisis and understand the challenges faced by communities worldwide. This overview highlights the key issues affecting water accessibility and quality, including climate change, population growth, and pollution.",
    },
  ];

  // Timer to change card content
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startCardUpdate();
    _simulateNewNotification();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _startCardUpdate() {
    int index = 0;

    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      setState(() {
        // Cycle through the card content
        index = (index + 1) % cardContent.length;

        cardTitle = cardContent[index]["title"]!;
        cardSubtitle = cardContent[index]["subtitle"]!;
        cardDescription = cardContent[index]["description"]!;
        // You can change the card color as well
        cardColor =
            index % 2 == 0 ? const Color(0xFF3AC1F4) : const Color(0xFFD0E9E7);
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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

  void _simulateNewNotification() {
    // Simulating a new notification after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _hasNewNotification = true; // Set to true to show the dot
      });
      print("New notification received"); // Debugging line
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/Home_Screen.png'),
                    fit: BoxFit.cover)),
          ),

          // Overlay with Widgets
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with title and notifi icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PureDrops',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Baloo 2',
                              color: Color(0xFF000000),
                            ),
                          ),

                          // Sub title
                          Padding(
                              padding: EdgeInsets.only(top: 1),
                              child: Text(
                                'Empowering Communities with\nClean Water Solutions',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF757575)),
                                textAlign: TextAlign.left,
                              )),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _hasNewNotification = false; // Clear notifications
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationsScreen(),
                            ),
                          ); // Navigate to Notifications screen
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
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
                            if (_hasNewNotification)
                              Positioned(
                                top: 0, // Position at the top of the icon
                                right: 0, // Position at the right of the icon
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
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
                  //Search Bar
                  Row(
                    children: [
                      Container(
                        width: 290,
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
                      Padding(
                        padding: const EdgeInsets.only(left: 38),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SettingsScreen(),
                              ),
                            ); // Navigate to Settings screen
                          },
                          child: const Icon(
                            Icons.settings,
                            color: Colors.black,
                            size: 36,
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  // Card
                  Container(
                    width: 383,
                    height: 193,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardColor, // Dynamic color
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cardTitle, // Dynamic title
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'RobotoMono',
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          cardSubtitle, // Dynamic subtitle
                          style: const TextStyle(
                            fontSize: 27,
                            fontFamily: 'SpaceGrotesk',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          cardDescription, // Dynamic description
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'SpaceGrotesk',
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Row of Action Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildFeatureButton(
                            'assets/icons/Consumption.png', 'Consumption', () {
                          // Navigate to Water Consumption screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const WaterConsumptionScreen()),
                          );
                        }),
                        _buildFeatureButton(
                            'assets/icons/Bottle.png', 'Donations', () {
                          // Navigate to Donation screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DonationScreen()),
                          );
                        }),
                        _buildFeatureButton(
                            'assets/icons/Water.png', 'Requests', () {
                          // Navigate to Requests screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RequestScreen()),
                          );
                        }),
                        _buildFeatureButton(
                            'assets/icons/Brain.png', 'Resources', () {
                          // Navigate to Locations screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const DistrictHomeScreen()),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildCard(
                    'Water Conservation Tips',
                    'Tip of the Day : Save water by taking shorter showers.',
                    'See more',
                  ),
                  _buildCard(
                    'Donate Water Supply',
                    'Contribute to clean water access by donating supplies.',
                    'See more',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          // Bottom Navigation Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          ),
        ],
      ),
      // Floating action button with a chatbot icon
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 10.0, bottom: 65.0),
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatBot()),
            );
          }, // 'smart_toy' is a robot-like icon
          shape: const CircleBorder(),
          // Use a chatbot-like icon
          child: const Icon(
            Icons.smart_toy, // Chatbot-like icon
            color: Colors.white, // Icon color set to white
          ), // Fully rounded shape
        ),
      ),
    );
  }
}

// Feature Buttons
Widget _buildFeatureButton(
    String imagePath, String label, VoidCallback onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              color: const Color(0xff0077B6),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset(
              imagePath,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          label,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'Outfit',
              color: Colors.black),
        )
      ],
    ),
  );
}

// Information Cards
Widget _buildCard(String title, String subtitle, String buttonText) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: const EdgeInsets.all(20),
    width: 383,
    height: 120,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'RobotoMono'),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
        const SizedBox(
          height: 2,
        ),
        const Spacer(),
        SizedBox(
            width: 97,
            height: 25,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF03045E), // Button color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                )))
      ],
    ),
  );
}
