import 'package:Puredrops/authentication/profile_screen.dart';
import 'package:Puredrops/custom_navigation_bar.dart';
import 'package:Puredrops/district_home_screen.dart';
import 'package:Puredrops/donation_screen.dart';
import 'package:Puredrops/home_screen.dart';
import 'package:Puredrops/notifications_screen.dart';
import 'package:Puredrops/settings_screen.dart';
import 'package:flutter/material.dart';

class CutIndoorWaterUse extends StatefulWidget {
  const CutIndoorWaterUse({super.key});

  @override
  State<CutIndoorWaterUse> createState() => _CutIndoorWaterUseState();
}

class _CutIndoorWaterUseState extends State<CutIndoorWaterUse> {
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
                            'Cut Indoor Water Use',
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
                      childAspectRatio: (180 / 180),
                      children: [
                        // Card 1
                        buildTipCard(
                          context,
                          imagePath: 'assets/tips/subtips/TP6.png',
                          title: 'Cooking',
                          description:
                              'Install a low-flow faucet on your sink. Conventional faucets flow at around 5 gallons per minute, while low-flow faucets flow at 1.5 gallons per minute. \n\n'
                              'Boil food in as little water as possible to save water and cooking fuel. You just need enough to submerge your pasta and potatoes. Plus, with less water you keep more flavor and nutrients in your veggies. \n\n'
                              'Keep a bucket or pitcher in your kitchen to collect leftover drinking water, water used to rinse vegetables and to boil food. When it’s time to water your plants or garden, use this “recycled” water before you fill up your watering can from the tap. \n\n',
                        ),

                        // Card 2
                        buildTipCard(
                          context,
                          imagePath: 'assets/tips/subtips/TP7.png',
                          title: 'Dish Washing',
                          description:
                              'Washing dishes is a daily chore that has the potential to waste a lot of water. Water- and energy-efficient dishwashers use much less water than washing dishes by hand does. If you do hand wash, there are steps you can take to use less and stop wasting water. \n\n'
                              'Get a dishwasher. They almost always use less water than washing by hand, especially with water- and energy-efficient models (just make sure to only run the dishwasher when it’s full). Hand washing one load of dishes can use 20 gallons of water, whereas water- and energy-efficient dishwaters use as little as 4 gallons. Over time, that’s a big difference! \n\n'
                              'When you do wash by hand, try using a little water to get your sponge soapy and wet, then turning off the faucet until you’re ready to rinse a bunch of dishes at once. Better yet, plug the sink or get a tub to wash dishes in so you don’t need to let the water run. \n\n',
                        ),

                        // Card 3
                        buildTipCard(
                          context,
                          imagePath: 'assets/tips/subtips/TP8.png',
                          title: 'Shower & Bath',
                          description:
                              'Put a bucket in the shower while you’re waiting for the water to warm up, and use the water you catch for watering plants, flushing the toilet or cleaning. \n\n'
                              'Spend less time in the shower. If you lose track of time, bring a radio into the bathroom and time yourself by how many songs play while you’re in there. Try to get your shower time down to a single song (epic rock ballads like Freebird don’t count!). \n\n'
                              'Turn off the water if you shave or brush your teeth in the shower to save time. \n\n',
                        ),

                        // Card 4
                        buildTipCard(
                          context,
                          imagePath: 'assets/tips/subtips/TP9.png',
                          title: 'Bathroom Sink',
                          description:
                              'Turn off the water when you’re using the bathroom sink. Whether you’re washing your hands, shaving or brushing your teeth, don’t let the faucet run continuously. It’s the simplest way to save water. \n\n'
                              'Use cold water to brush your teeth because when you save energy, you also save water. \n\n'
                              'Set the water heater to the proper temperature so your hands don’t get scalded, forcing you to add more cold water water to the mix coming out of your faucet. \n\n',
                        ),

                        // Card 5
                        buildTipCard(
                          context,
                          imagePath: 'assets/tips/subtips/TP10.png',
                          title: 'Toilet',
                          description:
                              'Get a low-flow toilet. Flushing is the biggest water hog in the house. Older, conventional toilets can use 5 to 7 gallons per flush, but low-flow models use as little as 1.6 gallons. Since the average person flushes five times a day, the gallons can really add up. \n\n'
                              'To check for a toilet leak, put dye or food coloring into the tank. If color appears in the bowl without flushing, there’s a leak that should be repaired. \n\n'
                              'Don’t flush things down the toilet to dispose of them. Throw tissues and other bathroom waste in the garbage can, which doesn’t require gallons of water. \n\n',
                        ),

                        // Card 6
                        buildTipCard(
                          context,
                          imagePath: 'assets/tips/subtips/TP11.png',
                          title: 'Laundry',
                          description:
                              'Wash your jeans less – washing them a lot will wear them out more quickly. Consider airing them out or even putting them in the freezer to freshen them up. \n\n'
                              'For that matter, wash all your clothes less.  You don’t need to wash most of your clothes as often as you probably do. Here are some ideas to help you cut back one of the biggest water users in the home and understand why thrifting can help you buy fewer clothing items. \n\n'
                              'Dry your clothes on a drying rack or a clothes line. When you save energy, you also save water because power plants use a lot of water to produce electricity. \n\n',
                        ),

                        // Card 7
                        buildTipCard(
                          context,
                          imagePath: 'assets/tips/subtips/TP12.png',
                          title: 'Indoor Water Leaks',
                          description:
                              'Find out how to detect and fix a bathroom leak.  If you look up at the ceiling and see evidence of a leak from the bathroom above, this video will show you how to find the leak. \n\n'
                              'Fix that leak! A showerhead that leaks 10 drips per minute wastes more than 500 gallons per year. That’s 60 loads of dishes in your dishwasher! Grab some pipe tape and a wrench and make sure that connection is tight. \n\n'
                              'If your toilet is leaking, you usually just need to replace the flapper. Over time, this inexpensive rubber part decays, or minerals build up on it. It’s usually best to replace the whole rubber flapper—a relatively easy, inexpensive do-it-yourself project (see steps in the link immediately above) that pays for itself in no time. \n\n',
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
