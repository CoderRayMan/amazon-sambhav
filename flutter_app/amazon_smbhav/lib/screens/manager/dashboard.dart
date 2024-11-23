import 'package:flutter/material.dart';
import 'package:untitled/screens/manager/widgets/activity_card.dart';
import 'package:untitled/screens/manager/widgets/leaderboard.dart';
import 'package:untitled/screens/manager/widgets/sidebar.dart';
import 'package:untitled/screens/manager/widgets/status.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[100],
        title:            Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Eco Hero Dashboard',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Rank: Eco-Knight',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),

          ],
        ),

      ),
      drawer: Drawer(
        child: SidebarMenu(),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            // Stats Cards
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(

                children: [
                  StatsCard(
                    title: 'Dead head Miles Savings',
                    value: '\$567,402',
                    trend: 12.5,
                  ),
                  SizedBox(width: 12,),
                  StatsCard(
                    title: 'Total CO2 reduction (Kgs)',
                    value: '2,208',
                    trend: 8.2,
                  ),
                  SizedBox(width: 12,),

                  StatsCard(
                    title: 'Time Savings',
                    value: '2,208',
                    trend: 15.3,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Activity Card and Leaderboard
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ActivityCard(),
                const SizedBox(height: 24),
                LeaderboardCard(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
