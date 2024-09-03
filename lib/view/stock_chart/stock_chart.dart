import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StockChart extends StatelessWidget {
  final List<dynamic> priceHistory;
  final String interval;

  const StockChart({
    super.key,
    required this.priceHistory,
    required this.interval,
  });

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> spots = priceHistory.map((data) {
      DateTime time;
      double price = data['price'].toDouble();

      if (interval == '1D') {
        time = DateTime.parse('2024-08-01T${data['time']}:00');
        return FlSpot(time.hour.toDouble(), price);
      } else if (interval == '1W') {
        time = DateTime.parse(data['date']);
        double dayOfWeek = time.weekday.toDouble();
        return FlSpot(dayOfWeek, price);
      } else {
        time = DateTime.parse(data['date']);
        return FlSpot(time.day.toDouble(), price);
      }
    }).toList();

    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 25, top: 20),
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(
              show: true,
              drawVerticalLine: false,
              drawHorizontalLine: true,
              horizontalInterval: 50,
            ),
            titlesData: FlTitlesData(
              show: true,
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  interval: 50,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '\$${value.toStringAsFixed(0)}',
                      style:
                          const TextStyle(color: Colors.blueGrey, fontSize: 12),
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  interval: interval == '1D'
                      ? 1
                      : interval == '1W'
                          ? 1
                          : 8,
                  getTitlesWidget: (value, meta) {
                    if (interval == '1D') {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          '${value.toInt()}:00',
                          style: const TextStyle(
                              color: Colors.blueGrey, fontSize: 12),
                        ),
                      );
                    } else if (interval == '1W') {
                      List<String> weekdays = [
                        'Mon',
                        'Tue',
                        'Wed',
                        'Thu',
                        'Fri',
                        'Sat',
                        'Sun'
                      ];
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          weekdays[(value.toInt() - 1) % 7],
                          style: const TextStyle(
                              color: Colors.blueGrey, fontSize: 12),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Day ${value.toInt()}',
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 12,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              rightTitles: const AxisTitles(),
              topTitles: const AxisTitles(),
            ),
            borderData: FlBorderData(
              show: true,
              border: const Border(
                bottom: BorderSide(color: Colors.grey),
                left: BorderSide(color: Colors.grey),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: const Color(0xFF097969),
                dotData: const FlDotData(show: true),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF097969).withOpacity(0.5),
                      const Color(0xFF097969).withOpacity(0.1)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (LineBarSpot group) =>
                    Colors.white.withOpacity(0.8),
                tooltipBorder: BorderSide.none,
                fitInsideHorizontally: true,
                fitInsideVertically: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
