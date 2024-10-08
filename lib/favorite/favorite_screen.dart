import 'package:flutter/material.dart';
import 'package:foodstack/cart/cart_screen.dart';
import 'package:foodstack/favorite/favorite_list.dart';
import 'package:foodstack/favorite/favorite_menu_grid.dart';
import 'package:foodstack/models/menu.dart';
import 'package:foodstack/stream_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite',
          style: GoogleFonts.baloo2(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.orange[500],
          ),
        ),
        centerTitle: true,
        actions: [
          Row(
            children: [
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
              const SizedBox(width: 10),
            ],
          )
        ],
        surfaceTintColor: Colors.transparent,
        backgroundColor: const Color(0xFFF8F8F8),
      ),
      backgroundColor: const Color(0xFFF8F8F8),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: favoriteMenus.isEmpty
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/empty_favorite.png'),
                    const Text(
                      'You Don\'t Have Any Favorite Menu',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 1200) {
                    return FavoriteMenuGrid(
                        columns: 6, favoriteMenus: favoriteMenus);
                  } else if (constraints.maxWidth > 600) {
                    return FavoriteMenuGrid(
                        columns: 3, favoriteMenus: favoriteMenus);
                  } else {
                    return FavoriteMenuList(favoriteMenus: favoriteMenus);
                  }
                },
              ),
      ),
    );
  }
}
