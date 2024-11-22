import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/dummy_data.dart';
import 'package:untitled/screens/home/drawer.dart';

class PastLoadsPage extends StatefulWidget {
  final List<Map<String, dynamic>> addresses;

  PastLoadsPage({required this.addresses});

  @override
  _PastLoadsPageState createState() => _PastLoadsPageState();
}

class _PastLoadsPageState extends State<PastLoadsPage> {
  late List<Map<String, dynamic>> filteredAddresses;
  TextEditingController searchController = TextEditingController();
  String selectedDate = '';
  String statusFilter = 'All';

  @override
  void initState() {
    super.initState();
    filteredAddresses = widget.addresses;
  }

  void _filterBySearch(String query) {
    print("DJflkdsjgkdsjkgljdsgkmds");
    setState(() {
      filteredAddresses = widget.addresses
          .where((address) => address['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _filterByDate(DateTime date) {
    String formattedDate = DateFormat('dd MMM yyyy').format(date);
    setState(() {
      selectedDate = formattedDate;
      filteredAddresses = widget.addresses
          .where((address) =>
          DateFormat('dd MMM yyyy')
              .format(DateTime.parse(address['deliveryTime']))
              .contains(formattedDate))
          .toList();
      _applyStatusFilter(); // Reapply the status filter after date filter
    });
  }

  void _applyStatusFilter() {
    if (statusFilter == 'Delivered') {
      filteredAddresses = widget.addresses
          .where((address) => address['delivered'] == true && address['cancelled'] == false)
          .toList();
    } else if (statusFilter == 'Cancelled') {
      filteredAddresses = widget.addresses.where((address) => address['cancelled'] == true).toList();
    } else{
      filteredAddresses= widget.addresses;
    }
  }

  void _resetFilters() {
    setState(() {
      filteredAddresses = widget.addresses;
      selectedDate = '';
      searchController.clear();
      statusFilter = 'All';
    });
  }

  void _showFilterOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter by Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('All'),
                onTap: () {
                  setState(() {
                    statusFilter = 'All';
                    _applyStatusFilter();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Delivered'),
                onTap: () {
                  setState(() {
                    statusFilter = 'Delivered';
                    _applyStatusFilter();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Cancelled'),
                onTap: () {
                  setState(() {
                    statusFilter = 'Cancelled';
                    _applyStatusFilter();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Deliveries', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Container(
              width: 150,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('Total Earnings: 2000',style: TextStyle(fontSize: 14),),
            ),
          ],
        ),
      ),
      drawer: buildDrawer(context:context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search by name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: _filterBySearch,
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.sort),
                  onPressed: _showFilterOptions,
                ),
              ],
            ),
          ),
          if (selectedDate.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Filtered by: $selectedDate', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          Expanded(
            child: filteredAddresses.isEmpty
                ? Center(child: Text('No deliveries found.'))
                : ListView.separated(
              itemCount: filteredAddresses.length,
              separatorBuilder: (context, index) => Divider(color: Colors.grey, height: 2),
              itemBuilder: (context, index) {
                final address = filteredAddresses[index];
                return

                   ListTile(
                    title: Text(address['name']),
                    subtitle: Text('${address['deliveryTime']} • 5 days'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              color: address['cancelled'] ? Colors.red : Colors.green,

                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text( address['abort'] ??
                              address['delivered']
                                            ? 'Completed'
                                            : 'Failed',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(address['reward'].toString()),
                        const Icon(Icons.more_vert),
                      ],
                    ),
                  );

                // return Container(
                //   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                //   child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           address['name'],
                //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                //         ),
                //         SizedBox(height: 10),
                //         Text(
                //           'Product: ${address['product']}',
                //           style: TextStyle(fontSize: 16, color: Colors.black87),
                //         ),
                //         SizedBox(height: 6),
                //         Text(
                //           'Address: ${address['address']}',
                //           style: TextStyle(fontSize: 14, color: Colors.black54),
                //         ),
                //         SizedBox(height: 6),
                //         Text(
                //           'Delivered on: ${address['deliveryTime']}',
                //           style: TextStyle(fontSize: 14, color: Colors.black54),
                //         ),
                //         SizedBox(height: 6),
                //         Text(
                //           address['delivered']
                //               ? 'Status: Delivered'
                //               : 'Status: Cancelled',
                //           style: TextStyle(
                //             color: address['cancelled'] ? Colors.red : Colors.green,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}
