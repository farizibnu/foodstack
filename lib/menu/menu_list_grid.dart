import 'package:flutter/material.dart';
import 'package:foodstack/detail/detail_screen.dart';
import 'package:foodstack/models/menu.dart';
import 'package:foodstack/stream_controller.dart';

class MenuListGrid extends StatefulWidget {
  final int columns;

  const MenuListGrid({super.key, required this.columns});

  @override
  State<MenuListGrid> createState() => _MenuListGridState();
}

class _MenuListGridState extends State<MenuListGrid> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: widget.columns,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: menuData.asMap().entries.map((entry) {
          final int index = entry.key;
          final Menu menu = entry.value;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300, width: 2),
              color: Colors.white,
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(menu: menu),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      height: 150,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(menu.imageAsset, fit: BoxFit.cover),
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
                              child: Text(
                                menu.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange[50],
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: Colors.orange.shade200),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    color: Colors.orange[200],
                                    size: 14,
                                  ),
                                  Text(
                                    menu.rating,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time_rounded,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              '${menu.time} | ${menu.calorie}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              r"$" + menu.price.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      menuData[index].isFavorite =
                                          !menuData[index].isFavorite;
                                      if (menuData[index].isFavorite) {
                                        favoriteMenus.add(menuData[index]);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                '${menu.name} added to favorite!'),
                                            duration:
                                                const Duration(seconds: 2),
                                          ),
                                        );
                                      } else {
                                        favoriteMenus.removeWhere((menu) =>
                                            menu.id == menuData[index].id);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                '${menu.name} removed from favorite!'),
                                            duration:
                                                const Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                    });
                                  },
                                  icon: menu.isFavorite
                                      ? const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : const Icon(
                                          Icons.favorite_border,
                                        ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    addToCart(menu);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('${menu.name} added to cart!'),
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
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(10),
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        size: 16,
                                      ),
                                      SizedBox(width: 4),
                                      Text('Add'),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
