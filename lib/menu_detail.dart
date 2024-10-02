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
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_rounded),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.shopping_cart_rounded),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: 300,
              child: Image.asset(
                menu.imageAsset,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        menu.name,
                        style: TextStyle(
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
                        icon: Icon(
                          Icons.remove,
                          color: Colors.black,
                          size: 15,
                        ),
                        constraints:
                            BoxConstraints.tightFor(width: 30, height: 30),
                        style: ButtonStyle(
                          side: WidgetStatePropertyAll(
                            BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "2",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add, color: Colors.white, size: 15),
                        constraints:
                            BoxConstraints.tightFor(width: 30, height: 30),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.black),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(),
            Container(),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total Amount: "),
                Text(
                  r"$" + menu.price.toString(),
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: menu.status == 'Available' ? () {} : null,
              style: ButtonStyle(
                backgroundColor: menu.status == 'Available'
                    ? WidgetStatePropertyAll(Colors.lime[300])
                    : WidgetStatePropertyAll(Colors.grey),
                elevation:
                    WidgetStatePropertyAll(menu.status == 'Available' ? 0 : 4),
              ),
              child: Text(
                "Add to cart",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: menu.status == 'Available'
                      ? Colors.black
                      : Colors.grey.shade300,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
