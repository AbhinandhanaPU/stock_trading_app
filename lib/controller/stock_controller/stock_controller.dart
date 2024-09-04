import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

class StockController extends GetxController {
  var activeTab = '1D'.obs;
  var stocks = <dynamic>[].obs;

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
}
