import 'package:flutter/material.dart';
import 'package:untitled/main.dart';
import 'package:untitled/screens/home/homepage.dart';
import 'package:untitled/screens/home/parkings_near_me.dart';
import 'package:untitled/screens/home/pastloads_page.dart';
import 'package:untitled/screens/home/profile.dart';
import 'package:untitled/screens/home/rewards.dart';
import 'package:untitled/screens/packaging/packaging%20dashboard.dart';

import '../../dummy_data.dart';

class buildDrawer extends StatefulWidget {
  final BuildContext context;
  const buildDrawer({super.key, required this.context});

  @override
  State<buildDrawer> createState() => _buildDrawerState();
}
int _selectedIndex = 0;

class _buildDrawerState extends State<buildDrawer> {
  // Track the selected item

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.teal[50],
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drawer Header
            DrawerHeader(child:             Row(
              children: [
                Icon(
                  Icons.eco,
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Vàanik',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 Text(
                  ' Packers',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            ),
            const SizedBox(height: 32),

            // Home Item

            // Past Loads Item
            _buildDrawerItem(
              context,
              Icons.dashboard,
              'Packaging Dashboard',
              1, // index 1 for Past Loads
                  () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PackagingDashboard(),
                  ),
                );
              },
            ),
            // Parking Item

            // Rewards Item
            _buildDrawerItem(
              context,
              Icons.card_giftcard,
              'Rewards',
              3, // index 3 for Rewards
                  () {
                setState(() {
                  _selectedIndex = 3;
                });

              },
            ),
            // Profile Item
            _buildDrawerItem(
              context,
              Icons.person,
              'Profile',
              4, // index 4 for Profile
                  () {
                setState(() {
                  _selectedIndex = 4;
                });

              },
            ),
            // Logout Item
            _buildDrawerItem(
              context,
              Icons.logout,
              'Logout',
              5, // index 5 for Logout
                  () {
                void clearCache() {
                  setState(() {
                    cachedData = null;
                  });
                }
                _selectedIndex=0;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => InitialPage()),
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, IconData icon, String title, int index, VoidCallback onTap) {
    bool isSelected = _selectedIndex == index;

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.black : Colors.grey[600],
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
