import 'package:intl/intl.dart';

final List<Map<String, dynamic>> pastaddresses = [
  {
    'name': 'Rohit Sharma',
    'address': '123 MG Road, Apt. 4B, Mumbai, Maharashtra 400001',
    'delivered': true,
    'product': 'Mobile Phone',
    'deliveryTime': DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now()),
    'cancelled': false,
    'reward':800
  },
  {
    'name': 'Rajesh Kumar',
    'address': '78 Anna Salai, Chennai, Tamil Nadu 600002',
    'delivered': false,
    'product': 'Headphones',
    'deliveryTime': DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now()),
    'cancelled': true,
    'reward':-100

  },
  {
    'name': 'Priya Singh',
    'address': '56 Ashok Nagar, Noida, Uttar Pradesh 201301',
    'delivered': true,
    'product': 'Laptop',
    'deliveryTime': DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now()),
    'cancelled': false,
    'abort': true,
    'reward':400

  },
  {
    'name': 'Amit Patel',
    'address': '12 Gandhi Street, Ahmedabad, Gujarat 380001',
    'delivered': true,
    'product': 'Tablet',
    'deliveryTime': DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now()),
    'cancelled': false,
    'reward':200

  },
  {
    'name': 'Sunita Rao',
    'address': '45 Brigade Road, Bangalore, Karnataka 560025',
    'delivered': false,
    'product': 'Smartwatch',
    'deliveryTime': DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now()),
    'cancelled': true,
    'reward':-100

  },

  {
    'name': 'Neha Verma',
    'address': '98 Malabar Hill, Mumbai, Maharashtra 400006',
    'delivered': true,
    'product': 'TV',
    'deliveryTime': DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now()),
    'cancelled': false,
    'reward':600

  },
  {
    'name': 'Vikram Gupta',
    'address': '23 Lajpat Nagar, Delhi, 110024',
    'delivered': true,
    'product': 'Refrigerator',
    'deliveryTime': DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now()),
    'cancelled': false,
    'reward':200

  },
];
class ParkingReview {
  final String address;
  final String timeAgo;
  final int rating;
  final int points;
  final String status;

  ParkingReview({
    required this.address,
    required this.timeAgo,
    required this.rating,
    required this.points,
    required this.status,
  });
}

class Delivery {
  final String customerName;
  final String date;
  final String daysAgo;
  final String invoiceNumber;
  final String status;
  final int rewards;

  Delivery({
    required this.customerName,
    required this.date,
    required this.daysAgo,
    required this.invoiceNumber,
    required this.status,
    required this.rewards,
  });
}