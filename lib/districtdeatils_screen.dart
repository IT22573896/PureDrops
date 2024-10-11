import 'package:Puredrops/all_donations/map_sample.dart';
import 'package:Puredrops/home_screen.dart';
import 'package:flutter/material.dart';
import 'donation_screen.dart'; // Import Donations Page
import 'districtmore_details/district_more_details_page1.dart'; // Import the Anuradhapura Page
import 'districtmore_details/Polonnaruwa.dart'; // Import the Polonnaruwa Page
import 'districtmore_details/Moneragala.dart'; // Import the Moneragala Page
import 'districtmore_details/Ampara.dart'; // Import the Ampara Page
import 'districtmore_details/Batticaloa.dart'; // Import the Batticaloa Page
import 'districtmore_details/Trincomalee.dart'; // Import the Trincomalee Page
import 'districtmore_details/Hambantota.dart'; // Import the Hambantota Page
import 'districtmore_details/Puttalam.dart'; // Import the Puttalam Page
import 'districtmore_details/Nuwara Eliya.dart'; // Import the Nuwara Eliya Page
import 'districtmore_details/Badulla.dart'; // Import the Badulla Page
import 'districtmore_details/Mannar.dart'; // Import the Mannar Page
import 'districtmore_details/Ratnapura.dart'; // Import the Ratnapura Page
import 'custom_navigation_bar.dart'; // Import the custom bottom navigation bar
import 'package:Puredrops/authentication/profile_screen.dart';

class DistrictdetailsScreen extends StatefulWidget {
  const DistrictdetailsScreen({super.key});

  @override
  State<DistrictdetailsScreen> createState() => _DistrictdetailsScreenState();
}

class _DistrictdetailsScreenState extends State<DistrictdetailsScreen> {
  int _selectedIndex = 0;
  String _searchText = "";
  final List<Map<String, String>> districts = [
    {
      'name': 'Anuradhapura District ',
      'image': 'assets/district/Anuradhapura.jpg',
      'resources':
          '• Total water Needs - 750 households\n• Water Availbility - 60% \n• Water Quelity Status - High'
    },
    {
      'name': 'Polonnaruwa District',
      'image': 'assets/district/Polonnaruwa.jpg',
      'resources':
          '• Total water Needs - 120 households\n• Water Availbility - 80% \n• Water Quelity Status - Moderate'
    },
    {
      'name': 'Moneragala District',
      'image': 'assets/district/Moneragala.jpg',
      'resources':
          '• Total water Needs - 550 households\n• Water Availbility - 60% \n• Water Quelity Status - High'
    },
    {
      'name': 'Ampara District',
      'image': 'assets/district/Ampara.jpg',
      'resources':
          '• Total water Needs - 400 households\n• Water Availbility - 60% \n• Water Quelity Status - High'
    },
    {
      'name': 'Batticaloa District',
      'image': 'assets/district/Batticaloa.jpg',
      'resources':
          '• Total water Needs - 400 households\n• Water Availbility - 70% \n• Water Quelity Status - Moderate'
    },
    {
      'name': 'Trincomalee District',
      'image': 'assets/district/Trincomalee.jpg',
      'resources':
          '• Total water Needs - 300 households\n• Water Availbility - 72% \n• Water Quelity Status - High'
    },
    {
      'name': 'Hambantota District',
      'image': 'assets/district/Hambantota.jpg',
      'resources':
          '• Total water Needs - 350 households\n• Water Availbility - 73% \n• Water Quelity Status - Moderate'
    },
    {
      'name': 'Puttalam District',
      'image': 'assets/district/Puttalam.jpg',
      'resources':
          '• Total water Needs - 750 households\n• Water Availbility - 74% \n• Water Quelity Status - High'
    },
    {
      'name': 'Nuwara Eliya District',
      'image': 'assets/district/Nuwara Eliya.jpg',
      'resources':
          '• Total water Needs - 750 households\n• Water Availbility - 75% \n• Water Quelity Status - Moderate'
    },
    {
      'name': 'Badulla District',
      'image': 'assets/district/Badulla.jpg',
      'resources':
          '• Total water Needs -600 households\n• Water Availbility - 78% \n• Water Quelity Status - Moderate'
    },
    {
      'name': 'Mannar District',
      'image': 'assets/district/Mannar.jpg',
      'resources':
          '• Total water Needs - 200 households\n• Water Availbility - 78% \n• Water Quelity Status - Moderate'
    },
    {
      'name': 'Ratnapura District',
      'image': 'assets/district/Ratnapura.jpg',
      'resources':
          '• Total water Needs - 100 households\n• Water Availbility - 79% \n• Water Quelity Status - Moderate'
    },
  ];

  List<Map<String, String>> get filteredDistricts {
    if (_searchText.isEmpty) {
      return districts;
    } else {
      return districts
          .where((district) => district['name']!
              .toLowerCase()
              .contains(_searchText.toLowerCase()))
          .toList();
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Profile_Screen.png'),
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
                            'District Details',
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
                              'Explore the Districts',
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
                      GestureDetector(
                        onTap: () {
                          // Navigate to settings screen
                        },
                        child: const Icon(
                          Icons.settings,
                          color: Colors.black,
                          size: 36,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Search bar
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchText = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search Districts...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // List of districts
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(8.0),
                      children: filteredDistricts.map((district) {
                        return _buildDistrictCard(
                          context,
                          district['name']!,
                          district['image']!,
                          district['resources']!,
                        );
                      }).toList(),
                    ),
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

  Widget _buildDistrictCard(BuildContext context, String districtName,
      String imagePath, String resourceDetails) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 200, // Adjust the height as needed
              width: double.infinity,
            ),
          ),
          Container(
            height: 200, // Same as the image height
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    districtName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  ...resourceDetails.split('\n').map((detail) {
                    return Text(
                      detail,
                      style: const TextStyle(color: Colors.white),
                    );
                  }),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _navigateToDistrictPage(context, districtName);
                        },
                        child: const Text('More'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DonationScreen()),
                          );
                        },
                        child: const Text('Donate'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDistrictPage(BuildContext context, String districtName) {
    if (districtName.contains('Anuradhapura')) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const DistrictMoreDetailsPage()),
      );
    } else if (districtName.contains('Polonnaruwa')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Polonnaruwa()),
      );
    } else if (districtName.contains('Moneragala')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Moneragala()),
      );
    } else if (districtName.contains('Ampara')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Ampara()),
      );
    } else if (districtName.contains('Batticaloa')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Batticaloa()),
      );
    } else if (districtName.contains('Trincomalee')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Trincomalee()),
      );
    } else if (districtName.contains('Hambantota')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Hambantota()),
      );
    } else if (districtName.contains('Puttalam')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Puttalam()),
      );
    } else if (districtName.contains('Nuwara Eliya')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NuwaraEliya()),
      );
    } else if (districtName.contains('Badulla')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Badulla()),
      );
    } else if (districtName.contains('Mannar')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Mannar()),
      );
    } else if (districtName.contains('Ratnapura')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Ratnapura()),
      );
    }
  }
}
