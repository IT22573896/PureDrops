import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360, // Explicit width
      height: 49, // Explicit height
      decoration: BoxDecoration(
        color: const Color(0xFF03045E), // Background color as #03045E
        borderRadius: BorderRadius.circular(20), // Border radius 20
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 1),
      margin:
          const EdgeInsets.only(bottom: 15), // Optional: margin for positioning
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(0, 'assets/icons/Home.png', currentIndex),
          _buildNavItem(1, 'assets/icons/Heart.png', currentIndex),
          _buildNavItem(2, 'assets/icons/Location.png', currentIndex),
          _buildNavItem(3, 'assets/icons/Profile.png', currentIndex),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath, int currentIndex) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        child: Image.asset(
          iconPath,
          height: 25, // Keep icon size same
          // Change color when selected
        ),
      ),
    );
  }
}
