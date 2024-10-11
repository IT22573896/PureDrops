import 'package:Puredrops/authentication/profile_screen.dart';
import 'package:Puredrops/custom_navigation_bar.dart';
import 'package:Puredrops/district_home_screen.dart';
import 'package:Puredrops/donation_screen.dart';
import 'package:Puredrops/home_screen.dart';
import 'package:Puredrops/notifications_screen.dart';
import 'package:Puredrops/settings_screen.dart';
import 'package:flutter/material.dart';

class ChangeBuyingHabits extends StatefulWidget {
  const ChangeBuyingHabits({super.key});

  @override
  State<ChangeBuyingHabits> createState() => _ChangeBuyingHabitsState();
}

class _ChangeBuyingHabitsState extends State<ChangeBuyingHabits> {
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
                            'Change Buying Habits',
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
                        imagePath: 'assets/tips/subtips/TP22.png',
                        title: 'Shop Smarter',
                        description:
                            'Think before you buy. Do you really need to upgrade your phone? To buy another pair of jeans? Americans shop a lot, and as a result, we have one of the highest water footprints in the world. \n\n'
                            'Buy less and reuse or repurpose what you already have. \n\n'
                            'Buy quality, reusable products such as non-disposable cameras, reusable or electric razors, reusable dishes and mugs and utensils and have your child carry lunch in a reusable lunch box. \n\n',
                      ),

                      // Card 2
                      buildTipCard(
                        context,
                        imagePath: 'assets/tips/subtips/TP23.png',
                        title: 'Recycle Paper',
                        description:
                            'Use less paper or recycle it – there are lots of ways to do this. Think, “saving paper (or plastic, glass or aluminum for that matter) equals saving water.” \n\n'
                            'Compost those paper towels. Some forms of composting will let you include paper. \n\n',
                      ),

                      // Card 3
                      buildTipCard(
                        context,
                        imagePath: 'assets/tips/subtips/TP24.png',
                        title: 'Recycle Plastic',
                        description:
                            'When you have other options, avoid plastic because it’s a bad deal for the environment. Plastic manufacturing takes a lot of water and energy and it often ends up polluting our waterways, especially the ocean. \n\n'
                            'Don’t drink bottled water. It’s the ultimate form of wasteful convenience. It takes at least as much (and often much more) water to make the bottle as the drinking water it holds. \n\n'
                            'Choose tap water over bottled – it takes about 1.5 gallons of water to manufacture a single plastic bottle (how crazy is that?) and plastic bottles are always made from new plastic material. \n\n',
                      ),

                      // Card 4
                      buildTipCard(
                        context,
                        imagePath: 'assets/tips/subtips/TP25.png',
                        title: 'Bottles & Cans',
                        description:
                            'Fill a reusable water bottle with the beverage of your choice so you don’t have to buy packaging-intensive, single serving sizes. \n\n'
                            'Don’t put anything but container glass in the recycling. It might be unrecyclable because glass used for mirrors, glassware, etc. has components that can’t be mixed with container glass. \n\n'
                            'Prepare aluminum cans for recycling by crushing them to save space. \n\n',
                      ),

                      // Card 5
                      buildTipCard(
                        context,
                        imagePath: 'assets/tips/subtips/TP26.png',
                        title: 'Reuse/Recycle',
                        description:
                            'Stop and ask yourself whether or not you really need that new piece of clothing. \n\n'
                            'If you do really need that new top, consider thrift stores for a wardrobe update. Thrift is in! And you can often find really great items at your local thrift store for a lot less than you’d pay for new. \n\n'
                            'Care for your clothes properly, and your clothes will last for a long time. It takes a lot of water to make clothing, regardless of what kind of the fabric. Taking proper care of your clothes will lessen how many new pieces you need to buy. \n\n',
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
