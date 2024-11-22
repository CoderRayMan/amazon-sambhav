import 'package:flutter/material.dart';
import 'package:untitled/screens/home/drawer.dart';
import 'package:untitled/screens/home/parking_reviews.dart';
import 'package:untitled/screens/home/transactions.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context:context),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          'Barry Rewards',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            color: Colors.blue[800],
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Section
            const _UserInfoSection(
              ccmId: '02954224',
              householdNumber: '242421124442422',
            ),
            const SizedBox(height: 16),

            // Reward Balance Card
            const _RewardBalanceCard(),
            const SizedBox(height: 16),

            // Challenge Progress Card
            const _ChallengeCard(),
            const SizedBox(height: 16),

            // Reviews Pending Card
            const _ReviewsCard(),
            const SizedBox(height: 16),

            // Find Parking Card
            const _FindParkingCard(),
          ],
        ),
      ),
    );
  }
}

class _UserInfoSection extends StatelessWidget {
  final String ccmId;
  final String householdNumber;

  const _UserInfoSection({
    required this.ccmId,
    required this.householdNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CCM ID: $ccmId',
              style: TextStyle(
                color: Colors.blue[800],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Household #: $householdNumber',
              style: TextStyle(
                color: Colors.blue[800],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RewardBalanceCard extends StatelessWidget {
  const _RewardBalanceCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Reward Balance Points',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '430.00',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Last Credit: April 8th, 2024',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Redeem',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TransferMoneyScreen(),
                  ),
                );
              },
              child: const Text(
                'View Transaction History',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  const _ChallengeCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'December Huddle!!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Collect 1000pts by Dec 31st!!!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Challenge Start Date: Dec 8th, 2024',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: 430 / 1000,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[700]!),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  '430 of 1000',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Resets Jun 30, 2024',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewsCard extends StatelessWidget {
  const _ReviewsCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red[50],
          child: const Text(
            '2',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: const Text(
          'Reviews Pending',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.blueGrey),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RateRewardsScreen(),
            ),
          );
        },
      ),
    );
  }
}

class _FindParkingCard extends StatelessWidget {
  const _FindParkingCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: ListTile(
        leading: const Icon(
          Icons.local_parking,
          color: Colors.blue,
          size: 32,
        ),
        title: const Text(
          'Find a Parking',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text(
          'Search local Parking Spaces.',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.blueGrey),
        onTap: () {},
      ),
    );
  }
}
