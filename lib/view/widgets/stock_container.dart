import 'package:flutter/material.dart';

class StockContainer extends StatelessWidget {
  final dynamic stock;

  const StockContainer({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width * 0.94,
      height: screenSize.width / 4,
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 20,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[900],
        boxShadow: [
          BoxShadow(
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
            color: const Color(0xFF097969).withOpacity(0.7),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stock['symbol'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF097969),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                stock['companyName'],
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${stock['currentPrice'].toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  color:
                      stock['percentageChange'] < 0 ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${stock['percentageChange'].toStringAsFixed(2)}%',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color:
                      stock['percentageChange'] < 0 ? Colors.red : Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
