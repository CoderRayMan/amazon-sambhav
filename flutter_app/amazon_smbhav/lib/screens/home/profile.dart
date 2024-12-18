import 'package:flutter/material.dart';
import 'package:untitled/screens/home/drawer.dart';

class DeliveryPersonProfileScreen extends StatelessWidget {
  const DeliveryPersonProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal[100],
        centerTitle: false,
        title:              const Text('Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the profile edit screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: buildDrawer(context:context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                child: Container(
                  decoration:
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.teal[50],

                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Barry Allen', // Replace with delivery person's name
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Delivery Person',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[700],
                ),
              ),
            ),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Contact Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.phone, color: Colors.teal),
                SizedBox(width: 8),
                Text('123-456-7890'), // Replace with actual phone number
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.email, color: Colors.teal),
                SizedBox(width: 8),
                Text('barry@example.com'), // Replace with actual email
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Delivery Stats',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.delivery_dining, color: Colors.teal),
                const SizedBox(width: 8),
                Text(
                  'Completed Deliveries: 50',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.timer, color: Colors.teal),
                const SizedBox(width: 8),
                Text(
                  'Average Time per Delivery: 30 mins',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

          ],
        ),
      ),
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Edit your profile information below.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
