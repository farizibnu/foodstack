import 'package:flutter/material.dart';
import 'package:foodstack/detail/detail_mobile_page.dart';
import 'package:foodstack/detail/detail_web_page.dart';
import 'package:foodstack/models/menu.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.menu});

  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return DetailWebPage(menu: menu);
        } else {
          return DetailMobilePage(menu: menu);
        }
      },
    );
  }
}
