import 'package:Puredrops/all_donations/map_sample.dart';
import 'package:Puredrops/authentication/profile_screen.dart';
import 'package:Puredrops/custom_navigation_bar.dart';
import 'package:Puredrops/donation_screen.dart';
import 'package:Puredrops/home_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true; // Toggle for notifications
  bool darkModeEnabled = false; // Toggle for dark mode
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Water_Consumption_Feature.png'),
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
                  const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: [
                        const Text(
                          'General Settings',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 72, 108),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildToggleOption(
                          'Enable Notifications',
                          notificationsEnabled,
                          (value) {
                            setState(() {
                              notificationsEnabled = value;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        _buildToggleOption(
                          'Dark Mode',
                          darkModeEnabled,
                          (value) {
                            setState(() {
                              darkModeEnabled = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        const Divider(color: Colors.white54),
                        const SizedBox(height: 20),
                        const Text(
                          'Account Settings',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 72, 108),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildAccountOption('Change Password', Icons.lock),
                        const SizedBox(height: 10),
                        _buildAccountOption('Language', Icons.language),
                        const SizedBox(height: 10),
                        _buildAccountOption(
                            'Privacy Policy', Icons.privacy_tip),
                        const SizedBox(height: 20),
                        const Divider(color: Colors.white54),
                        const SizedBox(height: 20),
                        // About Us Section
                        const Text(
                          'About Us',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 72, 108),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildAboutCard(),
                        const SizedBox(height: 20),
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

  // Widget for building toggle switches
  Widget _buildToggleOption(
      String title, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 18, color: Color.fromARGB(255, 9, 1, 84)),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blueAccent,
        ),
      ],
    );
  }

  // Widget for building account settings options
  Widget _buildAccountOption(String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        // Add navigation or functionality for the option
      },
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
                fontSize: 18, color: Color.fromARGB(255, 0, 0, 0)),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios,
              size: 16, color: Color.fromARGB(255, 22, 1, 129)),
        ],
      ),
    );
  }

  // Widget for About Us card
  Widget _buildAboutCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PureDrops',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 72, 108),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'PureDrops is a water management application developed by Team Aqua Guardians.',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              'Developed by:\n- Janindu Chamod (Lead Developer)\n- Duvidu Kavinga (Donation Feature)\n- Shashi (Water Request Feature)\n- Shaini Rose (Resources Feature)',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              'Version: 1.0.0',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
