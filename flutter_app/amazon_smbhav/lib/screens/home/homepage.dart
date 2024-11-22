import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/main.dart';
import 'package:untitled/screens/home/drawer.dart';
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class DeliveryPage extends StatefulWidget {
  @override
  _DeliveryPageState createState() => _DeliveryPageState();
}


class _DeliveryPageState extends State<DeliveryPage> {
  late Future<List<dynamic>> deliveryData;
  String filterValue = 'All';
  String searchQuery = '';
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    deliveryData = fetchOrGetCachedData();
  }

  Future<List<dynamic>> fetchOrGetCachedData({bool forceRefresh = false}) async {
    // Refresh data if forceRefresh is true
    if (forceRefresh || cachedData == null) {
      final url = Uri.parse(
          "https://a6k5eg0vc0.execute-api.us-east-1.amazonaws.com/s1/route-ops?emp_id=D1001");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        cachedData = jsonResponse['route']; // Cache the fetched data
        await fetchMarkers(); // Update markers based on fetched data
        return cachedData!;
      } else {
        throw Exception("Failed to load delivery data");
      }
    }

    // Return cached data if no refresh is needed
    return cachedData!;
  }

  Future<void> fetchMarkers() async {
    if (cachedData == null) return;

    Set<Marker> newMarkers = {};

    for (var delivery in cachedData!) {
      final latitude = delivery['lat'];
      final longitude = delivery['lng'];
      newMarkers.add(
        Marker(
          markerId: MarkerId(delivery['load_id'].toString()),
          position: LatLng(double.parse(latitude), double.parse(longitude)),
          infoWindow: InfoWindow(
            title: delivery['address'],
            snippet: 'Sequence: ${delivery['sequence']}',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }

    setState(() {
      markers = newMarkers;
    });
  }

  void clearCache() {
    setState(() {
      cachedData = null;
    });
  }

  Future<void> refreshData() async {
    setState(() {
      deliveryData = fetchOrGetCachedData(forceRefresh: true);
    });
  }

  List<dynamic> getFilteredList(List<dynamic> data) {
    return data.where((item) {
      final matchesSearch = item['address']
          .toString()
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
      if (filterValue == 'All') {
        return matchesSearch;
      }
      return matchesSearch;
    }).toList();
  }

  void _callPhoneNumber(String phoneNumber) async {
    final Uri telUrl = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(telUrl);
  }
  void _showCancelDialog(int index) {
    TextEditingController cancelReasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Cancel Order'),
          content: TextField(
            controller: cancelReasonController,
            decoration: InputDecoration(
              labelText: 'Enter reason for cancellation',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {

                Navigator.of(context).pop();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
  void _showDeliveryDialog(dynamic delivery) {
    TextEditingController otpController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Delivery'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Delivery Address: ${delivery['address']}\nProduct ID: ${delivery['load_id']}'),
              SizedBox(height: 10),
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter OTP',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Order Marked as Delivered')),
                );
                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context:context),

      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search...',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),
            suffixIcon: Icon(Icons.mic),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: refreshData, // Refresh data on button press
          ),

        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: deliveryData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No delivery data found.'));
          } else {
            final filteredList = getFilteredList(snapshot.data!);

            return Column(
              children: [
                SizedBox(
                  height: 200,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(double.parse(filteredList[0]['lat']),double.parse(filteredList[0]['lng'])), // Default location
                      zoom: 10,
                    ),
                    markers: markers,
                    onMapCreated: (controller) {
                      mapController = controller;
                    },
                  ),
                ),
                DropdownButton<String>(
                  value: filterValue,
                  icon: Icon(Icons.filter_list),
                  onChanged: (String? newValue) {
                    setState(() {
                      filterValue = newValue!;
                    });
                  },
                  items: <String>['All', 'Delivered', 'Cancelled', 'To Deliver']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final delivery = filteredList[index];
                      return ListTile(
                        title: Text('Delivery ${delivery['sequence']}'),
                        subtitle: Text(delivery['address']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () => _showCancelDialog(delivery),
                            ),
                            IconButton(
                              icon: Icon(Icons.done_all, color: Colors.green),
                              onPressed: () => _showDeliveryDialog(delivery),
                            ),
                            IconButton(
                              icon: Icon(Icons.phone, color: Colors.blue),
                              onPressed: () =>
                                  _callPhoneNumber(delivery['phone']),
                            ),
                          ],
                        ),
                        onTap: () async {
                          final googleMapsUrl =
                              "https://www.google.com/maps/dir/?api=1&destination=${delivery['lat']},${delivery['lng']}";
                          if (await canLaunch(googleMapsUrl)) {
                            await launch(googleMapsUrl);
                          } else {
                            throw 'Could not open the map.';
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
