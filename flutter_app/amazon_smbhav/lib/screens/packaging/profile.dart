// import 'package:flutter/material.dart';
// import 'package:untitled/screens/home/drawer.dart';
//
// class DeliveryPersonProfileScreen extends StatelessWidget {
//   const DeliveryPersonProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.settings),
//             onPressed: () {
//               // Navigate to the profile edit screen
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const EditProfileScreen(),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       drawer: buildDrawer(context),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: CircleAvatar(
//                 radius: 50,
//                 backgroundImage: AssetImage('assets/delivery_person.jpg'), // Replace with the actual image
//               ),
//             ),
//             const SizedBox(height: 16),
//             Center(
//               child: Text(
//                 'John Doe', // Replace with delivery person's name
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Center(
//               child: Text(
//                 'Packaging Person',
//                 style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//             const Divider(),
//             const SizedBox(height: 16),
//             const Text(
//               'Contact Details',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: const [
//                 Icon(Icons.phone, color: Colors.green),
//                 SizedBox(width: 8),
//                 Text('123-456-7890'), // Replace with actual phone number
//               ],
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: const [
//                 Icon(Icons.email, color: Colors.green),
//                 SizedBox(width: 8),
//                 Text('johndoe@example.com'), // Replace with actual email
//               ],
//             ),
//             const SizedBox(height: 16),
//             const Divider(),
//             const SizedBox(height: 16),
//             const Text(
//               'Delivery Stats',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 const Icon(Icons.delivery_dining, color: Colors.green),
//                 const SizedBox(width: 8),
//                 Text(
//                   'Completed Deliveries: 50',
//                   style: Theme.of(context).textTheme.bodyLarge,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 const Icon(Icons.timer, color: Colors.green),
//                 const SizedBox(width: 8),
//                 Text(
//                   'Average Time per Delivery: 30 mins',
//                   style: Theme.of(context).textTheme.bodyLarge,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             const Divider(),
//             const SizedBox(height: 16),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Log out action
//                 },
//                 child: const Text('Log Out',style: TextStyle(color: Colors.white),),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class EditProfileScreen extends StatelessWidget {
//   const EditProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Edit Profile')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const Text(
//               'Edit your profile information below.',
//               style: TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               decoration: const InputDecoration(labelText: 'Name'),
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               decoration: const InputDecoration(labelText: 'Phone Number'),
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//               },
//               child: const Text('Save Changes'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
