import 'package:flutter/material.dart';
import 'package:foodstack/models/menu.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: menuData.length,
      itemBuilder: (context, index) {
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
                          child: Image.asset("assets/images/beef_burger.jpg",
                              fit: BoxFit.cover),
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
                            child: const Text("Menu Name"),
                          ),
                          const Text("Menu Price"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {},
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
                onPressed: () {},
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
  }
}
