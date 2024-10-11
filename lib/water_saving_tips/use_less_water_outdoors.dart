import 'package:Puredrops/authentication/profile_screen.dart';
import 'package:Puredrops/custom_navigation_bar.dart';
import 'package:Puredrops/district_home_screen.dart';
import 'package:Puredrops/donation_screen.dart';
import 'package:Puredrops/home_screen.dart';
import 'package:Puredrops/notifications_screen.dart';
import 'package:Puredrops/settings_screen.dart';
import 'package:flutter/material.dart';

class UseLessWaterOutdoors extends StatefulWidget {
  const UseLessWaterOutdoors({super.key});

  @override
  State<UseLessWaterOutdoors> createState() => _UseLessWaterOutdoorsState();
}

class _UseLessWaterOutdoorsState extends State<UseLessWaterOutdoors> {
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
                            'Use Less Water Outdoors',
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
                          imagePath: 'assets/tips/subtips/TP13.png',
                          title: 'Lawns & Gardens',
                          description:
                              'If you must, water your lawn when it’s cooler – in the early morning or late evening – to reduce water loss from evaporation. \n\n'
                              'Set up your sprinklers so they’re not spraying the sidewalk or driveway. Not only does that squander water supplies, it can also wash polluting fertilizers and pesticides into sewer systems. \n\n'
                              'Turn your sprinklers off when rain is expected, and set up a system with rain/moisture sensors if you have automatic sprinklers. \n\n',
                        ),

                        // Card 2
                        buildTipCard(context,
                            imagePath: 'assets/tips/subtips/TP14.png',
                            title: 'Xeriscaping',
                            description:
                                'Minimize or eliminate your lawn watering. Plant native species that don’t require additional watering. Grassy lawns might make sense in wet climates, but in dry areas like the south and southwest, they’re huge water-wasters. \n\n'),

                        // Card 3
                        buildTipCard(context,
                            imagePath: 'assets/tips/subtips/TP15.png',
                            title: 'Rain Barrels',
                            description:
                                'Set up a rain barrel under a gutter outside your house. On average, you can catch 4 gallons of water a day (more in really rainy areas) to use for watering the lawn, washing the car, etc. Just don’t drink it, and make sure to keep it covered with a fine-mesh screen so it doesn’t breed mosquitoes. Check your local municipal regulations to see if a rain barrel is allowed. \n\n'
                                'Direct gutter downspouts and the water drain line from your air conditioner to a flowerbed, tree base or your lawn. \n\n'),

                        // Card 4
                        buildTipCard(
                          context,
                          imagePath: 'assets/tips/subtips/TP16.png',
                          title: 'Swimming Pools',
                          description:
                              'Use a pool cover. Uncovered pools can lose up to a thousand gallons of water from evaporation each month (as well as energy if your pool is heated)! \n\n'
                              'Keep your pool water cool to reduce evaporation, and keep the water level low to reduce the amount of water lost to splashing. \n\n'
                              'Check your pool for leaks often, and if you find a leak get it fixed as soon as possible. \n\n',
                        ),

                        // Card 5
                        buildTipCard(
                          context,
                          imagePath: 'assets/tips/subtips/TP17.png',
                          title: 'Car Washing',
                          description:
                              'Car washing is part of car maintenance. It doesn’t have to be a major water waster if it’s done properly. \n\n'
                              'Car washes that recycle usually display signs or logos that identify the practice. \n\n'
                              'Use self-service car washes. They use the least amount of water because they use high-pressure hoses that have a pistol grip that can be turned on and off easily. Make sure to use the lowest pressure necessary so the water doesn’t evaporate. Turn off the water when soaping up the car and allow the car to drip dry as much as possible so more water gets captured for re-use if they recycle. \n\n',
                        ),

                        // Card 6
                        buildTipCard(context,
                            imagePath: 'assets/tips/subtips/TP18.png',
                            title: 'Greywater',
                            description:
                                'Consider installing a greywater system. These systems allow you to re-use the water from your sinks, washing machine and dishwasher for flushing toilets and watering plants outside. \n\n'),

                        // Card 7
                        buildTipCard(
                          context,
                          imagePath: 'assets/tips/subtips/TP19.png',
                          title: 'Outdoor Water Leaks',
                          description:
                              'Check your in-ground irrigation system each spring before you turn it on, to make sure there’s no damage from frost or freezing during the winter. An irrigation system with a leak as small as 1/32 inch in diameter (about the thickness of a dime) can waste about 6,300 gallons of water (and a lot of money) each month. \n\n'
                              'Make sure your irrigation system is set properly so you’re not overwatering. Next, to find leaks, check out this video to find and repair your leaks. \n\n'
                              'Find out if your pool is leaking if it seems like it’s losing water by the bucketful. The first step in finding a pool leak is to determine whether the water loss is actually from a leak or from evaporation (in which case, cover that pool when you’re not using it!). This simple bucket test will help you figure it out. \n\n',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 60,
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
                fontSize: 17,
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
