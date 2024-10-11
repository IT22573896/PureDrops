import 'package:Puredrops/all_donations/map_sample.dart';
import 'package:Puredrops/custom_navigation_bar.dart';
import 'package:Puredrops/donation_screen.dart';
import 'package:Puredrops/goal_setting_screen.dart';
import 'package:Puredrops/home_screen.dart';
import 'package:Puredrops/notifications_screen.dart';
import 'package:Puredrops/settings_screen.dart';
import 'package:Puredrops/water_saving_tips_screen.dart';
import 'package:Puredrops/water_usage_tracker_screen.dart';
import 'package:flutter/material.dart';

import 'authentication/profile_screen.dart';

class WaterConsumptionScreen extends StatefulWidget {
  const WaterConsumptionScreen({super.key});

  @override
  State<WaterConsumptionScreen> createState() => _WaterConsumptionScreenState();
}

class _WaterConsumptionScreenState extends State<WaterConsumptionScreen> {
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
                            'Water Consumption',
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

                  // Add 3 card implementations here
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        // Card 1 : Water Consumption trcaker
                        child: buildCard(
                          context,
                          title: 'Water Usage Tracker',
                          description:
                              'Track your daily water consumption by answering all questions',
                          imagePath: 'assets/tracker/Tracker.png',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const WaterUsageTrackerScreen()),
                            );
                          },
                          isImageLeft: true,
                        ),
                      ),

                      // Card 2: Set Goals
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: buildCard(
                          context,
                          title: 'Set Goals',
                          description:
                              'Set personalized water-saving goals to reduce your daily or weekly consumption',
                          imagePath: 'assets/tracker/Goals.png',
                          onPressed: () {
                            _showPremiumFeatureFullScreen(context);
                          },
                          isImageLeft: false,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        // Card 1 : Water Consumption trcaker
                        child: buildCard(
                          context,
                          title: 'Water Saving Tips',
                          description:
                              'eceive practical tips and suggestions to help you conserve water in your daily routine',
                          imagePath: 'assets/tracker/Tips.png',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const WaterSavingTipsScreen()),
                            );
                          },
                          isImageLeft: true,
                        ),
                      ),
                    ],
                  )
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

Widget buildCard(
  BuildContext context, {
  required String title,
  required String description,
  required String imagePath,
  required VoidCallback onPressed,
  required bool isImageLeft,
}) {
  return Container(
    width: 380,
    height: 180,
    decoration: BoxDecoration(
      color: const Color(0xFFCAF0F8),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        if (isImageLeft) buildImageSection(imagePath),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: isImageLeft
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Baloo 2',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: isImageLeft
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Text(
                    description,
                    textAlign: isImageLeft
                        ? TextAlign.right
                        : TextAlign.left, // Adjust text alignment
                    style: const TextStyle(
                      fontFamily: 'Space Grotesk',
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Align(
                  alignment: isImageLeft
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: SizedBox(
                    width: 106, // Set width
                    height: 31, // Set height
                    child: TextButton(
                      onPressed: onPressed,
                      style: TextButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF03045E), // Set background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20), // Set border radius
                        ),
                      ),
                      child: const Text(
                        'See more',
                        style: TextStyle(
                          fontFamily: 'Outfit', // Set font family
                          fontSize: 13, // Set font size
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        if (!isImageLeft) buildImageSection(imagePath),
      ],
    ),
  );
}

Widget buildImageSection(String imagePath) {
  return Container(
    width: 138,
    height: 162,
    margin: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF90E0EF),
      borderRadius: BorderRadius.circular(25),
    ),
    child: Center(
      child: Image.asset(
        imagePath,
        width: 152,
        height: 120,
        fit: BoxFit.contain,
      ),
    ),
  );
}

void _showPremiumFeatureFullScreen(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height *
            0.85, // Cover most of the screen
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // Cover Image
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  image: const DecorationImage(
                    image: AssetImage(
                        'assets/Earth.png'), // Replace with your cover image asset
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              // Title
              const Text(
                'Unlock Premium Features',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Outfit'),
              ),
              const SizedBox(height: 10.0),
              // Description of Premium Features
              const Text(
                'Gain access to personalized goal setting, advanced water tracking, and more with our premium plan.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
              const SizedBox(height: 20.0),
              // Features List
              Expanded(
                child: ListView(
                  children: const <Widget>[
                    ListTile(
                      leading: Icon(Icons.check, color: Colors.green),
                      title: Text('Personalized Goal Setting'),
                    ),
                    ListTile(
                      leading: Icon(Icons.lock,
                          color: Color.fromARGB(255, 155, 132, 2)),
                      title: Text('Advanced Water Tracking Insights'),
                    ),
                    ListTile(
                      leading: Icon(Icons.lock,
                          color: Color.fromARGB(255, 155, 132, 2)),
                      title: Text('Interactive Graphical Reports'),
                    ),
                    ListTile(
                      leading: Icon(Icons.lock,
                          color: Color.fromARGB(255, 155, 132, 2)),
                      title: Text('Priority Customer Support'),
                    ),
                  ],
                ),
              ),
              // Pricing and Buttons
              // Pricing and Buttons
              Column(
                children: <Widget>[
                  const Text(
                    '\$9.99 / Month',
                    style: TextStyle(
                      fontSize: 45.0, // Increased font size
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Baloo 2',
                      color: Color.fromARGB(255, 1, 50, 136),
                    ),
                  ),
                  const SizedBox(
                      height: 20.0), // Adjust spacing below the price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(fontSize: 18.0, color: Colors.grey),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to PaymentScreen for payment
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const GoalSettingScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 15.0),
                          backgroundColor: const Color(0xff00AEEF),
                        ),
                        child: const Text(
                          'Purchase',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
