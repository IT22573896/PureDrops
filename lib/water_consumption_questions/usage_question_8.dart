import 'package:Puredrops/all_donations/map_sample.dart';
import 'package:Puredrops/authentication/profile_screen.dart';
import 'package:Puredrops/custom_navigation_bar.dart';
import 'package:Puredrops/donation_screen.dart';
import 'package:Puredrops/home_screen.dart';
import 'package:Puredrops/notifications_screen.dart';
import 'package:Puredrops/settings_screen.dart';
import 'package:Puredrops/water_consumption_questions/usage_question_9.dart';
import 'package:flutter/material.dart';

class UsageQuestion8 extends StatefulWidget {
  final int gallonCount; // Gallon count from the previous screen
  final double waterLevel; // Water level from the previous screen

  const UsageQuestion8(
      {super.key, required this.gallonCount, required this.waterLevel});

  @override
  State<UsageQuestion8> createState() => _UsageQuestion8State();
}

class _UsageQuestion8State extends State<UsageQuestion8> {
  late int gallonCount;
  late double waterLevel;
  bool isAnswered = false;

  @override
  void initState() {
    super.initState();
    gallonCount =
        widget.gallonCount; // Initialize gallon count from previous screen
    waterLevel =
        widget.waterLevel; // Initialize water level from previous screen
  }

  void updateGallonCount(int value) {
    setState(() {
      gallonCount += value; // Updates gallon count based on user input
      waterLevel +=
          value / 500; // Adjust water level animation based on gallon count
      if (waterLevel > 1.0) waterLevel = 1.0; // Capping the water level at 100%
      isAnswered = true;
    });
  }

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
                image: AssetImage('assets/Water_Consumption_Start.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Safe Area
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
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

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Water Usage Tracker',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Baloo 2',
                              color: Color(0xFF000000),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 1),
                            child: Text(
                              'Reduce Water Usage',
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
                  const SizedBox(height: 20),
                  // Gallon count and water level
                  Center(
                    child: Container(
                      width: 180,
                      height: 50,
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF03045E),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '$gallonCount',
                              style: const TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Gallons / Day',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  // Question Box with Water Level Animation Inside
                  Container(
                    width: 385,
                    height: 480,
                    decoration: BoxDecoration(
                      color: const Color(0xffCAF0F8),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          spreadRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        // Water Level Animation
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          width: 385,
                          height: 480 * waterLevel, // Animated height
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        // Question Box Content
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Transform.translate(
                                offset: const Offset(0, -10),
                                child: Image.asset(
                                  'assets/usages/Bathing.png', // Update with the new image
                                  width: 180,
                                  height: 180,
                                ),
                              ),

                              Transform.translate(
                                offset: const Offset(
                                    0, -14), // Move the text 10 pixels up
                                child: const Align(
                                  alignment: Alignment
                                      .center, // Align the text to the center
                                  child: Text(
                                    'How often do you bathe your pets?',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: 'Baloo 2',
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign
                                        .center, // Center the text horizontally
                                  ),
                                ),
                              ),

                              // Answer Buttons
                              Transform.translate(
                                offset: const Offset(
                                    0, -2), // Move the row 10 pixels up
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Daily Button
                                    ElevatedButton(
                                      onPressed: isAnswered
                                          ? null
                                          : () {
                                              updateGallonCount(
                                                  45); // Assume 45 gallons for 'Weekly'
                                            },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF0C7EEC),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        minimumSize: const Size(68, 31),
                                      ),
                                      child: const Text(
                                        'Weekly',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),

                                    // Weekly Button
                                    ElevatedButton(
                                      onPressed: isAnswered
                                          ? null
                                          : () {
                                              updateGallonCount(
                                                  30); // Assume 30 gallons for 'Monthly'
                                            },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF03045E),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        minimumSize: const Size(68, 31),
                                      ),
                                      child: const Text(
                                        'Monthly',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),

                                    // Monthly Button
                                    ElevatedButton(
                                      onPressed: isAnswered
                                          ? null
                                          : () {
                                              updateGallonCount(
                                                  15); // Assume 15 gallons for 'Rarely'
                                            },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF0077B6),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        minimumSize: const Size(68, 31),
                                      ),
                                      child: const Text(
                                        'Rarely',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 30),

                              // Tip/Advice Section
                              Container(
                                padding: const EdgeInsets.all(12.0),
                                margin:
                                    const EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xff90E0EF),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 6,
                                      spreadRadius: 2,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Text(
                                  'Tip: Use a bucket instead of a hose to wash your pet to save water. It’s more efficient and helps conserve our water resources.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'SpaceGrotesk',
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 30),

                              // Next Button
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UsageQuestion9(
                                        gallonCount:
                                            gallonCount, // Pass the current gallon count
                                        waterLevel:
                                            waterLevel, // Pass the current water level
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0077B6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  minimumSize: const Size(100, 40),
                                ),
                                child: const Text(
                                  'Next',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
