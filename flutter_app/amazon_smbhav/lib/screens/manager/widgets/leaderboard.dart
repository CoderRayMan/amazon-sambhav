import 'package:flutter/material.dart';

class LeaderboardCard extends StatelessWidget {
  const LeaderboardCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Adjust the padding and font size based on screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360; // Small screen width threshold

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Eco-Friendly Delivery Leaderboard',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                children: [
                  _buildTableHeader('Warehouse', isSmallScreen),
                  _buildTableHeader('Manager', isSmallScreen),
                  _buildTableHeader('Points', isSmallScreen),
                  _buildTableHeader('Rank', isSmallScreen),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...List.generate(
            5,
                (index) => _buildLeaderboardRow(
              context,
              index == 0 ? 'GreenHub Warehouse' : 'EcoBox Warehouse',
              index == 0 ? 'Samantha Green' : 'Mark Eco',
              (index + 1) * 1200, // Different points for each row
              index < 2 ? 'Prince' : 'Knight', // Assign rank
              isSmallScreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(String text, bool isSmallScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade600,
          fontSize: isSmallScreen ? 12 : 14, // Adjust font size for small screens
        ),
      ),
    );
  }

  Widget _buildLeaderboardRow(
      BuildContext context,
      String warehouse,
      String manager,
      int points,
      String rank,
      bool isSmallScreen,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildTextColumn(warehouse, 2, isSmallScreen),
              const SizedBox(width: 8),
              _buildManagerColumn(manager, context, isSmallScreen),
              _buildTextColumn('$points', 1, isSmallScreen),
              _buildRankColumn(context, rank, isSmallScreen),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextColumn(String text, int flex, bool isSmallScreen) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          fontSize: isSmallScreen ? 12 : 14, // Adjust font size for small screens
        ),
      ),
    );
  }

  Widget _buildManagerColumn(String manager, BuildContext context, bool isSmallScreen) {
    return Expanded(
      flex: 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align the text properly
        children: [
          CircleAvatar(
            backgroundColor: Colors.teal,
            radius: 16,
            child: Text(
              manager.substring(0, 1),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(manager, maxLines: 1, overflow: TextOverflow.ellipsis), // Prevent overflow
                if (!isSmallScreen)
                  Text(
                    'Eco-Friendly Delivery Expert',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankColumn(BuildContext context, String rank, bool isSmallScreen) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: rank == 'Prince'
            ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        rank,
        style: TextStyle(
          color: rank == 'Prince'
              ? Theme.of(context).colorScheme.secondary
              : Colors.grey.shade600,
          fontSize: isSmallScreen ? 12 : 14, // Adjust font size for small screens
        ),
      ),
    );
  }
}
