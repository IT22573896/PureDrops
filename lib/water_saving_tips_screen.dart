import 'package:Puredrops/all_donations/map_sample.dart';
import 'package:Puredrops/authentication/profile_screen.dart';
import 'package:Puredrops/custom_navigation_bar.dart';
import 'package:Puredrops/donation_screen.dart';
import 'package:Puredrops/home_screen.dart';
import 'package:Puredrops/notifications_screen.dart';
import 'package:Puredrops/settings_screen.dart';
import 'package:Puredrops/water_saving_tips/change_buying_habits.dart';
import 'package:Puredrops/water_saving_tips/change_diet_screen.dart';
import 'package:Puredrops/water_saving_tips/cut_indoor_water_use.dart';
import 'package:Puredrops/water_saving_tips/educational_resources.dart';
import 'package:Puredrops/water_saving_tips/save_energy_save_water.dart';
import 'package:Puredrops/water_saving_tips/use_less_water_outdoors.dart';
import 'package:flutter/material.dart';

class WaterSavingTipsScreen extends StatefulWidget {
  const WaterSavingTipsScreen({super.key});

  @override
  State<WaterSavingTipsScreen> createState() => _WaterSavingTipsScreenState();
}

class _WaterSavingTipsScreenState extends State<WaterSavingTipsScreen> {
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
                image: AssetImage('assets/Water_Saving_Tips.png'),
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
                            'Water Saving Tips',
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
                              'How to Save Water',
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

                  // Add 6 Tips cards
                  Expanded(
                      child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: (180 / 189),
                    children: [
                      // Card 1
                      buildTipCard(
                        context,
                        imagePath: 'assets/tips/tip1.png',
                        title: 'Change Your Diet',
                        description:
                            'It takes water – a lot of it – to grow, process and transport your food. When you eat lower on the food chain, eat more whole foods and waste less food, you also save water.',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChangeDietScreen(),
                            ),
                          );
                        },
                      ),

                      // Card 2
                      buildTipCard(
                        context,
                        imagePath: 'assets/tips/tip2.png',
                        title: 'Cut Indoor Water Use',
                        description:
                            'Every day, you rely on water for a wide variety of uses around the house. There are lots of opportunities to cut back on water use in the kitchen, bathroom and laundry room.',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CutIndoorWaterUse(),
                            ),
                          );
                        },
                      ),

                      // Card 3
                      buildTipCard(
                        context,
                        imagePath: 'assets/tips/tip3.png',
                        title: 'Use Less Water Outdoors',
                        description:
                            'Of all the residential water we use in the US, on average we use about a quarter outdoors. In some western states it’s half to three-quarters, primarily for lawns and gardens. ',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const UseLessWaterOutdoors(),
                            ),
                          );
                        },
                      ),

                      // Card 4
                      buildTipCard(
                        context,
                        imagePath: 'assets/tips/tip4.png',
                        title: 'Save Energy, Save Water',
                        description:
                            'Water and energy are linked. It takes water to make energy (electricity and transportation fuels) and it takes energy to move, heat and treat water. ',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SaveEnergySaveWater(),
                            ),
                          );
                        },
                      ),

                      // Card 5
                      buildTipCard(
                        context,
                        imagePath: 'assets/tips/tip5.png',
                        title: 'Change Buying Habits',
                        description:
                            'Practically everything you buy, use and consume has a water footprint because it took water to process and transport it. Being thoughtful about purchases, reusing where you can.',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChangeBuyingHabits(),
                            ),
                          );
                        },
                      ),

                      // Card 6
                      buildTipCard(
                        context,
                        imagePath: 'assets/tips/tip6.png',
                        title: 'Dive Deeper',
                        description: 'Explore more educational materials.',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EducationalResources(),
                            ),
                          );
                        },
                      ),
                    ],
                  ))
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

Widget buildTipCard(
  BuildContext context, {
  required String imagePath,
  required String title,
  required String description,
  required VoidCallback onPressed,
}) {
  return GestureDetector(
    onTap: onPressed, // Trigger the onPressed callback when the card is tapped
    child: Container(
      width: 180,
      height: 189,
      decoration: BoxDecoration(
        color: const Color(0xFFCAF0F8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image on the left
                Image.asset(
                  imagePath,
                  width: 70,
                  height: 70,
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Title below the image
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Baloo 2',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 6),
            // Description below the title
            Expanded(
              child: Text(
                description,
                style: const TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 10,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
