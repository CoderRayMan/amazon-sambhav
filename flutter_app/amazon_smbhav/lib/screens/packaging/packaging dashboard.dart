import 'package:flutter/material.dart';
import 'package:untitled/main.dart';
import 'package:untitled/screens/packaging/load_items.dart';
// import 'package:flutter/material.dart';
// import 'package:untitled/main.dart';
// import 'package:untitled/screens/home/rewards.dart';
// import 'package:untitled/screens/packaging/load_items.dart';
// import 'package:untitled/screens/packaging/loading.dart';
//
//
// class PackagingDashboard extends StatefulWidget {
//   const PackagingDashboard({super.key});
//
//   @override
//   State<PackagingDashboard> createState() => _PackagingDashboardState();
// }
//
// class _PackagingDashboardState extends State<PackagingDashboard> {
//   String selectedFilter = 'All';
//   final searchController = TextEditingController();
//
//   final List<Task> tasks = [
//     Task(
//       name: 'Product Testing',
//       assignedTo: 'Emily',
//       assignedEmail: 'emily@domain.com',
//       date: 'June 5th',
//       itemCount: 200,
//       status: 'InProgress',
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             const DrawerHeader(
//
//               child: Text(
//                 'Vaanik',
//                 style: TextStyle(
//                   color: Colors.black87,
//                   fontSize: 24,
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.dashboard),
//               title: const Text('Package Dashboard'),
//
//             ),
//             ListTile(
//               leading: Icon(Icons.card_giftcard),
//               title: Text('Rewards'),
//
//             ),
//             ListTile(
//               leading: const Icon(Icons.person),
//               title: const Text('Profile'),
//
//             ),
//             ListTile(
//               leading: Icon(Icons.logout),
//               title: Text('Logout'),
//               onTap: () {
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => InitialPage()),
//                       (Route<dynamic> route) => false,
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//
//       appBar: AppBar(
//         title: const Text(
//           'Packaging Dashboard',
//           style: TextStyle(color: Colors.black87),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               'All Tasks',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//           ),
//           StatusFilter(
//             selectedFilter: selectedFilter,
//             onFilterChanged: (filter) {
//               setState(() {
//                 selectedFilter = filter;
//               });
//             },
//           ),
//           const SizedBox(height: 16),
//           SearchBar(controller: searchController),
//           const SizedBox(height: 16),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               children: const [
//                 Expanded(
//                   flex: 2,
//                   child: Text('Task Name', style: TextStyle(fontWeight: FontWeight.w600)),
//                 ),
//                 Expanded(
//                   flex: 2,
//                   child: Text('Assigned To', style: TextStyle(fontWeight: FontWeight.w600)),
//                 ),
//                 Expanded(
//                   child: Text('Date', style: TextStyle(fontWeight: FontWeight.w600)),
//                 ),
//                 Expanded(
//                   child: Text('Item Count', style: TextStyle(fontWeight: FontWeight.w600)),
//                 ),
//                 Expanded(
//                   child: Text('Status', style: TextStyle(fontWeight: FontWeight.w600)),
//                 ),
//                 SizedBox(width: 60),
//               ],
//             ),
//           ),
//           const Divider(),
//           Expanded(
//             child: ListView.builder(
//               itemCount: tasks.length,
//               itemBuilder: (context, index) => TaskListItem(task: tasks[index]),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class Task {
//   final String name;
//   final String assignedTo;
//   final String assignedEmail;
//   final String date;
//   final int itemCount;
//   final String status;
//
//   Task({
//     required this.name,
//     required this.assignedTo,
//     required this.assignedEmail,
//     required this.date,
//     required this.itemCount,
//     required this.status,
//   });
// }

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
          _buildFilterChip('Pending'),
          const SizedBox(width: 8),
          _buildFilterChip('In Progress'),
          const SizedBox(width: 8),
          _buildFilterChip('Completed'),
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
      backgroundColor: isSelected ? Colors.blue.withOpacity(0.1) : Colors.grey[200],
      selectedColor: Colors.blue.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected ? Colors.blue : Colors.black87,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? Colors.blue : Colors.transparent,
        ),
      ),
    );
  }
}


class SearchBar extends StatelessWidget {
  final TextEditingController controller;

  const SearchBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search all tasks...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}


// class TaskListItem extends StatelessWidget {
//   final Task task;
//
//   const TaskListItem({
//     super.key,
//     required this.task,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(task.name),
//           ),
//           Expanded(
//             flex: 2,
//             child: Row(
//               children: [
//                 // CircleAvatar(
//                 //   radius: 16,
//                 //   backgroundColor: Colors.blue,
//                 //   child: Text(
//                 //     task.assignedTo[0],
//                 //     style: const TextStyle(color: Colors.white),
//                 //   ),
//                 // ),
//                 const SizedBox(width: 8),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(task.assignedTo),
//                     // Text(
//                     //   task.assignedEmail,
//                     //   style: TextStyle(
//                     //     color: Colors.grey[600],
//                     //     fontSize: 12,
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Text(task.date),
//           ),
//           Expanded(
//             child: Text(task.itemCount.toString()),
//           ),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: Colors.blue.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 task.status,
//                 style: const TextStyle(
//                   color: Colors.blue,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.launch, color: Colors.blue),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) =>  LoadItemsScreen()
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }



class PackagingDashboard extends StatefulWidget {
  const PackagingDashboard({super.key});

  @override
  State<PackagingDashboard> createState() => _PackagingDashboardState();
}

class _PackagingDashboardState extends State<PackagingDashboard> {
  String selectedFilter = 'All';
  final searchController = TextEditingController();

  final List<Task> tasks = [
    Task(
      name: 'Product Loading',
      assignedTo: 'Emily',
      assignedEmail: 'emily@domain.com',
      date: 'June 5th',
      itemCount: 200,
      status: 'In Progress',
    ),
    Task(
      name: 'Quality Check',
      assignedTo: 'John',
      assignedEmail: 'john@domain.com',
      date: 'June 6th',
      itemCount: 150,
      status: 'Completed',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue[100]),
              child: Row(
                children: [

                  const SizedBox(width: 16),
                  const Text(
                    'Vaanik'
                        ,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.dashboard, 'Package Dashboard', onTap: () {}),
            _buildDrawerItem(Icons.card_giftcard, 'Rewards', onTap: () {}),
            _buildDrawerItem(Icons.person, 'Profile', onTap: () {}),
            _buildDrawerItem(Icons.logout, 'Logout', onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) =>  InitialPage()),
                    (Route<dynamic> route) => false,
              );
            }),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Packaging Dashboard',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black87),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'All Tasks',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          StatusFilter(
            selectedFilter: selectedFilter,
            onFilterChanged: (filter) {
              setState(() {
                selectedFilter = filter;
              });
            },
          ),
          const SizedBox(height: 16),
          SearchBar(controller: searchController),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) => TaskCard(task: tasks[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, {required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      onTap: onTap,
    );
  }
}

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        title: Text(task.name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Assigned To: ${task.assignedTo}', style: const TextStyle(fontSize: 14)),
            Text('Due: ${task.date}', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: task.status == 'Completed'
                ? Colors.green.withOpacity(0.2)
                : Colors.blue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            task.status,
            style: TextStyle(
              color: task.status == 'Completed' ? Colors.green : Colors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoadItemsScreen()));
        },
      ),
    );
  }
}

class Task {
  final String name;
  final String assignedTo;
  final String assignedEmail;
  final String date;
  final int itemCount;
  final String status;

  Task({
    required this.name,
    required this.assignedTo,
    required this.assignedEmail,
    required this.date,
    required this.itemCount,
    required this.status,
  });
}
