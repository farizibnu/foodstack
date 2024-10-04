import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:foodstack/models/menu.dart';

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
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.shopping_cart_rounded),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.black,
                          size: 15,
                        ),
                        constraints:
                            const BoxConstraints.tightFor(width: 30, height: 30),
                        style: const ButtonStyle(
                          side: WidgetStatePropertyAll(
                            BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        "2",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add, color: Colors.white, size: 15),
                        constraints:
                            const BoxConstraints.tightFor(width: 30, height: 30),
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.black),
                        ),
                      )
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
                              color: Colors.lime[300], size: 20),
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
                              color: Colors.lime[300], size: 20),
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
                              color: Colors.lime[300], size: 20),
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
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: menu.status == 'Available' ? () {} : null,
                style: ButtonStyle(
                  padding: const WidgetStatePropertyAll(EdgeInsets.only(left: 50, right: 50)),
                  backgroundColor: menu.status == 'Available'
                      ? WidgetStatePropertyAll(Colors.lime[300])
                      : const WidgetStatePropertyAll(Colors.grey),
                  elevation: WidgetStatePropertyAll(
                      menu.status == 'Available' ? 0 : 4),
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
