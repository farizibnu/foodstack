import 'package:flutter/material.dart';
import 'package:foodstack/cart/cart_screen.dart';
import 'package:foodstack/menu/menu_list.dart';
import 'package:foodstack/menu/menu_recommendation.dart';
import 'package:foodstack/menu/menu_list_grid.dart';
import 'package:foodstack/models/menu.dart';
import 'package:foodstack/stream_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.food_bank_rounded),
            const SizedBox(width: 5),
            Text(
              'FoodStack',
              style: GoogleFonts.baloo2(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.orange[500],
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
                        MaterialPageRoute(
                            builder: (context) => const CartScreen()),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart_rounded),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: StreamBuilder<int>(
                      stream: cartStreamController.stream,
                      initialData: carts.length,
                      builder: (context, snapshot) {
                        return Container(
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
                            snapshot.data.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
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
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 1200) {
                    return const MenuListGrid(columns: 6);
                  } else if (constraints.maxWidth > 600) {
                    return const MenuListGrid(columns: 3);
                  } else {
                    return const MenuList();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
