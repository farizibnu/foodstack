import 'package:foodstack/models/menu.dart';

class Transaction {
  final DateTime date;
  final Map<Menu, int> items; 
  final double totalPrice;

  Transaction({
    required this.date,
    required this.items,
    required this.totalPrice,
  });
}
