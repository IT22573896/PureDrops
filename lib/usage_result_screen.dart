import 'package:Puredrops/home_screen.dart';
import 'package:Puredrops/notifications_screen.dart';
import 'package:Puredrops/save_water_usage.dart';
import 'package:Puredrops/settings_screen.dart';
import 'package:Puredrops/water_usage_tracker_screen.dart';
import 'package:flutter/material.dart';

class UsageResultScreen extends StatelessWidget {
  final int gallonCount;
  final int recommendedGallonCount = 600;

  const UsageResultScreen({super.key, required this.gallonCount});

  @override
  Widget build(BuildContext context) {
// Save water usage data when this screen is built
    SaveWaterUsage saveWaterUsage = SaveWaterUsage();
    saveWaterUsage.saveWaterUsage(context, gallonCount);

    // Check if the user's consumption was good or bad
    String message;
    if (gallonCount <= recommendedGallonCount) {
      message = "Great job! You are using water efficiently.";
    } else {
      message =
          "You exceeded the recommended water usage. \nTry to reduce your consumption.";
    }

    List<Map<String, String>> waterUsagePatterns = [
      {
        'title': 'Washing Machine Usage',
        'recommendation': 'Use full loads to save water.',
        'limit': '30-45 gallons per load'
      },
      {
        'title': 'Bathtubs for Bathing',
        'recommendation': 'Take showers instead of baths.',
        'limit': '70 gallons per bath'
      },
      {
        'title': 'Showering Time',
        'recommendation': 'Limit showers to 5-10 minutes.',
        'limit': '10-25 gallons per shower'
      },
      {
        'title': 'Lawn/Garden Watering',
        'recommendation':
            'Water during early morning or evening to avoid evaporation.',
        'limit': '2 gallons per minute'
      },
      {
        'title': 'Low-flow Toilets',
        'recommendation': 'Install low-flow toilets to reduce water waste.',
        'limit': '1.6 gallons per flush'
      },
      {
        'title': 'Kitchen Faucet Usage',
        'recommendation': 'Turn off the tap while scrubbing or cleaning.',
        'limit': '2.2 gallons per minute'
      },
      {
        'title': 'Swimming Pool',
        'recommendation': 'Use a pool cover to reduce water evaporation.',
        'limit': '19,000 gallons to fill a pool'
      },
      {
        'title': 'Pets Bathing',
        'recommendation': 'Bathe pets only when necessary.',
        'limit': '20-40 gallons per bath'
      },
      {
        'title': 'Dishwashing Method',
        'recommendation': 'Use a dishwasher instead of handwashing.',
        'limit': '4-6 gallons per cycle'
      },
      {
        'title': 'Washing Clothes',
        'recommendation': 'Do laundry only when you have a full load.',
        'limit': '30-45 gallons per load'
      },
    ];

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Usage_Result_Screen.png'),
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
                            'Water Usage Summary',
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
                              'Details of your Water Usage',
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

                  // Feedback message
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: gallonCount <= recommendedGallonCount
                            ? const Color(0xFF90E0EF)
                            : const Color(0xFFEE4E34),
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
                      child: Text(
                        message,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'SpaceGrotesk',
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // User's gallon count and recommended gallon count side by side
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 160,
                        height: 80,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF03045E),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                'Gallons Used',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 160,
                        height: 80,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0077B6),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$recommendedGallonCount',
                                style: const TextStyle(
                                  fontSize: 32,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'Recommended \nGallons',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
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
                            'Recommended Tips & Limits',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Baloo 2',
                              color: Color(0xFF000000),
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
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Show the Recommended limit of every usage way in a box (According to 10 questions)
                  // Display the recommended limits for each usage pattern
                  SizedBox(
                    height: 330, // Set your desired height here
                    child: ListView.builder(
                      itemCount: waterUsagePatterns.length,
                      itemBuilder: (context, index) {
                        final pattern = waterUsagePatterns[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                spreadRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pattern['title']!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                pattern['recommendation']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF4A4A4A),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Recommended Limit: ${pattern['limit']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF757575),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

// Buttons Row
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const WaterUsageTrackerScreen(),
                              ),
                            ); // Navigate to Start Screen
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Restart'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            ); // Navigate to Home Screen
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor:
                                const Color.fromARGB(255, 14, 166, 212),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Done'),
                        ),
                      ],
                    ),
                  ),
                  // ----
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
