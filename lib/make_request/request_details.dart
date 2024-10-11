import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:Puredrops/make_request/timeline_page.dart';
import 'package:Puredrops/make_request/request_list.dart';

class RequestDetailsPage extends StatefulWidget {
  final Map<String, dynamic> requestData;
  final String requestId;

  const RequestDetailsPage(
      {super.key, required this.requestData, required this.requestId});

  @override
  _RequestDetailsPageState createState() => _RequestDetailsPageState();
}

class _RequestDetailsPageState extends State<RequestDetailsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _contactController;
  late TextEditingController _addressController;
  late TextEditingController _descriptionController;
  late TextEditingController _locationController;

  String _selectedWaterType = 'Drinking'; // Default value for water type
  String _selectedUrgencyLevel = 'Normal'; // Default value for urgency level

  LatLng _selectedLocation =
      const LatLng(0, 0); // Initialize with default coordinates
  late GoogleMapController _mapController;

  final List<String> _waterTypes = ['Drinking', 'Agriculture', 'Sanitation'];
  final List<String> _urgencyLevels = ['Normal', 'Urgent', 'Critical'];

  @override
  void initState() {
    super.initState();

    // Initialize all controllers with existing data
    _nameController = TextEditingController(text: widget.requestData['name']);
    _emailController = TextEditingController(text: widget.requestData['email']);
    _contactController =
        TextEditingController(text: widget.requestData['contact']);
    _addressController =
        TextEditingController(text: widget.requestData['address']);
    _descriptionController =
        TextEditingController(text: widget.requestData['description']);
    _selectedUrgencyLevel =
        widget.requestData['urgencyLevel'] ?? _selectedUrgencyLevel;
    _selectedWaterType = widget.requestData['waterType'] ?? _selectedWaterType;
    _locationController = TextEditingController(
        text: widget.requestData['location']['locationName']);
    _selectedLocation = LatLng(
      widget.requestData['location']['latitude'],
      widget.requestData['location']['longitude'],
    ); // Set the selected location from existing data
  }

  Future<void> _updateRequest() async {
    try {
      // Perform the Firestore update operation
      await _firestore.collection('requests').doc(widget.requestId).update({
        'name': _nameController.text,
        'email': _emailController.text,
        'contact': _contactController.text,
        'address': _addressController.text,
        'waterType': _selectedWaterType,
        'description': _descriptionController.text,
        'urgencyLevel': _selectedUrgencyLevel,
        'location.locationName': _locationController.text,
        'location.latitude': _selectedLocation.latitude,
        'location.longitude': _selectedLocation.longitude,
      });

      // Show confirmation dialog after a successful update
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Request Updated'),
            content: const Text('Your request has been successfully updated.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) =>
                            const RequestsListPage()), // Navigate to the request list page
                  ); // Navigate to request list page
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Show an error message in case of failure
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating request: $e')),
      );
    }
  }

  Future<void> _deleteRequest() async {
    try {
      await _firestore.collection('requests').doc(widget.requestId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request deleted successfully.')),
      );
      Navigator.pop(context); // Go back after deleting
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting request: $e')),
      );
    }
  }

  Future<void> _confirmDelete() async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this request?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
    if (confirm == true) {
      _deleteRequest();
    }
  }

  Future<void> _searchLocation() async {
    String locationQuery = _locationController.text;
    try {
      // Search for the location by name
      List<Location> locations = await locationFromAddress(locationQuery);
      if (locations.isNotEmpty) {
        Location loc = locations.first;
        setState(() {
          _selectedLocation = LatLng(loc.latitude, loc.longitude);
          _mapController.animateCamera(
              CameraUpdate.newLatLng(_selectedLocation)); // Move map camera
          _locationController.text = locationQuery; // Update location name
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location not found.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error searching location: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = _auth.currentUser;

    if (currentUser == null) {
      return const Scaffold(
        body: Center(
          child: Text('You must be logged in to view this page.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Request Details',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            fontFamily: 'Baloo 2',
            color: Color(0xFF000000),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _confirmDelete, // Trigger the confirmation dialog
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/Home_Screen.png'), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),

          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  prefixIcon:
                      const Icon(Icons.person, color: Color(0xFF03045E)),
                  filled: true,
                  fillColor: const Color(0xffCAF0F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  prefixIcon: const Icon(Icons.email, color: Color(0xFF03045E)),
                  filled: true,
                  fillColor: const Color(0xffCAF0F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _contactController,
                decoration: InputDecoration(
                  hintText: "Enter your contact no",
                  prefixIcon: const Icon(Icons.phone, color: Color(0xFF03045E)),
                  filled: true,
                  fillColor: const Color(0xffCAF0F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  hintText: "Enter your address",
                  prefixIcon:
                      const Icon(Icons.location_city, color: Color(0xFF03045E)),
                  filled: true,
                  fillColor: const Color(0xffCAF0F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedWaterType,
                decoration: InputDecoration(
                  hintText: "Select water type",
                  prefixIcon:
                      const Icon(Icons.water_drop, color: Color(0xFF03045E)),
                  filled: true,
                  fillColor: const Color(0xffCAF0F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: _waterTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedWaterType = value!;
                  });
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: "Enter description",
                  prefixIcon:
                      const Icon(Icons.description, color: Color(0xFF03045E)),
                  filled: true,
                  fillColor: const Color(0xffCAF0F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedUrgencyLevel,
                decoration: InputDecoration(
                  hintText: "Select urgency level",
                  prefixIcon: const Icon(Icons.priority_high_rounded,
                      color: Color(0xFF03045E)),
                  filled: true,
                  fillColor: const Color(0xffCAF0F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: _urgencyLevels.map((String level) {
                  return DropdownMenuItem<String>(
                    value: level,
                    child: Text(level),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedUrgencyLevel = value!;
                  });
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  hintText: "Enter Location",
                  prefixIcon:
                      const Icon(Icons.location_on, color: Color(0xFF03045E)),
                  filled: true,
                  fillColor: const Color(0xffCAF0F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                readOnly: false, // Allow user to enter location name
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF03045E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                onPressed: _searchLocation, // Search for location by name
                child: const Text(
                  'Search Location',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF), // Button text color
                    fontSize: 16, // Button text size
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300, // Set a fixed height for the map
                child: GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                    _mapController.moveCamera(CameraUpdate.newLatLng(
                        _selectedLocation)); // Move camera to selected location
                  },
                  initialCameraPosition: CameraPosition(
                    target: _selectedLocation,
                    zoom: 14,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('selectedLocation'),
                      position: _selectedLocation,
                    ),
                  },
                  onTap: (LatLng position) {
                    setState(() {
                      _selectedLocation = position;
                      _locationController.text =
                          "Selected location"; // Update the location text
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Adjusts the space between buttons
                children: [
                  // Update Button
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
                    onPressed: _updateRequest, // Trigger the update function
                    child: const Text(
                      'Update Request',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF), // Button text color
                        fontSize: 16, // Button text size
                      ),
                    ),
                  ),

                  // Track Button
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TimelinePage(
                            requestId: widget.requestId,
                            requestData: widget.requestData,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Track',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF), // Button text color
                        fontSize: 16, // Button text size
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}
