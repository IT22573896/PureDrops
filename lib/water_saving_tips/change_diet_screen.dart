import 'package:Puredrops/authentication/profile_screen.dart';
import 'package:Puredrops/custom_navigation_bar.dart';
import 'package:Puredrops/district_home_screen.dart';
import 'package:Puredrops/donation_screen.dart';
import 'package:Puredrops/home_screen.dart';
import 'package:Puredrops/notifications_screen.dart';
import 'package:Puredrops/settings_screen.dart';
import 'package:flutter/material.dart';

class ChangeDietScreen extends StatefulWidget {
  const ChangeDietScreen({super.key});

  @override
  State<ChangeDietScreen> createState() => _ChangeDietScreenState();
}

class _ChangeDietScreenState extends State<ChangeDietScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Handle navigation based on selected index
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DonationScreen()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DistrictHomeScreen()),
          );
          break;
        case 3:
          Navigator.pushReplacement(
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
                            'Change Your Diet',
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
                        imagePath: 'assets/tips/subtips/TP1.png',
                        title: 'Food Choices',
                        description:
                            'Eat more vegetables. It takes an enormous amount of water to produce animal products like meat and dairy. \n\n'
                            'Avoid processed foods: A lot of water goes into processing foods. Opt for more fruits, vegetables, leafy greens (like spinach and kale) and whole grains. \n\n'
                            'Drink one less cup of coffee per day, or – if you really need your caffeine fix – go for tea instead, since coffee has one of the highest water footprints per pound. \n\n',
                      ),

                      // Card 2
                      buildTipCard(
                        context,
                        imagePath: 'assets/tips/subtips/TP2.png',
                        title: 'Processed Food',
                        description:
                            '“Process” your own whole foods for on-the-go snacks by chopping up fresh fruit and vegetables, making your own trail mix with dried fruit and nuts or mashing up (with a food processor) beans with olive oil and seasoning for hummus or dip. \n\n'
                            'Eat less processed food like chips, pre-made meals, candy and soda, because processing requires more water. \n\n',
                      ),

                      // Card 3
                      buildTipCard(
                        context,
                        imagePath: 'assets/tips/subtips/TP3.png',
                        title: 'Food Waste',
                        description:
                            'Waste less food. In the Sri Lanka, we waste about 40 percent of our total food supply every year, which also wastes 25 percent of all freshwater consumed annually. \n\n'
                            'Cook and eat what you buy. Food ingredients are not for looking but for cooking, so go ahead and make something delicious with even the most random assortment of ingredients lurking in your kitchen. \n\n'
                            'Store your food properly. A big part of keeping food from going bad is storing food properly in the first place. \n\n',
                      ),

                      // Card 4
                      buildTipCard(
                        context,
                        imagePath: 'assets/tips/subtips/TP4.png',
                        title: 'Grocery Shopping',
                        description:
                            'Eat more vegetables. It takes an enormous amount of water to produce animal products like meat and dairy. \n\n'
                            'Avoid processed foods: A lot of water goes into processing foods. Opt for more fruits, vegetables, leafy greens (like spinach and kale) and whole grains. \n\n'
                            'Drink one less cup of coffee per day, or – if you really need your caffeine fix – go for tea instead, since coffee has one of the highest water footprints per pound. \n\n',
                      ),

                      // Card 5
                      buildTipCard(
                        context,
                        imagePath: 'assets/tips/subtips/TP5.png',
                        title: 'Pet Food Purchases',
                        description:
                            'Make your own pet food to control the quality of ingredients, as well as the water footprint. Talk with your veterinarian or an animal nutritionist to determine your pet’s specific needs before attempting this to avoid nutritional deficiencies. Learn more about making your own dog food. \n\n'
                            'Reuse, repair and buy less. In general, buy fewer animal products like collars, leashes, bowls and toys. Your pet won’t care, we promise. \n\n'
                            'Buy sustainably made products like hemp dog toys, collars and leashes. \n\n',
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
}) {
  return GestureDetector(
    onTap: () {
      // Show dialog when the card is tapped
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xFFCAF0F8),
            title: Text(
              title,
              style: const TextStyle(color: Colors.black),
            ),
            content: Text(description), // Display the description
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF0077B6), // Custom button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      );
    },
    child: Container(
      width: 180,
      height: 189,
      decoration: BoxDecoration(
        color: const Color(0xFFCAF0F8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center the image horizontally
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center the image vertically
              children: [
                SizedBox(
                  height: 100, // Explicit height
                  width: 100, // Explicit width
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover, // Use cover to fill the box
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Title below the image
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Baloo 2',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    ),
  );
}
