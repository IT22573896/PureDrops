import 'package:Puredrops/all_donations/map_sample.dart';
import 'package:Puredrops/donation_screen.dart';
import 'package:Puredrops/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Puredrops/water_intake_page.dart';
import 'custom_navigation_bar.dart'; // Import custom bottom navigation bar
import 'package:Puredrops/authentication/profile_screen.dart';

class WaterIntakeList extends StatefulWidget {
  const WaterIntakeList({super.key});

  @override
  _WaterIntakeListState createState() => _WaterIntakeListState();
}

class _WaterIntakeListState extends State<WaterIntakeList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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

  // Delete an entry from Firestore
  Future<void> _deleteEntry(String docId) async {
    await FirebaseFirestore.instance
        .collection('water_intake')
        .doc(docId)
        .delete();
  }

  // Update an entry
  Future<void> _updateEntry(String docId, String newLiters) async {
    await FirebaseFirestore.instance
        .collection('water_intake')
        .doc(docId)
        .update({
      'liters': int.parse(newLiters),
    });
  }

  @override
  Widget build(BuildContext context) {
    String uid = _auth.currentUser!.uid;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/Profile_Screen.png'), // Add your background image here
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
                  // Top bar with back and settings icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back button
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
                      // Settings icon (aligned with the main heading)
                      GestureDetector(
                        onTap: () {
                          // Handle settings navigation here
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
                  // Page Heading
                  const Text(
                    'Water Drinking History',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Baloo 2',
                      color: Color(0xFF000000),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // StreamBuilder for displaying water intake history
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('water_intake')
                          .where('uid', isEqualTo: uid)
                          .orderBy('timestamp', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        var docs = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            var data =
                                docs[index].data() as Map<String, dynamic>;
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              color: const Color(
                                  0xFFB2EBF2), // Light blue color for the card
                              child: ListTile(
                                title: Text('Date: ${data['date']}'),
                                subtitle: Text(
                                    'Daily Water Drinking Amount (liters): ${data['liters']}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.blue),
                                      onPressed: () {
                                        _showUpdateDialog(
                                            context,
                                            docs[index].id,
                                            data['liters'].toString());
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.blue),
                                      onPressed: () =>
                                          _deleteEntry(docs[index].id),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
            bottom: 70), // Adjust position of the plus button
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
          onPressed: () {
            // Navigate to the WaterIntakeForm page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WaterIntakePage()),
            );
          },
        ),
      ),
    );
  }

  void _showUpdateDialog(
      BuildContext context, String docId, String currentLiters) {
    final TextEditingController litersController =
        TextEditingController(text: currentLiters);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Water Intake'),
          content: TextFormField(
            controller: litersController,
            decoration: const InputDecoration(labelText: 'Liters of Water'),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () {
                _updateEntry(docId, litersController.text);
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
