import 'package:get/get.dart';

class StockController extends GetxController {
  var activeTab = '1D'.obs;
  void setActiveTab(String tab) {
    activeTab.value = tab;
  }

  var stocks = <dynamic>[].obs;

  void addStock(dynamic stock) {
    stocks.add(stock);
  }

  void removeStock(dynamic stock) {
    stocks.remove(stock);
  }
}
