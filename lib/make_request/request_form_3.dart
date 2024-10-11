import 'package:Puredrops/all_donations/map_sample.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:Puredrops/make_request/request_list.dart';
import 'package:Puredrops/settings_screen.dart';
import 'package:Puredrops/custom_navigation_bar.dart';
import 'package:Puredrops/home_screen.dart';
import 'package:Puredrops/authentication/profile_screen.dart';
import 'package:Puredrops/donation_screen.dart';

class RequestForm3 extends StatefulWidget {
  final String name;
  final String email;
  final String contact;
  final String address;
  final String waterType;
  final String description;
  final String urgencyLevel;

  const RequestForm3({
    super.key,
    required this.name,
    required this.email,
    required this.contact,
    required this.address,
    required this.waterType,
    required this.description,
    required this.urgencyLevel,
  });

  @override
  _RequestForm3State createState() => _RequestForm3State();
}

class _RequestForm3State extends State<RequestForm3> {
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

  LatLng _selectedLocation =
      const LatLng(6.9271, 79.8612); // Default position (Colombo)
  late GoogleMapController _mapController;
  final TextEditingController _locationController =
      TextEditingController(); // Text field controller
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Firestore instance
  final FirebaseAuth _auth = FirebaseAuth.instance; // FirebaseAuth instance

  // Method to save the request details with location
  Future<void> _saveRequestDetails() async {
    try {
      User? user = _auth.currentUser; // Get the current logged-in user

      if (user == null) {
        // If user is not authenticated, show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('You need to be logged in to submit a request')),
        );
        return;
      }

      // Reverse geocoding to get the location name (address) from latitude and longitude
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _selectedLocation.latitude,
        _selectedLocation.longitude,
      );

      String locationName = '';
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        locationName = '${place.street}, ${place.locality}, ${place.country}';
      }

      // Prepare data to be saved
      Map<String, dynamic> requestData = {
        'uid': user.uid, // Include user's unique ID
        'name': widget.name,
        'email': widget.email,
        'contact': widget.contact,
        'address': widget.address,
        'waterType': widget.waterType,
        'description': widget.description,
        'urgencyLevel': widget.urgencyLevel,
        'location': {
          'latitude': _selectedLocation.latitude,
          'longitude': _selectedLocation.longitude,
          'locationName': locationName, // Add the location name to Firestore
        },
      };

      // Save data to Firestore
      await _firestore.collection('requests').add(requestData);

      // Show confirmation dialog
      _showConfirmationDialog();
    } catch (e) {
      // Error handling
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting request: $e')),
      );
    }
  }

  // Method to show confirmation dialog
  // Show confirmation dialog
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Request Submitted'),
          content: const Text('Your request has been submitted successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) =>
                          const RequestsListPage()), // Navigate to the request list page
                );
              },
              child: const Text('Go to Requests'),
            ),
          ],
        );
      },
    );
  }

  // Method to search for location by address
  Future<void> _searchLocation() async {
    try {
      String address = _locationController.text;
      List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        // Update the selected location on map
        setState(() {
          _selectedLocation =
              LatLng(locations.first.latitude, locations.first.longitude);
        });

        // Move the map camera to the new location
        _mapController.moveCamera(CameraUpdate.newLatLng(_selectedLocation));

        // Clear text field after location is found
        _locationController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location not found')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter location: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image (You can modify this based on your needs)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Profile_Screen.png'),
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
                            'Location ',
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
                              'Pinpoint your location on the map to \ncomplete your request',
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

                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: _locationController,
                            decoration: InputDecoration(
                              hintText: 'Select Location',
                              filled: true,
                              fillColor: const Color(0xffCAF0F8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: IconButton(
                                icon: const Icon(Icons.search,
                                    color: Color(0xFF03045E)),
                                onPressed:
                                    _searchLocation, // Search when button pressed
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 380,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: _selectedLocation,
                              zoom: 14.0,
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              _mapController = controller;
                            },
                            markers: {
                              Marker(
                                markerId: const MarkerId('currentLocation'),
                                position: _selectedLocation,
                                draggable: true,
                                onDragEnd: (newPosition) {
                                  setState(() {
                                    _selectedLocation = newPosition;
                                    // Move camera to the new marker position
                                    _mapController.moveCamera(
                                        CameraUpdate.newLatLng(newPosition));
                                  });
                                },
                              ),
                            },
                          ),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF03045E),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                          ),
                          onPressed:
                              _saveRequestDetails, // Save data when button pressed
                          child: const Text(
                            'Submit Request',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF), // Button text color
                              fontSize: 16, // Button text size
                            ),
                          ),
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
