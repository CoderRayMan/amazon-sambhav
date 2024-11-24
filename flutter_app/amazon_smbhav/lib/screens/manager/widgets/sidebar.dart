import 'package:flutter/material.dart';
import 'package:untitled/main.dart';
import 'package:untitled/screens/manager/assignments.dart';
import 'package:untitled/screens/manager/dashboard.dart';
import 'package:untitled/screens/manager/insights.dart';

class SidebarMenu extends StatefulWidget {
  const SidebarMenu({super.key});

  @override
  _SidebarMenuState createState() => _SidebarMenuState();
}

int _selectedIndex = 0;  // Track the selected item index

class _SidebarMenuState extends State<SidebarMenu> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: 250,
        color: Colors.teal[50],
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  ' Managers',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            ),
            const SizedBox(height: 50),
            _buildMenuItem(
                context, Icons.dashboard, 'Assignments Dashboard', DummyPage('Assignments Dashboard'), 0),
            _buildMenuItem(context, Icons.insights, 'Insights', DummyPage('Insights'), 1),
            _buildMenuItem(context, Icons.science, 'A/B Testing', DummyPage('A/B Testing'), 2),
            _buildMenuItem(context, Icons.chat_bubble_outline, 'AI R&D Chatbot', DummyPage('AI R&D Chatbot'), 3),
            _buildMenuItem(
                context, Icons.eco, 'Eco Hero Dashboard', DummyPage('Eco Hero Dashboard'), 4),

            _buildMenuItem(context, Icons.person_outline, 'Profile', DummyPage('Profile'), 5),
      _buildMenuItem(context, Icons.logout, 'Logout', DummyPage('Profile'), 6),

      ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context,
      IconData icon,
      String title,
      Widget destination,
      int index,
      ) {
    bool isSelected = _selectedIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;  // Set the selected index
        });

        // Navigate to the respective screen
        if (title == "Assignments Dashboard") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AssignmentsScreen()),
          );

        } else if (title == "Eco Hero Dashboard") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
          );
        }else if(title=="Logout"){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => InitialPage()),
                (Route<dynamic> route) => false,
          );
        _selectedIndex=0;
        }else if (title == "Insights") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InsightsPage()),
          );

        }else
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.shade100 : Colors.transparent,
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

class DummyPage extends StatelessWidget {
  final String title;

  const DummyPage(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          'Welcome to $title',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
