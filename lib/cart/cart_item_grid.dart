import 'package:flutter/material.dart';
import 'package:foodstack/models/menu.dart';
import 'package:foodstack/stream_controller.dart';

class CartItemGrid extends StatelessWidget {
  const CartItemGrid({
    super.key,
    required this.columns,
  });

  final int columns;

  double getTotalPrice() {
    double total = 0.0;
    for (var menu in carts.keys) {
      total += carts[menu]! * menu.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: cartStreamController.stream,
      initialData: carts.length,
      builder: (context, snapshot) {
        if (carts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/empty_cart.png'),
                const Text(
                  'Your Cart is Empty',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }
        return GridView.count(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          crossAxisCount: columns,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: carts.keys.map((menu) {
            final int quatity = carts[menu]!;
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300, width: 2),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        height: 100,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            menu.imageAsset,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  menu.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  onPressed: () {
                                    removeAllFromCart(menu);
                                  },
                                  icon: const Icon(
                                    Icons.delete_outline_rounded,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            r"$" + menu.price.toString(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  removeFromCart(menu);
                                  cartStreamController.add(carts.length);
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.black,
                                  size: 15,
                                ),
                                constraints: const BoxConstraints.tightFor(
                                    width: 30, height: 30),
                                style: const ButtonStyle(
                                  side: WidgetStatePropertyAll(
                                    BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                quatity.toString(),
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              IconButton(
                                onPressed: () {
                                  addToCart(menu);
                                  cartStreamController.add(carts.length);
                                },
                                icon: const Icon(Icons.add,
                                    color: Colors.white, size: 15),
                                constraints: const BoxConstraints.tightFor(
                                    width: 30, height: 30),
                                style: const ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(Colors.black),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
