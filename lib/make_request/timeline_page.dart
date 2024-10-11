import 'package:Puredrops/all_donations/map_sample.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Puredrops/settings_screen.dart';
import 'package:Puredrops/custom_navigation_bar.dart';
import 'package:Puredrops/home_screen.dart';
import 'package:Puredrops/authentication/profile_screen.dart';
import 'package:Puredrops/donation_screen.dart';

class TimelinePage extends StatefulWidget {
  final String requestId;
  final Map<String, dynamic> requestData;

  const TimelinePage(
      {super.key, required this.requestId, required this.requestData});

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
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

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, String>> timelineStages = [
    {
      'title': 'Submitted',
      'description': 'Your request has been submitted and is under review.'
    },
    {'title': 'Approved', 'description': 'Your request has been approved.'},
    {
      'title': 'Donated',
      'description': 'The water supply has been donated to you.'
    },
    {
      'title': 'Completed',
      'description': 'Your request has been successfully completed.'
    },
  ];

  String currentStage = '';

  @override
  void initState() {
    super.initState();
    currentStage = widget.requestData['status'] ??
        'Submitted'; // Get current status of the request
  }

  Future<void> _updateStatus(String newStatus) async {
    try {
      await _firestore.collection('requests').doc(widget.requestId).update({
        'status': newStatus,
      });
      setState(() {
        currentStage = newStatus;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request status updated to $newStatus.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating status: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isCompleted =
        currentStage == 'Completed'; // Check if the request is completed

    return Scaffold(
      body: Stack(
        children: [
          // Background Image (You can modify this based on your needs)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg_request.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Overlay with widgets
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row with back and notifications button
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
                          // Implement navigation to Notifications screen
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

                  // Title and subtitle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Progress ',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Baloo 2',
                              color: Color(0xFF000000),
                            ),
                          ),
                          // Sub title
                          Padding(
                            padding: EdgeInsets.only(top: 1),
                            child: Text(
                              'Stay updated. \nFolllow the journey of your request \nevery step of the way',
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
                    height: 10,
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align to the left
                      children: [
                        const SizedBox(height: 24),
                        // Timeline Stages on the left and descriptions on the right
                        Container(
                          child: Column(
                            children:
                                List.generate(timelineStages.length, (index) {
                              // Determine if the stage should be active (highlighted)
                              bool isActive = isCompleted ||
                                  timelineStages[index]['title'] ==
                                      currentStage ||
                                  timelineStages.indexWhere((stage) =>
                                          stage['title'] == currentStage) >
                                      index;

                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Circular icon for each stage (left side)
                                  Column(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isActive
                                              ? const Color(0xFF03045E)
                                              : Colors.grey,
                                        ),
                                        child: const Icon(
                                          Icons.cloud,
                                          color: Colors.white,
                                        ),
                                      ),
                                      if (index < timelineStages.length - 1)
                                        Container(
                                          width: 2,
                                          height:
                                              40, // Height for the line between stages
                                          color: isActive
                                              ? const Color(0xFF03045E)
                                              : Colors.grey,
                                        ),
                                    ],
                                  ),
                                  const SizedBox(
                                      width:
                                          16), // Add spacing between icon and text
                                  // Title and Description (right side)
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          timelineStages[index]['title']!,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            fontFamily: 'Baloo 2',
                                            color: isActive
                                                ? const Color(0xFF03045E)
                                                : Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          timelineStages[index]['description']!,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Outfit',
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Buttons for updating status
                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // Centering buttons
                          children: [
                            if (currentStage == 'Submitted') // Submitted
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF03045E),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Rounded corners
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 15),
                                ),
                                onPressed: () => _updateStatus('Approved'),
                                child: const Text(
                                  'Approve',
                                  style: TextStyle(
                                    color:
                                        Color(0xFFFFFFFF), // Button text color
                                    fontSize: 16, // Button text size
                                  ),
                                ),
                              ),
                            if (currentStage == 'Approved') // Approved
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF03045E),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Rounded corners
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 15),
                                ),
                                onPressed: () => _updateStatus('Donated'),
                                child: const Text(
                                  'Donate',
                                  style: TextStyle(
                                    color:
                                        Color(0xFFFFFFFF), // Button text color
                                    fontSize: 16, // Button text size
                                  ),
                                ),
                              ),
                            if (currentStage == 'Donated') // Donated
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF03045E),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Rounded corners
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 15),
                                ),
                                onPressed: () => _updateStatus('Completed'),
                                child: const Text(
                                  'Mark as Completed',
                                  style: TextStyle(
                                    color:
                                        Color(0xFFFFFFFF), // Button text color
                                    fontSize: 16, // Button text size
                                  ),
                                ),
                              ),
                            if (currentStage == 'Completed') // Completed
                              Card(
                                color: Colors
                                    .white, // White background for the card
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners
                                ),
                                elevation: 4, // Adds shadow to the card
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      16.0), // Padding inside the card
                                  child: Row(
                                    children: [
                                      // Circle with Tick Icon
                                      Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(
                                              0xFF03045E), // Circle color (you can change this)
                                        ),
                                        padding: const EdgeInsets.all(
                                            8), // Padding inside the circle
                                        child: const Icon(
                                          Icons.check, // Tick icon
                                          color: Colors.white, // Icon color
                                        ),
                                      ),
                                      const SizedBox(
                                          width:
                                              16), // Space between icon and text
                                      // Status Text
                                      const Text(
                                        'Request is Completed.',
                                        style: TextStyle(
                                          fontFamily: 'Baloo 2',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black, // Text color
                                          fontSize: 16, // Text size
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
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
