import 'package:flutter/material.dart';
import 'package:foodstack/cart_item.dart';
import 'package:foodstack/models/menu.dart';
import 'package:foodstack/models/transaction.dart';
import 'package:foodstack/stream_controller.dart';
import 'package:foodstack/success_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItem = CartItem();

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
        surfaceTintColor: Colors.transparent,
        backgroundColor: const Color(0xFFF8F8F8),
      ),
      backgroundColor: const Color(0xFFF8F8F8),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              child: const CartItem(),
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
                  // Calculate subtotal, delivery fee, tax, and total
                  double subtotal = cartItem.getTotalPrice();
                  double deliveryFee = carts.length * 0.25;
                  double tax = subtotal * 0.12;
                  double total = subtotal + deliveryFee + tax;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Payment Detail',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Subtotal"),
                                Text(
                                  r"$" + subtotal.toStringAsFixed(2),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Delivery fee"),
                                Text(
                                  r"$" + deliveryFee.toStringAsFixed(2),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Tax"),
                                Text(
                                  r"$" + tax.toStringAsFixed(2),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  r"$" + total.toStringAsFixed(2),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
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
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
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
                                              position: tween
                                                  .animate(curvedAnimation),
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
                        ),
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
