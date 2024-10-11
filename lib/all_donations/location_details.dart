import 'package:Puredrops/all_donations/map_sample.dart';
import 'package:Puredrops/authentication/profile_screen.dart';
import 'package:Puredrops/donation_screen.dart';
import 'package:flutter/material.dart';
import 'package:Puredrops/home_screen.dart';
import 'package:Puredrops/notifications_screen.dart';
import 'package:Puredrops/custom_navigation_bar.dart';
import 'package:Puredrops/all_donations/donate_cash.dart'; // Import the donate_cash.dart file

class LocationDetails extends StatefulWidget {
  final String name;
  final String locationName;
  final String contact;
  final String waterType;
  final String urgencyLevel;
  final String uid;
  final String email;
  final String address;
  final String description;
  final double latitude;
  final double longitude;
  final String requestId; // Add requestId here

  const LocationDetails({
    super.key,
    required this.name,
    required this.locationName,
    required this.contact,
    required this.waterType,
    required this.urgencyLevel,
    required this.uid,
    required this.email,
    required this.address,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.requestId, // Add requestId to constructor
  });

  @override
  _LocationDetailsState createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
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
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: _buildIconButton(
                          Icons.arrow_back_ios_new,
                          const Color(0xff90E0EF),
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
                        child: _buildIconButton(
                          Icons.notifications,
                          Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Donation Details',
                              style: TextStyle(
                                color: Color.fromARGB(255, 10, 59, 90),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            color: Color(0xFF02055A),
                            thickness: 2,
                            indent: 100,
                            endIndent: 100,
                          ),
                          const SizedBox(height: 20),
                          _buildSectionHeader('Personal Details'),
                          _buildDetailBox(
                              Icons.account_circle, 'User ID', widget.uid),
                          _buildDetailBox(
                              Icons.confirmation_number,
                              'Request ID',
                              widget.requestId), // Display Request ID
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: _buildDetailBox(
                                    Icons.person, 'Name', widget.name),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildDetailBox(
                                    Icons.home, 'Address', widget.address),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          _buildSectionHeader('Contact Details'),
                          _buildDetailBox(
                              Icons.phone, 'Contact', widget.contact),
                          const SizedBox(width: 10),
                          _buildDetailBox(Icons.email, 'Email', widget.email),
                          const SizedBox(height: 10),
                          _buildSectionHeader('Request Details'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: _buildDetailBox(Icons.location_on,
                                    'Location', widget.locationName),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildDetailBox(Icons.water,
                                    'Water Type', widget.waterType),
                              ),
                            ],
                          ),
                          _buildDetailBox(Icons.warning, 'Urgency Level',
                              widget.urgencyLevel),
                          const SizedBox(height: 10),
                          _buildDetailBox(Icons.description, 'Description',
                              widget.description),
                          const SizedBox(height: 20),
                          _buildDonateButton(), // Donate Button
                          const SizedBox(
                              height: 80), // This adds the extra space
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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

  // This method builds the Donate button and handles the navigation to donate_cash.dart
  Widget _buildDonateButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          // Navigate to donate_cash.dart and pass the requestId
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DonateCash(
                requestId: widget
                    .requestId, // Pass the Request ID from the current request
              ),
            ),
          );
        },
        icon: const Icon(
          Icons.monetization_on,
          color: Color.fromARGB(255, 139, 193, 209),
        ),
        label: const Text(
          'Donate',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF03045E), // Updated background color
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, Color bgColor) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: bgColor,
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
      child: Icon(
        icon,
        color: const Color(0xFF02055A),
        size: 24,
      ),
    );
  }

  Widget _buildDetailBox(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFCAF0F8).withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon,
                color: const Color.fromARGB(255, 24, 79, 173), size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF02055A),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF02055A),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF02055A),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
