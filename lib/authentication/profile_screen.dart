import 'package:Puredrops/all_donations/donation_history.dart';
import 'package:Puredrops/authentication/sign_in_screen.dart';
import 'package:Puredrops/home_screen.dart';
import 'package:Puredrops/make_request/request_list.dart';
import 'package:Puredrops/notifications_screen.dart';
import 'package:Puredrops/settings_screen.dart';
import 'package:Puredrops/water_consumption_questions/todays_usage_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  String? contact;
  String? name;
  String? email;
  String? location =
      'Galle / Sri Lanka'; // Example location, replace with Firestore value if needed

  @override
  void initState() {
    super.initState();
    _loadUserData(); // load user data
    email = user?.email;
  }

  Future<void> _loadUserData() async {
    if (user != null) {
      // Fetch additional user details from Firestore
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .get();

      setState(() {
        name = userData['name'];
        contact = userData['contact'];
      });
    }
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
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const HomeScreen(), // Replace with your HomeScreen widget
                          ),
                        );
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
                          Icons.home_sharp,
                          color: Color(0xFF02055A),
                          size: 30,
                        ),
                      ),
                    ),
                    const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize
                            .min, // Optional: minimizes the vertical space taken by the column
                        children: [
                          Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Baloo 2',
                              color: Color(0xFF000000),
                            ),
                          ),
                          SizedBox(
                            height: 1, // Space between title and subtitle
                          ),
                          Text(
                            'Be a water saver',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Outfit',
                              color: Color.fromARGB(255, 117, 117, 117),
                            ),
                            textAlign: TextAlign
                                .center, // Aligns the subtitle text to the center
                          ),
                        ],
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
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
                          offset:
                              const Offset(0, 20), // Move the icon 10 pixels up
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

                // Profile Details and usage, donations, requests, goals
                Positioned(
                  top: -10,
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              const CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 242, 243, 245),
                                radius: 50,
                                backgroundImage: AssetImage(
                                    'assets/Avatar.png'), // Replace with user image
                              ),
                              const SizedBox(height: 10),
                              Text(
                                name ?? "User Name",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              // logout button
                              ElevatedButton(
                                onPressed: () async {
                                  await FirebaseAuth.instance.signOut();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignInScreen()),
                                    (route) =>
                                        false, // This clears all the previous routes
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff03045E),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Text(
                                  "Log out",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 14),

                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: const Color.fromARGB(255, 202, 239, 250),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                _infoRow(
                                    Icons.email, "Email", email ?? "No Email"),
                                _infoRow(Icons.phone, "Contact",
                                    contact ?? "No contact provided"),
                                _infoRow(Icons.location_on, "Location",
                                    "Galle / Sri Lanka"),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Today's Usage, My Donations, My Requests, My Goals section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TodaysUsageScreen(), // Replace with your My Goals screen
                                  ),
                                );
                              },
                              child:
                                  _infoCard(Icons.water_drop, "Usage History"),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const DonationHistory(), // Replace with your My Goals screen
                                  ),
                                );
                              },
                              child: _infoCard(Icons.favorite, "My Donations"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RequestsListPage(), // Replace with your My Requests screen
                                  ),
                                );
                              },
                              child: _infoCard(Icons.handshake, "My Requests"),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Show a dialog instead of navigating
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      title: const Row(
                                        children: [
                                          Icon(Icons.lock,
                                              color: Color(0xffFCA311),
                                              size: 30),
                                          SizedBox(width: 10),
                                          Text(
                                            'Premium Feature',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      content: const Text(
                                        'The "My Goals" feature is available on Personalized Goal Setting feature. That is only for premium users. Please upgrade your plan to access this feature.',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      actions: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: const Color(
                                                0xffFCA311), // Button background color
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                          },
                                          child: const Text(
                                            'Close',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: _infoCard(Icons.shower, "My Goals"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Saving water, \none drop at a time!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'RobotoMono'),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                // ---------------
              ],
            ),
          ))
        ],
      ),
    );
  }
}

Widget _infoRow(IconData icon, String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Icon(icon, color: const Color.fromARGB(255, 3, 39, 100)),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 158, 158, 158),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _infoCard(IconData icon, String title) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: SizedBox(
      width: 130,
      height: 105,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blueAccent),
            const SizedBox(height: 2),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    ),
  );
}
