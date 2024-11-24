import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/screens/home/homepage.dart';
import 'package:untitled/screens/manager/assignments.dart';
import 'package:untitled/screens/manager/dashboard.dart';
import 'package:untitled/screens/manager/insights.dart';
import 'package:untitled/screens/packaging/packaging%20dashboard.dart';
import 'package:untitled/utils/colors.dart';

void main() => runApp(MyApp());
List<dynamic>? cachedData; // Cache for delivery data
Set<Marker> markers = {};
Polyline? routePolyline;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vaanik - Amazon Sambhav Hackathon',
      // theme: ThemeData(
      //   brightness: Brightness.light,
      //   primaryColor: AppColors.primaryColor,
      //   hintColor: AppColors.accentColor,
      //   scaffoldBackgroundColor: AppColors.backgroundColor,
      //   appBarTheme: AppBarTheme(
      //     color: AppColors.primaryColor,
      //     iconTheme: IconThemeData(color: AppColors.textColor),
      //     titleTextStyle: TextStyle(
      //       color: AppColors.textColor,
      //       fontSize: 20.0,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   textTheme: TextTheme(
      //     bodyLarge: TextStyle(color: AppColors.textColor),
      //     bodyMedium: TextStyle(color: AppColors.textColor),
      //     titleMedium: TextStyle(color: AppColors.hintTextColor),
      //     titleLarge: TextStyle(color: AppColors.textColor, fontWeight: FontWeight.bold),
      //   ),
      //   buttonTheme: ButtonThemeData(
      //     buttonColor: AppColors.secondaryColor,
      //     textTheme: ButtonTextTheme.primary,
      //   ),
      //   inputDecorationTheme: InputDecorationTheme(
      //     filled: true,
      //     fillColor: Colors.white,
      //     enabledBorder: OutlineInputBorder(
      //       borderSide: BorderSide(color: AppColors.secondaryColor),
      //       borderRadius: BorderRadius.circular(8.0),
      //     ),
      //     focusedBorder: OutlineInputBorder(
      //       borderSide: BorderSide(color: AppColors.tertiaryColor),
      //       borderRadius: BorderRadius.circular(8.0),
      //     ),
      //     hintStyle: TextStyle(color: AppColors.hintTextColor),
      //   ),
      //   fontFamily: 'Roboto'
      // ),
      home: InitialPage(),
    );
  }
}

class InitialPage extends StatelessWidget {
  final List<Role> roles = [
    Role(
      title: 'Movers',
      icon: Icons.delivery_dining,
      navigateTo: DeliveryPage(),
    ),
    Role(
      title: 'Packers',
      icon: Icons.warehouse,
      navigateTo: PackagingDashboard(),
    ),
    Role(
      title: 'Managers',
      icon: Icons.manage_accounts,
      navigateTo: AssignmentsScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App branding section
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Vàanik',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // color:  Colors.teal[50],
              ),
              child: Center(
                child: Image.asset(
                  'assets/welcome.jpeg',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Role Selection Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),

              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: const Text(
                        "Choose your role",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildRoleButton(
                      icon: Icons.local_shipping_outlined,
                      title: "Movers",
                      onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DeliveryPage()),
    );
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildRoleButton(
                      icon: Icons.warehouse_outlined,
                      title: "Packers",
                      onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PackagingDashboard()),
    );

                      },
                    ),
                    const SizedBox(height: 16),
                    _buildRoleButton(
                      icon: Icons.manage_accounts_outlined,
                      title: "Managers",
                      onTap: () {
                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => AssignmentsScreen()),
                                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // Footer
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                "©2024 Vaanik - Powered by Amazon SandBox Hackathon",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // Choose your role text
            // Text(
            //   'Choose Your Role',
            //   style: TextStyle(
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.grey[800],
            //   ),
            // ),
            // SizedBox(height: 20),
            //
            // // Grid view for role selection
            // Expanded(
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 100.0),
            //     child: GridView.builder(
            //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 1,
            //         crossAxisSpacing: 16,
            //         mainAxisSpacing: 16,
            //         childAspectRatio: 1.1,
            //       ),
            //       itemCount: roles.length,
            //       itemBuilder: (context, index) {
            //         final role = roles[index];
            //         return GestureDetector(
            //           onTap: () {
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(builder: (context) => role.navigateTo),
            //             );
            //           },
            //           child: Container(
            //
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(20),
            //               color: Colors.teal[50]
            //             ),
            //
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Icon(
            //                   role.icon,
            //                   size: 40,
            //                   color: Colors.blueGrey[700],
            //                 ),
            //                 SizedBox(height: 10),
            //                 Text(
            //                   role.title,
            //                   textAlign: TextAlign.center,
            //                   style: TextStyle(
            //                     fontSize: 16,
            //                     fontWeight: FontWeight.bold,
            //                     color: Colors.blueGrey[800],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
            //
            // // Footer (Optional)
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 20),
            //   child: Text(
            //     '© 2024 Vaanik - Powered by Amazon Sambhav Hackathon',
            //     style: TextStyle(color: Colors.grey[600], fontSize: 12),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
  Widget _buildRoleButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: const Color(0xFFE8F4F4),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon, size: 24),
              const SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),
              const Icon(Icons.chevron_right),
            ],
          ),
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
