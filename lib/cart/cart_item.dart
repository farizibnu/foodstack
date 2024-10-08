import 'package:flutter/material.dart';
import 'package:foodstack/models/menu.dart';
import 'package:foodstack/stream_controller.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
  });

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
        return ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: carts.length,
          itemBuilder: (context, index) {
            final Menu menu = carts.keys.elementAt(index);
            final int quatity = carts[menu]!;
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300, width: 2),
                color: Colors.white,
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                menu.imageAsset,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(right: 24),
                                child: Text(
                                  menu.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
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
                  IconButton(
                    onPressed: () {
                      removeAllFromCart(menu);
                    },
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
