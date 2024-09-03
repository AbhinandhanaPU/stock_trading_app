import 'dart:convert'; // For JSON decoding

import 'package:flutter/services.dart' as rootBundle;
import 'package:get/get.dart';

class JsonController extends GetxController {
  Future<List<dynamic>> loadStockData() async {
    final jsonString =
        await rootBundle.rootBundle.loadString('assets/json/stocks.json');

    final Map<String, dynamic> jsonData = json.decode(jsonString);

    final List<dynamic> stocks = jsonData['stocks'];

    return stocks;
  }
}
