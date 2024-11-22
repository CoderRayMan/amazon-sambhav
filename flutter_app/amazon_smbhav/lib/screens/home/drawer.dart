import 'package:flutter/material.dart';
import 'package:untitled/main.dart';
import 'package:untitled/screens/home/home_page.dart';
import 'package:untitled/screens/home/homepage.dart';
import 'package:untitled/screens/home/parkings_near_me.dart';
import 'package:untitled/screens/home/pastloads_page.dart';
import 'package:untitled/screens/home/profile.dart';
import 'package:untitled/screens/home/rewards.dart';

import '../../dummy_data.dart';
class buildDrawer extends StatefulWidget {
  final BuildContext context;
  const buildDrawer({super.key, required this.context});

  @override
  State<buildDrawer> createState() => _buildDrawerState();
}

class _buildDrawerState extends State<buildDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue[100]),
            child: Row(
              children: [

                const SizedBox(width: 16),
                const Text(
                  'Vaanik'
                  ,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // UserAccountsDrawerHeader(
          //   decoration: BoxDecoration(color: Colors.blue),
          //   accountName: Text('VAANIK'),
          //   accountEmail: Text('delivery@domain.com'),
          //   // currentAccountPicture: Image(image: AssetImage('assets/img.png'),height: 500,width: 500,)
          // ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => DeliveryPage()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Past Loads'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PastLoadsPage(addresses: pastaddresses), // Add your actual data here
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.car_crash_sharp),
            title: Text('Parking'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ParkingListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.card_giftcard),
            title: Text('Rewards'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RewardsPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>DeliveryPersonProfileScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              void clearCache() {
                setState(() {
                  cachedData = null;
                });
              }
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => InitialPage()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
