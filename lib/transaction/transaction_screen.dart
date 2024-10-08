import 'package:flutter/material.dart';
import 'package:foodstack/stream_controller.dart';
import 'package:foodstack/transaction/transaction_grid.dart';
import 'package:foodstack/transaction/transaction_list.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transaction History',
          style: GoogleFonts.baloo2(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.orange[500],
          ),
        ),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: const Color(0xFFF8F8F8),
      ),
      backgroundColor: const Color(0xFFF8F8F8),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: transactionHistory.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/empty_cart.png'),
                      const Text(
                        'No Transaction History Available',
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
                      return const TransactionGrid(columns: 3);
                    } else if (constraints.maxWidth > 600) {
                      return const TransactionGrid(columns: 2);
                    } else {
                      return const TransactionList();
                    }
                  },
                ),
        ),
      ),
    );
  }
}
