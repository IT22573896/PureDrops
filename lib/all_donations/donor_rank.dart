import 'package:Puredrops/all_donations/map_sample.dart';
import 'package:Puredrops/authentication/profile_screen.dart';
import 'package:Puredrops/donation_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Puredrops/home_screen.dart';
import 'package:Puredrops/custom_navigation_bar.dart';
import 'package:Puredrops/notifications_screen.dart';

class DonorRank extends StatefulWidget {
  const DonorRank({super.key});

  @override
  _DonorRankState createState() => _DonorRankState();
}

class _DonorRankState extends State<DonorRank> {
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

  Map<String, int> donorCounts =
      {}; // Map to store donor names and their donation counts

  @override
  void initState() {
    super.initState();
    fetchDonorData(); // Fetch donor data when the page initializes
  }

  // Fetch donations from Firestore and count donations per donor
  Future<void> fetchDonorData() async {
    QuerySnapshot donationsSnapshot =
        await FirebaseFirestore.instance.collection('donations').get();

    // Group donations by cardHolderName and count them
    Map<String, int> donorMap = {};
    for (var doc in donationsSnapshot.docs) {
      String cardHolderName = doc['cardHolderName'];
      if (donorMap.containsKey(cardHolderName)) {
        donorMap[cardHolderName] = donorMap[cardHolderName]! + 1;
      } else {
        donorMap[cardHolderName] = 1;
      }
    }

    // Sort the map by donation counts in descending order
    donorMap = Map.fromEntries(
      donorMap.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );

    setState(() {
      donorCounts = donorMap;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image container
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/rank_list.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Back button at the top left
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Navigate back to the previous screen
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
          ),
          // Notifications button at the top right
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
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
          ),

          // The donor rank list overlaid on the background
          donorCounts.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding:
                      const EdgeInsets.only(top: 120), // Add space at the top
                  child: Column(
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Donor Rank',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Baloo 2',
                              color: Color(0xFF000000),
                            ),
                          ),
                          // Sub title
                          Padding(
                            padding: EdgeInsets.only(top: 1),
                            child: Text(
                              'Make Your Impact Count',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Outfit',
                                color: Color(0xFF757575),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Header - Top Donor Card
                      if (donorCounts.isNotEmpty)
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Colors.white, // Left side: white
                                Color.fromARGB(
                                    255, 22, 67, 183), // Right side: light blue
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const CircleAvatar(
                                radius: 30,
                                backgroundColor:
                                    Color.fromARGB(255, 108, 181, 223),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                  size: 40,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                donorCounts.keys.first, // Top Donor Name
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 10, 43, 82),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${donorCounts[donorCounts.keys.first]} Points', // Top Donor Points
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(137, 0, 3, 18),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(5, (index) {
                                  return const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 20,
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),

                      // Text Row: "Donor", "Points", "Ratings"
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Donor',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Points',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Ratings',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 1.5,
                              height: 20, // Space between the row and the line
                            ),
                          ],
                        ),
                      ),

                      // Donor List - Exclude the Top Donor
                      Expanded(
                        child: ListView.builder(
                          itemCount:
                              donorCounts.length - 1, // Exclude top donor
                          itemBuilder: (context, index) {
                            String donorName = donorCounts.keys.elementAt(
                                index + 1); // Start from second donor
                            int donationCount = donorCounts[donorName]!;

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Colors.white, // Left side: white
                                      Color.fromARGB(255, 79, 144,
                                          198), // Right side: light blue
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                                child: Card(
                                  elevation: 10, // Remove shadow from Card
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ListTile(
                                    leading: const CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 166, 193, 211),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                    ),
                                    title: Text(
                                      donorName,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '$donationCount Points',
                                      style: const TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(5, (index) {
                                        return const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 20,
                                        );
                                      }),
                                    ),
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
          // Custom bottom navigation bar
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
