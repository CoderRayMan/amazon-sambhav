import 'package:flutter/material.dart';
import 'package:untitled/screens/packaging/load_items.dart';
import 'package:untitled/screens/packaging/webview.dart';

class PackagePlacementPage extends StatelessWidget {
  final double truckLength;
  final double truckWidth;
  final double truckHeight;
  final double packageLength;
  final double packageWidth;
  final double packageHeight;
  final double fromleftside;
  final double fromhead;
  final double frombottom;

  PackagePlacementPage({
    required this.truckLength,
    required this.truckWidth,
    required this.truckHeight,
    required this.packageLength,
    required this.packageWidth,
    required this.packageHeight,
    required this.fromleftside,
    required this.fromhead, required this.frombottom,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('2D Package Placement'),
      ),
      body: SingleChildScrollView( // To make the page scrollable
        child: Column(
          children: [
            Text(
              'Truck and Package Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Truck Dimensions: $truckLength x $truckWidth x $truckHeight'),
            Text('Package Dimensions: $packageLength x $packageWidth x $packageHeight'),
            Text('Package Placement Position: ($fromleftside, $fromhead, $frombottom)'),
            SizedBox(height: 20),

            // Top View Section (Adjusted to realistic proportion)
            Text(
              'Top View',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              width: truckWidth, // Same width as in side view
              height: truckLength  , // Adjusted length for proportionality
              decoration: BoxDecoration(
                color: Colors.grey[300], // Truck container color
                border: Border.all(color: Colors.black),
              ),
              child: Stack(
                children: [
                  // Horizontal and Vertical lines to represent cargo grid (like map coordinates)
                  _buildCoordinateLines(truckWidth, truckLength),
                  // Package in top view
                  Positioned(
                    left: fromleftside,
                    top: fromhead,
                    child: Container(
                      width: packageWidth,
                      height: packageLength,
                      decoration: BoxDecoration(
                        color: Colors.green, // Package color
                        border: Border.all(color: Colors.black),
                      ),
                    ),
                  ),
                  // Mark the front of the truck (Top View)
                  Positioned(
                    left: 0, // Left corner of the truck
                    top: 0,  // Top corner of the truck
                    child: Container(
                      width: truckWidth,
                      height: 20, // Small height to mark the front
                      color: Colors.red, // Red color for the head of the truck
                      child: Center(
                        child: Text(
                          'Head of Truck',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Side View Section (Horizontal Rectangular Truck)
            Text(
              'Side View',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              width: truckLength,
              height: truckHeight,
              decoration: BoxDecoration(
                color: Colors.grey[300], // Truck container color
                border: Border.all(color: Colors.black),
              ),
              child: Stack(
                children: [
                  // Horizontal and Vertical lines to represent cargo grid (like map coordinates)
                  _buildCoordinateLines(truckLength, truckHeight),
                  // Package in side view
                  Positioned(
                    right: fromhead-10,
                    bottom: frombottom, // Package placed from the bottom of the truck
                    child: Container(
                      width: packageLength,
                      height: packageHeight,
                      decoration: BoxDecoration(
                        color: Colors.green, // Package color
                        border: Border.all(color: Colors.black),
                      ),
                    ),
                  ),
                  Positioned(
                    left: truckLength-20, // Move head to the right side of the truck
                    top: 0, // Aligning the head to the top
                    child: Container(
                      width: 20, // Small width to mark the front
                      height: truckHeight, // Full height to mark the side of the truck
                      color: Colors.red, // Red color for the head of the truck
                      child: Center(
                        child: Text(
                          'Head of Truck',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
            ),
            // LoadItemsScreen()
          ],
        ),
      ),
    );
  }

  // Method to build coordinate lines (horizontal and vertical)
  Widget _buildCoordinateLines(double width, double height) {
    List<Widget> lines = [];

    // Draw vertical lines
    for (double i = 0; i <= width; i += 50) {
      lines.add(Positioned(
        left: i,
        top: 0,
        child: Container(
          width: 1,
          height: height,
          color: Colors.black.withOpacity(0.5), // Faint vertical lines
        ),
      ));
    }

    // Draw horizontal lines
    for (double i = 0; i <= height; i += 50) {
      lines.add(Positioned(
        left: 0,
        top: i,
        child: Container(
          width: width,
          height: 1,
          color: Colors.black.withOpacity(0.5), // Faint horizontal lines
        ),
      ));
    }

    return Stack(children: lines);
  }
}
