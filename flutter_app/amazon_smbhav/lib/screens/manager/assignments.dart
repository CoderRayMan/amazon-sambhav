import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/screens/manager/widgets/sidebar.dart';

class Task {
  final String name;
  final String assignedTo;
  final String email;
  final String date;
  final String itemCount;
  final String status;

  Task({
    required this.name,
    required this.assignedTo,
    required this.email,
    required this.date,
    required this.itemCount,
    required this.status,
  });
}

class AssignmentsScreen extends StatefulWidget {
  const AssignmentsScreen({super.key});

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  String _selectedTab = 'Packers';
  String _selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();

  final List<Task> packersTasks = [
    Task(
      name: 'Box Packaging',
      assignedTo: 'John Doe',
      email: 'john@domain.com',
      date: DateFormat('MMMM d').format(DateTime.now()),
      itemCount: '50',
      status: 'In Progress',
    ),
    Task(
      name: 'Loading Boxes',
      assignedTo: 'Jane Smith',
      email: 'jane@domain.com',
      date: DateFormat('MMMM d').format(DateTime.now().add(const Duration(days: 1))),
      itemCount: '30',
      status: 'Pending',
    ),
  ];

  final List<Task> moversTasks = [
    Task(
      name: 'Delivering Furniture',
      assignedTo: 'Michael Brown',
      email: 'michael@domain.com',
      date: DateFormat('MMMM d').format(DateTime.now().add(const Duration(days: 2))),
      itemCount: '10',
      status: 'Completed',
    ),
    Task(
      name: 'Transporting Goods',
      assignedTo: 'Sarah Connor',
      email: 'sarah@domain.com',
      date: DateFormat('MMMM d').format(DateTime.now().subtract(const Duration(days: 1))),
      itemCount: '15',
      status: 'In Progress',
    ),
  ];

  List<Task> get _tasks {
    if (_selectedTab == 'Packers') {
      return packersTasks;
    } else {
      return moversTasks;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: Drawer(
        child: SidebarMenu(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal[100],

        title: Text(
          'Assignments Dashboard',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor:  Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _buildTabSelector(),
              const SizedBox(height: 16),
              _buildFilters(),
              const SizedBox(height: 16),
              _buildSearchBar(),
              const SizedBox(height: 16),
              Expanded(
                child: _buildTaskList(),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget _buildTabSelector() {
    return Row(
      children: [
        _buildTab('Packers'),
        _buildTab('Movers'),
      ],
    );
  }

  Widget _buildTab(String title) {
    final isSelected = _selectedTab == title;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = title),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(

            border: Border(
              bottom: BorderSide(
                color: isSelected ? Colors.teal : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip('All'),
          _buildFilterChip('Pending'),
          _buildFilterChip('In Progress'),
          _buildFilterChip('Completed'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (bool selected) {
          setState(() => _selectedFilter = label);
        },
        backgroundColor: isSelected ? Colors.teal : Colors.white,
        selectedColor: Colors.teal[400],
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
        side: BorderSide(color: Colors.grey.shade300),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search all tasks...',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.teal[50],
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  Widget _buildTaskList() {
    return ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        return _buildTaskCard(_tasks[index]);
      },
    );
  }

  Widget _buildTaskCard(Task task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),


      ),

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.teal,
                  radius: 16,
                  child: Text(
                    task.assignedTo.substring(0, 1),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.assignedTo, style: const TextStyle(color: Colors.black)),
                    Text(
                      task.email,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date: ${task.date}', style: const TextStyle(color: Colors.black)),
                Text('Items: ${task.itemCount}', style: const TextStyle(color: Colors.black)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    task.status,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.launch, color: Colors.green),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
