import 'package:flutter/material.dart';
import 'package:foodstack/cart/cart_screen.dart';
import 'package:foodstack/models/menu.dart';
import 'package:foodstack/stream_controller.dart';

class DetailWebPage extends StatelessWidget {
  const DetailWebPage({super.key, required this.menu});

  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartScreen(),
                            ),
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
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 300,
                        child: Image.asset(
                          menu.imageAsset,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            menu.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            menu.status,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: menu.status == 'Available'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            margin: const EdgeInsets.only(left: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.star_border_rounded,
                                          color: Colors.orange[300], size: 20),
                                      const SizedBox(width: 5),
                                      Text(menu.rating,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                            color: Colors.grey, width: 2),
                                        right: BorderSide(
                                            color: Colors.grey, width: 2),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.access_time_rounded,
                                            color: Colors.orange[300],
                                            size: 20),
                                        const SizedBox(width: 5),
                                        Text(menu.time,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.local_fire_department_outlined,
                                          color: Colors.orange[300], size: 20),
                                      const SizedBox(width: 5),
                                      Text(menu.calorie,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(menu.description),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Total Amount: "),
                        Text(
                          r"$" + menu.price.toString(),
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (menu.status == 'Available') {
                          addToCart(menu);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${menu.name} added to cart!'),
                              duration: const Duration(seconds: 2),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  removeFromCart(menu);
                                },
                              ),
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                        padding: const WidgetStatePropertyAll(
                          EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                        ),
                        backgroundColor: WidgetStatePropertyAll(
                            menu.status == 'Available'
                                ? Colors.orange[300]
                                : Colors.grey),
                      ),
                      child: Text(
                        "Add to cart",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: menu.status == 'Available'
                              ? Colors.black
                              : Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
