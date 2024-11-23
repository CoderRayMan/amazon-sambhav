import 'package:flutter/material.dart';
import 'package:untitled/screens/home/drawer.dart';
import 'package:untitled/screens/home/parking_review_questions.dart';

class ParkingListScreen extends StatelessWidget {
  const ParkingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for parking cards
    final List<Map<String, dynamic>> parkingData = [
      {
        "name": "MC ABC Parking",
        "address": "123 Fake Street, Apt. 4B, Springfield, CA 12345",
        "distance": "1.5 Km",
        "rating": 3,
        "reviews": 2000,
        "availableSpaces": 30,
      },
      {
        "name": "Downtown Parking Lot",
        "address": "456 Central Ave, Springfield, CA 12345",
        "distance": "2.0 Km",
        "rating": 5,
        "reviews": 5000,
        "availableSpaces": 50,
      },
      {
        "name": "City Center Parking",
        "address": "789 Market Road, Springfield, CA 12345",
        "distance": "0.8 Km",
        "rating": 4,
        "reviews": 3200,
        "availableSpaces": 20,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Parkings',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.teal[100],
      ),
      drawer: buildDrawer(context: context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Parkings near me',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: const Icon(Icons.mic, color: Colors.grey),
                filled: true,
                fillColor: Colors.teal[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: parkingData.length,
              itemBuilder: (context, index) {
                final parking = parkingData[index];
                return ParkingCard(
                  name: parking["name"],
                  address: parking["address"],
                  distance: parking["distance"],
                  rating: parking["rating"],
                  reviews: parking["reviews"],
                  availableSpaces: parking["availableSpaces"],
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
  final String name;
  final String address;
  final String distance;
  final int rating;
  final int reviews;
  final int availableSpaces;
  final VoidCallback onReviewTap;

  const ParkingCard({
    super.key,
    required this.name,
    required this.address,
    required this.distance,
    required this.rating,
    required this.reviews,
    required this.availableSpaces,
    required this.onReviewTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[100],
      ),
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
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        address,
                        style:  TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
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
                            child: Text(distance),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            children: List.generate(
                              5,
                                  (index) => Icon(
                                index < rating
                                    ? Icons.star
                                    : Icons.star_border,
                                color: index < rating
                                    ? Colors.amber
                                    : Colors.grey,
                                size: 20,
                              ),
                            ),
                          ),
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
                    Text(
                      '$availableSpaces+',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    IconButton(
                      onPressed: onReviewTap,
                      icon: const Icon(Icons.location_pin, color: Colors.blue),
                    ),
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
