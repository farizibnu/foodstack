import 'package:flutter/material.dart';
import 'package:foodstack/cart_item.dart';
import 'package:foodstack/models/menu.dart';
import 'package:foodstack/stream_controller.dart';
import 'package:foodstack/success_screen.dart';

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
        title: const Text('My Cart'),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
      ),
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
                    double deliveryFee = 1.0; // Example delivery fee
                    double tax = 1.0; // Example tax
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Subtotal"),
                                  Text(subtotal.toStringAsFixed(2)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Delivery fee"),
                                  Text(deliveryFee.toStringAsFixed(2)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Tax"),
                                  Text(tax.toStringAsFixed(2)),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    total.toStringAsFixed(2),
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
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SuccessScreen(
                                              total: total,
                                            ),
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
                                        ? Colors.lime[300]
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
                  }),
            ),
          )
        ],
      ),
    );
  }
}
