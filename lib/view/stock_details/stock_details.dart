import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_trading_app/controller/stock_controller/stock_controller.dart';
import 'package:stock_trading_app/view/stock_chart/stock_chart.dart';

class StockDetailsScreen extends StatelessWidget {
  final dynamic stock;
  const StockDetailsScreen({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final StockController stockController = Get.put(StockController());
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF097969),
          title: const Text(
            'Stock Details',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                border: Border.all(color: const Color(0xFF097969)),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                    color: Color(0xFF097969),
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF097969),
                        ),
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
                    children: [
                      Text(
                        '\$${stock['currentPrice'].toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          color: stock['percentageChange'] < 0
                              ? Colors.red
                              : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${stock['percentageChange'].toStringAsFixed(2)}%',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: stock['percentageChange'] < 0
                              ? Colors.red
                              : Colors.green,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TabOption(
                  text: '1D',
                  onTap: () {
                    stockController.setActiveTab('1D');
                  },
                ),
                TabOption(
                  text: '1W',
                  onTap: () {
                    stockController.setActiveTab('1W');
                  },
                ),
                TabOption(
                  text: '1M',
                  onTap: () {
                    stockController.setActiveTab('1M');
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Obx(() {
              final activeTab = stockController.activeTab.value;
              final priceHistory = stock['priceHistory'][activeTab] ?? [];

              return StockChart(
                priceHistory: priceHistory,
                interval: activeTab,
              );
            }),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: screenSize.width / 8,
                    width: screenSize.width / 2.3,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF097969),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'ADD',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: screenSize.width / 8,
                    width: screenSize.width / 2.3,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'REMOVE',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TabOption extends StatelessWidget {
  final String text;
  final Function() onTap;
  TabOption({
    super.key,
    required this.text,
    required this.onTap,
  });

  final StockController stockController = Get.put(StockController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          onTap();
          stockController.setActiveTab(text);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: stockController.activeTab.value == text
                ? const Color(0xFF097969)
                : Colors.grey[850],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: const Color(0xFF097969),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: stockController.activeTab.value == text
                  ? Colors.white
                  : const Color(0xFF097969),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    });
  }
}
