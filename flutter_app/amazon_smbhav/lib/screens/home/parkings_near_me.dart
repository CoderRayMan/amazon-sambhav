import 'package:flutter/material.dart';
import 'package:untitled/screens/home/drawer.dart';
import 'package:untitled/screens/home/parking_review_questions.dart';

class ParkingListScreen extends StatelessWidget {
  const ParkingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:            const Text('Parkings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
centerTitle: false,
      ),
      drawer: buildDrawer(context:context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:
              Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
          decoration: InputDecoration(
          hintText: 'Parkings near me',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
            suffixIcon: const Icon(Icons.mic, color: Colors.grey),

            filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          ),)

          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return ParkingCard(
                  onReviewTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReviewQuestionsScreen(),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ParkingCard extends StatelessWidget {
  final VoidCallback onReviewTap;

  const ParkingCard({super.key, required this.onReviewTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.local_parking, size: 40),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'MC ABC Parking,123 Fake Street, Apt. 4B, Springfield, CA 12345',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text('1.5 Km'),
                          ),
                          const SizedBox(width: 8),
                          const Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              Icon(Icons.star_border, size: 20),
                              Icon(Icons.star_border, size: 20),
                            ],
                          ),
                          const SizedBox(width: 8),
                          // const Text('2000+ Reviews'),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const Text(
                      'Space',
                      style: TextStyle(fontSize: 12),
                    ),
                    const Text(
                      '30+',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    // IconButton(
                    //   onPressed: onReviewTap,
                    //   icon: Icon(Icons.location_pin,color: ,),
                    // ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}