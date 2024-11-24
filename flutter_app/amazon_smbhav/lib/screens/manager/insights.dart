import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:untitled/screens/manager/widgets/sidebar.dart';
import 'package:url_launcher/url_launcher.dart';

class InsightsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: SidebarMenu(),),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal[100],
        title: Text(
          "Insights - November",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.teal[900]),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Title
              Text(
                "Eco-Friendly Contributions",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                "Data for November 2024",
                style: TextStyle(fontSize: 16, color: Colors.teal[700]),
              ),
              SizedBox(height: 16.0),

              // Graph Section 1: Hours Saved During Delivery
              _buildGraphCard(
                title: "Hours Saved During Delivery",
                graph: LineChart(_generateHoursSavedGraphData()),
                backgroundColor: Colors.grey[100]!,
              ),
              SizedBox(height: 16.0),

              // Graph Section 2: Fuel Saved
              _buildGraphCard(
                title: "Fuel Saved (Liters)",
                graph: BarChart(_generateFuelGraphData()),
                backgroundColor: Colors.teal[50]!,
              ),
              SizedBox(height: 16.0),

              // Graph Section 3: Eco-Friendly Contributions
              _buildGraphCard(
                title: "Eco-Friendly Contributions",
                graph: PieChart(_generateEcoContributionsData()),
                backgroundColor: Colors.grey[100]!,
              ),
              SizedBox(height: 16.0),

              // Graph Section 4: Carbon Footprint Tracker
              _buildGraphCard(
                title: "Carbon Footprint Tracker",
                graph: LineChart(_generateCarbonFootprintGraphData()),
                backgroundColor: Colors.teal[50]!,
              ),
              SizedBox(height: 24.0),

              // Impact Statistics
              Text(
                "Impact Details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
                ),
              ),
              SizedBox(height: 16.0),
              _buildStatRow(),

              SizedBox(height: 24.0),

              // Resources Section
              Text(
                "Learn More",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
                ),
              ),
              SizedBox(height: 16.0),
              _buildResourceLink(
                "Eco-Friendly Logistics Practices",
                "https://www.sciencedirect.com/science/article/pii/S0038012124002490",
              ),
              SizedBox(height: 10,),

              _buildResourceLink(
                "Route Optimization Eco-friendly Logistics",
                "https://fareye.com/resources/blogs/route-optimization-eco-friendly-logistics",
              ),
              SizedBox(height: 10,),
              _buildResourceLink(
                "Carbon Footprint Calculator",
                "https://www.carbonfootprint.com/calculator.aspx",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGraphCard({required String title, required Widget graph, required Color backgroundColor}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [

        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal[800],
            ),
          ),
          SizedBox(height: 16.0),
          Container(height: 200, child: graph),
        ],
      ),
    );
  }

  PieChartData _generateEcoContributionsData() {
    return PieChartData(
      sections: [
        PieChartSectionData(
          value: 40,
          color: Colors.green,
          title: "Delivery Teams (40%)",
          radius: 50,
          titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        PieChartSectionData(
          value: 35,
          color: Colors.blue,
          title: "Manufacturers (35%)",
          radius: 50,
          titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        PieChartSectionData(
          value: 15,
          color: Colors.orange,
          title: "Clients (15%)",
          radius: 50,
          titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        PieChartSectionData(
          value: 10,
          color: Colors.purple,
          title: "Packers (10%)",
          radius: 50,
          titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }

  LineChartData _generateCarbonFootprintGraphData() {
    return LineChartData(
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            interval: 50,
            getTitlesWidget: (value, meta) {
              return Text("${value.toInt()} kg");
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {
              return Text("Week ${value.toInt()}");
            },
          ),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          isCurved: true,
          color: Colors.red,
          barWidth: 4,
          belowBarData: BarAreaData(show: true, color: Colors.red.withOpacity(0.3)),
          spots: [
            FlSpot(0, 400),
            FlSpot(1, 380),
            FlSpot(2, 350),
            FlSpot(3, 330),
            FlSpot(4, 310),
          ],
        ),
      ],
    );
  }

  LineChartData _generateHoursSavedGraphData() {
    return LineChartData(
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            interval: 10,
            getTitlesWidget: (value, meta) {
              return Text("${value.toInt()}h");
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {
              return Text("Week ${value.toInt()}");
            },
          ),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          isCurved: true,
          color: Colors.green,
          barWidth: 4,
          belowBarData: BarAreaData(show: true, color: Colors.green.withOpacity(0.3)),
          spots: [
            FlSpot(0, 10),
            FlSpot(1, 30),
            FlSpot(2, 24),
            FlSpot(3, 20),
            FlSpot(4, 40),
          ],
        ),
      ],
    );
  }

  BarChartData _generateFuelGraphData() {
    return BarChartData(
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: (value, meta) {
              return Text("${value.toInt()} L");
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              return Text("Week ${value.toInt()}");
            },
          ),
        ),
      ),
      barGroups: [
        BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 60, color: Colors.blue)]),
        BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 90, color: Colors.orange)]),
        BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 80, color: Colors.red)]),
      ],
    );
  }


  Widget _buildStatRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard("Total Deliveries", "1200", Colors.teal!),
        _buildStatCard("Emissions Saved", "140kg", Colors.grey!),
        _buildStatCard("Fuel Saved", "80L", Colors.teal!),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color),
          ),
          SizedBox(height: 8.0),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildResourceLink(String title, String url) {
    return InkWell(
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          print("Could not launch $url");
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, color: Colors.teal[800]),
            ),
            Icon(Icons.launch, color: Colors.teal[800]),
          ],
        ),
      ),
    );}}
