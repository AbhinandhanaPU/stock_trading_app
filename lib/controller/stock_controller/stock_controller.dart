import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class StockController extends GetxController {
  var activeTab = '1D'.obs;
  void setActiveTab(String tab) {
    activeTab.value = tab;
  }

  List<FlSpot> getStockDataPoints(List<double> stockPrices) {
    return List.generate(stockPrices.length, (index) {
      return FlSpot(index.toDouble(), stockPrices[index]);
    });
  }
}
