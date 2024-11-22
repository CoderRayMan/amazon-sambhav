import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/screens/home/home_page.dart';
import 'package:untitled/screens/home/homepage.dart';
import 'package:untitled/screens/packaging/packaging%20dashboard.dart';

void main() => runApp(MyApp());
List<dynamic>? cachedData; // Cache for delivery data
Set<Marker> markers = {};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vaanik - Amazon Sambhav Hackathon',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto', // Add a professional font if available
      ),
      home: InitialPage(),
    );
  }
}

class InitialPage extends StatelessWidget {
  final List<Role> roles = [
    Role(
      title: 'Delivery Login',
      icon: Icons.delivery_dining,
      navigateTo: DeliveryPage(),
    ),
    Role(
      title: 'Stock Loading Login',
      icon: Icons.warehouse,
      navigateTo: PackagingDashboard(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App branding section
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.blue[800],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Center(
                child: Text(
                  'Vaanik',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Choose your role text
            Text(
              'Choose Your Role',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
            ),
            SizedBox(height: 20),

            // Grid view for role selection
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 36),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: roles.length,
                  itemBuilder: (context, index) {
                    final role = roles[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => role.navigateTo),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              role.icon,
                              size: 40,
                              color: Colors.blueGrey[700],
                            ),
                            SizedBox(height: 10),
                            Text(
                              role.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Footer (Optional)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                '© 2024 Vaanik - Powered by Amazon Sambhav Hackathon',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Role {
  final String title;
  final IconData icon;
  final Widget navigateTo;

  Role({
    required this.title,
    required this.icon,
    required this.navigateTo,
  });
}
