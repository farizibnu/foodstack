import 'package:flutter/material.dart';
import 'package:foodstack/cart/cart_item.dart';
import 'package:foodstack/cart/cart_item_grid.dart';
import 'package:foodstack/models/menu.dart';
import 'package:foodstack/models/transaction.dart';
import 'package:foodstack/stream_controller.dart';
import 'package:foodstack/cart/success_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const cartItem = CartItem();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          'My Cart',
          style: GoogleFonts.baloo2(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.orange[500],
          ),
        ),
        centerTitle: true,
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
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 1200) {
                  return const CartItemGrid(columns: 4);
                } else if (constraints.maxWidth > 600) {
                  return const CartItemGrid(columns: 3);
                } else {
                  return const CartItem();
                }
              },
            ),
          ),
          const Divider(
            thickness: 1,
            endIndent: 16,
            indent: 16,
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: StreamBuilder<Object>(
                stream: cartStreamController.stream,
                initialData: carts.length,
                builder: (context, snapshot) {
                  double subtotal = cartItem.getTotalPrice();
                  double deliveryFee = carts.length * 0.25;
                  double tax = subtotal * 0.12;
                  double total = subtotal + deliveryFee + tax;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Payment Detail',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Subtotal"),
                              Text(
                                r"$" + subtotal.toStringAsFixed(2),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Delivery fee"),
                              Text(
                                r"$" + deliveryFee.toStringAsFixed(2),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Tax"),
                              Text(
                                r"$" + tax.toStringAsFixed(2),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                r"$" + total.toStringAsFixed(2),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: carts.isNotEmpty
                                ? () {
                                    double totalPrice = 0.0;
                                    carts.forEach((menu, quantity) {
                                      totalPrice += menu.price * quantity;
                                    });

                                    Transaction newTransaction = Transaction(
                                      date: DateTime.now(),
                                      items: Map.from(carts),
                                      totalPrice: totalPrice,
                                    );
                                    transactionHistory.add(newTransaction);

                                    carts.clear();
                                    cartStreamController.add(carts.length);
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            SuccessScreen(total: total),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          const begin = Offset(
                                            1.0,
                                            0.0,
                                          );
                                          const end = Offset(
                                            0.0,
                                            0.0,
                                          );
                                          const curve = Curves.easeInOut;

                                          final tween =
                                              Tween(begin: begin, end: end);
                                          final curvedAnimation =
                                              CurvedAnimation(
                                            parent: animation,
                                            curve: curve,
                                          );

                                          return SlideTransition(
                                            position:
                                                tween.animate(curvedAnimation),
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                  }
                                : null,
                            style: ButtonStyle(
                              padding: const WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(vertical: 20)),
                              elevation: const WidgetStatePropertyAll(0),
                              backgroundColor: WidgetStatePropertyAll(
                                carts.isNotEmpty
                                    ? Colors.orange[300]
                                    : Colors.grey,
                              ),
                            ),
                            child: Text(
                              "Confirm Payment",
                              style: TextStyle(
                                color: carts.isNotEmpty
                                    ? Colors.black
                                    : Colors.grey.shade400,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
