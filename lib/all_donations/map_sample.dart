import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:logging/logging.dart'; // Logging framework
import 'location_details.dart'; // Import your details page

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Set<Marker> markers = {};
  final Logger _logger = Logger('MapSample'); // Logger instance

  @override
  void initState() {
    super.initState();
    _loadLocations(); // Load locations initially
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Optionally load locations here if you want to refresh every time the widget is built
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    markers.clear(); // Clear existing markers to avoid duplicates
    _logger.info('Loading locations from Firestore...');

    try {
      // Fetch locations from Firestore
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('requests').get();

      // Create markers from fetched locations
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;

        // Check if 'location' field exists and is a Map
        if (data.containsKey('location') &&
            data['location'] is Map<String, dynamic>) {
          Map<String, dynamic> locationData = data['location'];

          // Safely extract latitude and longitude
          double lat = (locationData['latitude'] is num)
              ? (locationData['latitude'] as num).toDouble()
              : 0.0;
          double lng = (locationData['longitude'] is num)
              ? (locationData['longitude'] as num).toDouble()
              : 0.0;

          String name = data['name'] ?? 'Unknown';
          String locationName =
              locationData['locationName'] ?? 'Unknown Location';
          String contact = data['contact'] ?? 'Unknown Contact';
          String waterType = data['waterType'] ?? 'Unknown';
          String urgencyLevel = data['urgencyLevel'] ?? 'Unknown';
          String uid = data['uid'] ?? 'Unknown UID'; // User ID
          String email = data['email'] ?? 'Unknown Email'; // User Email
          String address = data['address'] ?? 'Unknown Address'; // User Address
          String description =
              data['description'] ?? 'No Description'; // User Description
          String requestId = doc.id; // Firestore document ID as requestId

          _logger.fine('Adding marker for $name at $locationName ($lat, $lng)');

          // Add a marker for each document
          markers.add(Marker(
            markerId: MarkerId(doc.id),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(
              title: name,
              snippet: locationName,
              onTap: () {
                // Navigate to location_details.dart and pass the relevant data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LocationDetails(
                      name: name,
                      locationName: locationName,
                      contact: contact,
                      waterType: waterType,
                      urgencyLevel: urgencyLevel,
                      uid: uid, // Pass the UID
                      email: email, // Pass the email
                      address: address, // Pass the address
                      description: description, // Pass the description
                      latitude: lat,
                      longitude: lng,
                      requestId: requestId, // Pass the requestId
                    ),
                  ),
                );
              },
            ),
          ));
        } else {
          _logger.warning(
              'Location data missing or invalid for document: ${doc.id}');
        }
      }

      _logger.info('${markers.length} markers added.');
      // Update state to reflect the new markers on the map
      setState(() {});
    } catch (e) {
      _logger.severe('Error loading locations from Firestore: $e');
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading locations: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation Map'),
        backgroundColor: const Color(0xff90E0EF),
      ),
      body: GoogleMap(
        mapType: MapType.normal, // Adjust map type if necessary
        initialCameraPosition: const CameraPosition(
          target: LatLng(6.9271, 79.8612), // Default location (Colombo)
          zoom: 10, // Adjust zoom level
        ),
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
