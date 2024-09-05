import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class StockController extends GetxController {
  var activeTab = '1D'.obs;
  var stocks = <dynamic>[].obs;
  var searchResults = <dynamic>[].obs;
  TextEditingController searchController = TextEditingController();

  late Box stockBox;
  @override
  void onInit() {
    super.onInit();
    try {
      stockBox = Hive.box('stockBox');
      loadStocksFromHive();
      log("Hive box initialized successfully");
    } catch (e) {
      log("Error initializing Hive box: $e");
    }
  }

  void setActiveTab(String tab) {
    activeTab.value = tab;
  }

  void loadStocksFromHive() {
    var storedStocks = stockBox.get('stocks', defaultValue: <dynamic>[]);
    stocks.assignAll(storedStocks);
  }

  void searchStocks(List<dynamic> allStocks, String query) {
    if (query.isEmpty) {
      searchResults.value = [];
    } else {
      searchResults.value = allStocks.where((stock) {
        final symbol = stock['symbol'].toLowerCase();
        final companyName = stock['companyName'].toLowerCase();
        final lowerQuery = query.toLowerCase();
        return symbol.contains(lowerQuery) || companyName.contains(lowerQuery);
      }).toList();
    }
  }
}
