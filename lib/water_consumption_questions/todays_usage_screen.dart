import 'package:Puredrops/all_donations/map_sample.dart';
import 'package:Puredrops/authentication/profile_screen.dart';
import 'package:Puredrops/custom_navigation_bar.dart';
import 'package:Puredrops/donation_screen.dart';
import 'package:Puredrops/home_screen.dart';
import 'package:Puredrops/notifications_screen.dart';
import 'package:Puredrops/settings_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodaysUsageScreen extends StatefulWidget {
  const TodaysUsageScreen({super.key});

  @override
  State<TodaysUsageScreen> createState() => _TodaysUsageScreenState();
}

class _TodaysUsageScreenState extends State<TodaysUsageScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  bool _isLoading = true;
  List<QueryDocumentSnapshot> _waterUsageList = [];

  @override
  void initState() {
    super.initState();
    _fetchWaterUsages();
  }

  // Method to fetch water usage data
  Future<void> _fetchWaterUsages() async {
    try {
      // Fetch water usages where the userId matches the current user's ID
      var querySnapshot = await _db
          .collection('water_usage')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      // Update the state with fetched data
      setState(() {
        _waterUsageList = querySnapshot.docs;
        _isLoading = false;
      });
    } catch (e) {
      // Handle any errors
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching water usage: $e')),
      );
    }
  }

  int _selectedIndex = 0;

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
                image: AssetImage('assets/Water_Consumption_Feature.png'),
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
                          );
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
                  // Title section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Consumption',
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
                              'Reduce water usage can \nreduce your water bill',
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
                            );
                          },
                          child: Transform.translate(
                            offset: const Offset(0, -10),
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

                  // Water Usage Data
                  _isLoading
                      ? const Center(
                          child: CircularProgressIndicator()) // Loading state
                      : _waterUsageList.isEmpty
                          ? const Center(
                              child: Text(
                                  'No water usage records found.')) // No data
                          : Expanded(
                              child: ListView.builder(
                                itemCount: _waterUsageList.length,
                                itemBuilder: (context, index) {
                                  var waterUsage = _waterUsageList[index];
                                  var gallonCount = waterUsage['gallonCount'];
                                  var timestamp =
                                      (waterUsage['timestamp'] as Timestamp)
                                          .toDate();

                                  // Format date and time using intl
                                  var formattedDate =
                                      DateFormat('MMMM dd, yyyy')
                                          .format(timestamp);
                                  var formattedTime =
                                      DateFormat('hh:mm a').format(timestamp);

                                  return Card(
                                    margin: const EdgeInsets.only(bottom: 16.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    elevation: 5.0,
                                    child: Container(
                                      // Add padding, background color, and border radius
                                      padding: const EdgeInsets.all(
                                          10.0), // Padding for the content
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 122,
                                            224, 238), // Background color
                                        borderRadius: BorderRadius.circular(
                                            18.0), // Border radius
                                      ),
                                      child: ListTile(
                                        leading: const Icon(Icons.water_drop),
                                        title: Text(
                                          '$gallonCount gallons',
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        subtitle: Text(
                                          'Recorded on: \n$formattedDate at $formattedTime',
                                          style: const TextStyle(
                                              fontFamily: 'Baloo2'),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
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
    );
  }
}
