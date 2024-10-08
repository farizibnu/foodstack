import 'package:flutter/material.dart';
import 'package:foodstack/detail/detail_screen.dart';
import 'package:foodstack/models/menu.dart';
import 'package:foodstack/stream_controller.dart';

class FavoriteMenuList extends StatefulWidget {
  final List<Menu> favoriteMenus;

  const FavoriteMenuList({required this.favoriteMenus, super.key});

  @override
  State<FavoriteMenuList> createState() => _FavoriteMenuListState();
}

class _FavoriteMenuListState extends State<FavoriteMenuList> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: widget.favoriteMenus.length,
      itemBuilder: (context, index) {
        final Menu menu = widget.favoriteMenus[index];
        return Container(
          padding: const EdgeInsets.only(right: 8),
          margin: const EdgeInsets.symmetric(vertical: 4),
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
                  builder: (context) => DetailScreen(
                    menu: menu,
                  ),
                ),
              );
            },
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(menu.imageAsset, fit: BoxFit.cover),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
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
                              border: Border.all(color: Colors.orange.shade200),
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
                                  setState(
                                    () {
                                      menu.isFavorite = !menu.isFavorite;
                                      if (menu.isFavorite) {
                                        widget.favoriteMenus.add(menu);
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
                                        widget.favoriteMenus.removeWhere(
                                          (favMenu) => favMenu.id == menu.id,
                                        );
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
                                    },
                                  );
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
      },
    );
  }
}
