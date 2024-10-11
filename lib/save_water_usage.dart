import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SaveWaterUsage {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save gallon count with user's id and timestamp
  Future<void> saveWaterUsage(BuildContext context, int gallonCount) async {
    try {
      // Get current user ID from FirebaseAuth
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Create a document in Firestore with the user's ID and gallon count
      await _db.collection('water_usage').add({
        'userId': userId,
        'gallonCount': gallonCount,
        'timestamp': FieldValue.serverTimestamp(), // Save current time
      });

      // Show success SnackBar
      _showSnackBar(context,
          'Success: Your water usage of $gallonCount gallons has been saved!',
          isError: false);
    } catch (e) {
      // Show error SnackBar
      _showSnackBar(
          context, 'Error: Failed to save water usage. Please try again later.',
          isError: true);
    }
  }

  // Helper method to show SnackBar
  void _showSnackBar(BuildContext context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
