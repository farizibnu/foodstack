import 'package:flutter/material.dart';
import 'package:foodstack/cart_screen.dart';
import 'package:foodstack/menu_list.dart';
import 'package:foodstack/menu_recommendation.dart';
import 'package:foodstack/models/menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.food_bank_rounded),
            SizedBox(
              width: 5,
            ),
            Text(
              'FoodStack',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CartScreen()),
                        );
                    },
                    icon: const Icon(Icons.shopping_cart_rounded),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 15,
                      ),
                      child: Text(
                        carts.length.toString(), // Replace with the actual number of items
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10,)
            ],
          )
        ],
        surfaceTintColor: Colors.transparent,
        backgroundColor: const Color(0xFFF8F8F8),
      ),
      backgroundColor: const Color(0xFFF8F8F8),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: const Text(
                  'Recommendation',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  MenuRecommendation(),
                  const SizedBox(width: 10),
                  MenuRecommendation(),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: const Text(
                  'All Menu',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const MenuList()
            ],
          ),
        ),
      ),
      // bottomNavigationBar: ,
    );
  }
}
