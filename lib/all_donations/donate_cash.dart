import 'package:Puredrops/all_donations/map_sample.dart';
import 'package:Puredrops/authentication/profile_screen.dart';
import 'package:Puredrops/donation_screen.dart';
import 'package:flutter/material.dart';
import 'package:Puredrops/custom_navigation_bar.dart'; // Ensure correct path for CustomBottomNavBar
import 'package:Puredrops/home_screen.dart';
import 'package:Puredrops/notifications_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class DonateCash extends StatefulWidget {
  final String requestId;

  const DonateCash({super.key, required this.requestId});

  @override
  _DonateCashState createState() => _DonateCashState();
}

class _DonateCashState extends State<DonateCash> {
  int _selectedIndex = 0; // Initialize _selectedIndex for the bottom navigation

  // Controllers for form fields
  final TextEditingController amountController = TextEditingController();
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();

  // Method to handle bottom navigation tap
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

  // Validate the form fields
  bool _validateFields() {
    if (amountController.text.isEmpty) {
      _showErrorDialog("Please enter the donation amount.");
      return false;
    }
    if (cardHolderController.text.isEmpty) {
      _showErrorDialog("Please enter the cardholder's name.");
      return false;
    }
    if (cardNumberController.text.isEmpty ||
        cardNumberController.text.length < 16) {
      _showErrorDialog("Please enter a valid card number (16 digits).");
      return false;
    }
    if (cvvController.text.isEmpty || cvvController.text.length < 3) {
      _showErrorDialog("Please enter a valid CVV (3 digits).");
      return false;
    }
    if (expiryDateController.text.isEmpty) {
      _showErrorDialog("Please select an expiration date.");
      return false;
    }
    return true;
  }

  // Show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  // Method to select date from date picker
  Future<void> _selectExpiryDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        // Format the selected date as MM/YY
        String formattedDate =
            "${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year.toString().substring(2)}";
        expiryDateController.text = formattedDate;
      });
    }
  }

  // Method to submit donation data to Firestore
  Future<void> _submitDonation() async {
    if (_validateFields()) {
      try {
        // Get a reference to Firestore
        CollectionReference donations =
            FirebaseFirestore.instance.collection('donations');

        // Prepare the donation data
        Map<String, dynamic> donationData = {
          'requestId': widget.requestId,
          'amount': amountController.text, // Add amount to donation data
          'cardHolderName': cardHolderController.text,
          'cardNumber': cardNumberController.text,
          'cvv': cvvController.text,
          'expiryDate': expiryDateController.text,
          'timestamp': FieldValue.serverTimestamp(), // Optional: add timestamp
        };

        // Add the donation data to Firestore
        await donations.add(donationData);

        // Show success message
        _showSuccessDialog("Donation submitted successfully!");

        // Clear the fields after successful submission
        amountController.clear();
        cardHolderController.clear();
        cardNumberController.clear();
        cvvController.clear();
        expiryDateController.clear();
      } catch (e) {
        _showErrorDialog("Failed to submit donation: $e");
      }
    }
  }

  // Show success dialog
  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Success"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Print the passed requestId for debugging
    print('Passed Request ID: ${widget.requestId}');

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/back_cash.png'),
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
                              'Cash Donation',
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
                          // Display the requestId instead of uid
                          _buildDetailBox(Icons.confirmation_number,
                              'Request ID', widget.requestId),
                          const SizedBox(height: 20),

                          // Credit Card Details Input Form
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 184, 220, 227)
                                  .withOpacity(0.8),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Credit Card Details',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF02055A),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                // Add the credit card image here
                                Center(
                                  child: Image.asset(
                                    'assets/black_credit.png', // Ensure the correct path for your image
                                    width: 450, // Adjust the width as necessary
                                    height:
                                        200, // Adjust the height as necessary
                                  ),
                                ),
                                const SizedBox(height: 20),
                                _buildTextField(
                                  'Cardholder Name',
                                  cardHolderController,
                                ),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  'Card Number',
                                  cardNumberController,
                                  obscureText: true,
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  'CVV',
                                  cvvController,
                                  obscureText: true,
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(height: 16),
                                GestureDetector(
                                  onTap: () => _selectExpiryDate(context),
                                  child: AbsorbPointer(
                                    child: _buildTextField(
                                      'Expiration Date (MM/YY)',
                                      expiryDateController,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Donation Amount Input Form
                                _buildTextField(
                                  'Donation Amount',
                                  amountController,
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(height: 20),
                                // Center the ElevatedButton and set its background color
                                Center(
                                  child: ElevatedButton(
                                    onPressed: _submitDonation,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(
                                          0xFF03045E), // Set the background color
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 16),
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
                                    child: const Text(
                                      'Pay',
                                      style: TextStyle(
                                          color: Colors
                                              .white), // Set the text color to white
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 50),
                              ],
                            ),
                          ),
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

  // Build Text Field
  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscureText = false,
      TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }

  // Build Icon Button
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

  // Build Detail Box
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
}
