import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_trading_app/controller/stock_controller/stock_controller.dart';
import 'package:stock_trading_app/view/widgets/swow_toast.dart';

class SearchScreen extends StatelessWidget {
  final List<dynamic> allStocks;

  SearchScreen({super.key, required this.allStocks});
  final StockController stockController = Get.put(StockController());

  @override
  Widget build(BuildContext context) {
    stockController.searchController.clear();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                      controller: stockController.searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(0),
                        hintText: 'Search Stock',
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                        ),
                        suffix: TextButton(
                          onPressed: () {
                            stockController.searchController.clear();
                            stockController.searchStocks(allStocks, '');
                          },
                          child: const Text(
                            'Clear',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF097969),
                            ),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        stockController.searchStocks(allStocks, value);
                      },
                      onSubmitted: (value) {
                        stockController.searchStocks(allStocks, value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                final searchResults = stockController.searchResults;
                return searchResults.isEmpty
                    ? const Center(
                        child: Text(
                          'Saerch symbol or company name',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: searchResults.length,
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.grey[700],
                          indent: 18,
                          endIndent: 18,
                        ),
                        itemBuilder: (context, index) {
                          final stock = searchResults[index];
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            leading: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: const Color(0xFF097969).withOpacity(0.3),
                                border: Border.all(
                                  color: const Color(0xFF097969),
                                ),
                              ),
                              child: Text(
                                stock['symbol'],
                                style: const TextStyle(
                                  color: Color(0xFF097969),
                                ),
                              ),
                            ),
                            title: Text(
                              stock['companyName'],
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color(0xFF097969),
                              ),
                            ),
                            trailing: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF097969).withOpacity(0.5),
                                border: Border.all(
                                  color: const Color(0xFF097969),
                                ),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  color: Color(0xFF097969),
                                ),
                                onPressed: () {
                                  if (stockController.stocks.contains(stock)) {
                                    showToastRed(
                                        msg:
                                            'Stock is already in the watchlist');
                                  } else if (stockController.stocks.length >=
                                      2) {
                                    showToastRed(
                                        msg:
                                            'Watchlist is full. Remove a stock to add a new one.');
                                  } else {
                                    stockController.stocks.add(stock);
                                    stockController.stockBox
                                        .put('stocks', stockController.stocks);
                                    showToastGreen(
                                        msg: 'Stock added successfully!');
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      );
              }),
            )
          ],
        ),
      ),
    );
  }
}
