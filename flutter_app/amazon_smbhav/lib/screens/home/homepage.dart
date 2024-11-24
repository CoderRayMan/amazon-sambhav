import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/screens/home/drawer.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

class DeliveryPage extends StatefulWidget {
  @override
  _DeliveryPageState createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  final List<String> etaList = [
    "1.5 hrs",
    "2 hrs",
    "45 mins",
    "30 mins",
    "1 hr",
    "3 hrs"
  ];

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
      final url = Uri.parse("https://a6k5eg0vc0.execute-api.us-east-1.amazonaws.com/s1/route-ops?emp_id=D1001");
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
  String selectedFilter = 'All';

  Future<void> fetchMarkers() async {
    if (cachedData == null) return;

    Set<Marker> newMarkers = {};
    List<LatLng> routePoints = [];

    for (int i = 0; i < cachedData!.length; i++) {
      var delivery = cachedData![i];

      final latitude = delivery['lat'];
      final longitude = delivery['lng'];

      newMarkers.add(
        Marker(
          markerId: MarkerId(delivery['load_id'].toString()),
          position: LatLng(double.parse(latitude), double.parse(longitude)),
          infoWindow: InfoWindow(
            title: 'Delivery: $i\n${delivery['sequence']}',
            snippet: '${delivery['address']}',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );

      // Add points to the route list from index 1 to the last item
      if (i > 0) {
        routePoints.add(LatLng(double.parse(latitude), double.parse(longitude)));
      }
    }

    // Draw route (polyline) from index 1 to the last marker
    if (routePoints.isNotEmpty) {
      setState(() {
        routePolyline = Polyline(
          polylineId: PolylineId('route'),
          points: routePoints,
          color: Colors.blue,
          width: 5,
        );
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context: context),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search Delivery',
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            suffixIcon: const Icon(Icons.mic, color: Colors.grey),
            filled: true,
            fillColor: Colors.teal[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.teal),
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
                  height: 300,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(double.parse(filteredList[0]['lat']), double.parse(filteredList[0]['lng'])),
                      zoom: 10,
                    ),
                    markers: markers,
                    polylines: routePolyline != null ? {routePolyline!} : {},
                    onMapCreated: (controller) {
                      mapController = controller;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StatusFilter(
                    selectedFilter: selectedFilter,
                    onFilterChanged: (filter) {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                  ),
                ),                // DropdownButton<String>(
                //   value: filterValue,
                //   icon: Icon(Icons.filter_list),
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       filterValue = newValue!;
                //     });
                //   },
                //   items: <String>['All', 'Delivered', 'Cancelled', 'To Deliver']
                //       .map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                // ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final delivery = filteredList[index];
                      String eta = etaList[index % etaList.length];

                      return ListTile(
                        title: Text('Delivery ${delivery['sequence']}'),
                        subtitle: Text("${delivery['address']}  •  ${eta}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () => {},
                            ),
                            IconButton(
                              icon: Icon(Icons.done, color: Colors.teal),
                              onPressed: () => {},
                            ),
                            IconButton(
                              icon: Icon(Icons.phone, color: Colors.teal),
                              onPressed: () => _callPhoneNumber(delivery['phone']),
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

class StatusFilter extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const StatusFilter({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildFilterChip('All'),
          const SizedBox(width: 8),
          _buildFilterChip('Delivered'),
          const SizedBox(width: 8),
          _buildFilterChip('Cancelled'),
          const SizedBox(width: 8),
          _buildFilterChip('To Deliver'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = selectedFilter == label;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        onFilterChanged(label);
      },
      backgroundColor: isSelected ? Colors.teal.withOpacity(0.1) : Colors.grey[200],
      selectedColor: Colors.teal.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected ? Colors.teal : Colors.black87,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? Colors.teal : Colors.transparent,
        ),
      ),
    );
  }
}

