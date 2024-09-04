import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_trading_app/controller/json_controller.dart';
import 'package:stock_trading_app/controller/stock_controller/stock_controller.dart';
import 'package:stock_trading_app/view/common_widgets/swow_toast.dart';
import 'package:stock_trading_app/view/stock_details/stock_details.dart';

class WatchListScreen extends StatelessWidget {
  WatchListScreen({super.key});

  final JsonController jsonController = Get.put(JsonController());
  final StockController stockController = Get.put(StockController());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: const Color(0xFF097969),
        backgroundColor: Colors.black,
        title: const Text(
          'Stock Watchlist',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search container
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[800],
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
                children: [
                  const Icon(
                    Icons.search,
                    color: Color(0xFF097969),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search Stock',
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Text(
                    'Your watchlist',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      indent: 10,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: stockController.stocks.isEmpty
                  ? const Center(
                      child: Text(
                        'No stocks in your watchlist',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: stockController.stocks.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final stock = stockController.stocks[index];
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              // Watchlist items
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          StockDetailsScreen(stock: stock),
                                    ),
                                  );
                                },
                                child: Container(
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
                                    color: Colors.grey[850],
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 0,
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                        color: const Color(0xFF097969)
                                            .withOpacity(0.7),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '\$${stock['currentPrice'].toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color:
                                                  stock['percentageChange'] < 0
                                                      ? Colors.red
                                                      : Colors.green,
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
                                                  stock['percentageChange'] < 0
                                                      ? Colors.red
                                                      : Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Remove widget
                              GestureDetector(
                                onTap: () {
                                  // Remove function
                                  stockController.stocks.remove(stock);
                                  stockController.stockBox
                                      .put('stocks', stockController.stocks);
                                  showToastGreen(
                                      msg: 'Stock removed successfully!');
                                },
                                child: Container(
                                  width: screenSize.width / 6,
                                  height: screenSize.width / 4,
                                  margin: const EdgeInsets.only(
                                      right: 10, left: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red,
                                  ),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Text(
                    'Recommandations',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      indent: 10,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: FutureBuilder<List<dynamic>>(
                future: jsonController.loadStockData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF097969),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    log('Error: ${snapshot.error}');
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final allStocks = snapshot.data!;
                    final storedStocks = stockController.stocks;
                    final filteredStocks = allStocks.where((stock) {
                      return !storedStocks.any((storedStock) =>
                          storedStock['symbol'] == stock['symbol']);
                    }).toList();
                    if (filteredStocks.isEmpty) {
                      return const Center(
                        child: Text(
                          'No new stocks available',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemCount: filteredStocks.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final stock = filteredStocks[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    StockDetailsScreen(stock: stock),
                              ),
                            );
                          },
                          child: Container(
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
                              color: Colors.grey[850],
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 0,
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                  color:
                                      const Color(0xFF097969).withOpacity(0.7),
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
                                    const SizedBox(height: 10),
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
                                        color: stock['percentageChange'] < 0
                                            ? Colors.red
                                            : Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
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
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'No data found',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
