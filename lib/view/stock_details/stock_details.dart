import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_trading_app/controller/stock_controller/stock_controller.dart';
import 'package:stock_trading_app/view/common_widgets/swow_toast.dart';
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
          backgroundColor: Colors.black,
          foregroundColor: const Color(0xFF097969),
          title: const Text(
            'Stock Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
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
            const SizedBox(height: 15),
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
            Obx(() {
              final activeTab = stockController.activeTab.value;
              final priceHistory = stock['priceHistory'][activeTab] ?? [];

              return StockChart(
                priceHistory: priceHistory,
                interval: activeTab,
              );
            }),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    child: SizedBox(
                      width: screenSize.width / 4,
                      child: const Text(
                        'Current Price',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF097969),
                        ),
                      ),
                    ),
                  ),
                  const Flexible(
                      child: Text(
                    " : ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF097969),
                    ),
                  )),
                  SizedBox(
                    width: screenSize.width / 4,
                    child: Text(
                      '\$${stock['currentPrice'].toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: stock['percentageChange'] < 0
                            ? Colors.red
                            : Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    child: SizedBox(
                      width: screenSize.width / 4,
                      child: const Text(
                        'Percentage Change',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF097969),
                        ),
                      ),
                    ),
                  ),
                  const Flexible(
                      child: Text(
                    ":",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF097969),
                    ),
                  )),
                  SizedBox(
                    width: screenSize.width / 4,
                    child: Text(
                      '${stock['percentageChange'].toStringAsFixed(2)}%',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: stock['percentageChange'] < 0
                            ? Colors.red
                            : Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (stockController.stocks.contains(stock)) {
                        showToastRed(msg: 'Stock is already in the watchlist');
                      } else if (stockController.stocks.length >= 2) {
                        showToastRed(
                            msg:
                                'Watchlist is full. Remove a stock to add a new one.');
                      } else {
                        stockController.stocks.add(stock);
                        stockController.stockBox
                            .put('stocks', stockController.stocks);
                        showToastGreen(msg: 'Stock added successfully!');
                      }
                    },
                    child: Container(
                      height: screenSize.width / 8,
                      width: screenSize.width / 2.3,
                      decoration: BoxDecoration(
                        color: const Color(0xFF097969),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          stockController.stocks.contains(stock)
                              ? 'ADDED'
                              : "ADD",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (stockController.stocks.contains(stock)) {
                        stockController.stocks.remove(stock);
                        stockController.stockBox
                            .put('stocks', stockController.stocks);
                        showToastGreen(msg: 'Stock removed successfully!');
                      } else {
                        showToastRed(msg: 'Stock not found in the watchlist.');
                      }
                    },
                    child: Container(
                      height: screenSize.width / 8,
                      width: screenSize.width / 2.3,
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
            )
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
