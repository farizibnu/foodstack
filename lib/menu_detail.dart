import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:foodstack/cart_screen.dart';
import 'package:foodstack/models/menu.dart';
import 'package:foodstack/stream_controller.dart';

class MenuDetail extends StatelessWidget {
  const MenuDetail({super.key, required this.menu});

  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
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
                                      style: TextStyle(
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
                  ),
                )
              ],
            ),
            SizedBox(
              height: 300,
              child: Image.asset(
                menu.imageAsset,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        menu.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        menu.status,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: menu.status == 'Available'
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star_border_rounded,
                              color: Colors.orange[300], size: 20),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(menu.rating,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(color: Colors.grey, width: 2),
                          right: BorderSide(color: Colors.grey, width: 2),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.access_time_rounded,
                              color: Colors.orange[300], size: 20),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(menu.time,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.local_fire_department_outlined,
                              color: Colors.orange[300], size: 20),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(menu.calorie,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: Text(menu.description),
            ),
          ],
        ),
      ),
      bottomSheet: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(0),
        dashPattern: const [4, 4],
        strokeCap: StrokeCap.round,
        color: Colors.grey,
        // padding: EdgeInsets(),
        child: SizedBox(
          height: 85,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                },
                style: ButtonStyle(
                  padding: const WidgetStatePropertyAll(
                      EdgeInsets.only(left: 50, right: 50)),
                  backgroundColor: menu.status == 'Available'
                      ? WidgetStatePropertyAll(Colors.orange[300])
                      : const WidgetStatePropertyAll(Colors.grey),
                  elevation: WidgetStatePropertyAll(
                    menu.status == 'Available' ? 0 : 4,
                  ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
