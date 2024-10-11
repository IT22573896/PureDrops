import 'package:Puredrops/bar_graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final List yearlysummary;

  const MyBarGraph({super.key, required this.yearlysummary});

  @override
  Widget build(BuildContext context) {
    // Initialize data
    BarData myBarData = BarData(
      firstYears: yearlysummary[0],
      secondYears: yearlysummary[1],
      thirdYears: yearlysummary[2],
      fourthYears: yearlysummary[3],
      fiveYears: yearlysummary[4],
      sixYears: yearlysummary[5],
      sevenYears: yearlysummary[6],
    );

    myBarData.initializeBarData();

    // Define the X-axis labels (years)
    final Map<int, String> xAxisLabels = {
      1: '2010',
      2: '2012',
      3: '2014',
      4: '2016',
      5: '2018',
      6: '2020',
      7: '2022',
    };

    return BarChart(
      BarChartData(
        maxY: 100,
        minY: 0,
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    width: 15, // Optional: set the width of the bars
                    color: Colors.blue, // Optional: set color for the bars
                  ),
                ],
              ),
            )
            .toList(),
        titlesData: FlTitlesData(
          show: true,
          // Bottom Titles for the X-axis
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                // Get the year from the map based on the x value
                final year = xAxisLabels[value.toInt()] ?? '';
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    year,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
          ),
          // Left Titles for the Y-axis
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 10, // Interval for the Y-axis (0, 10, 20, 30, etc.)
              reservedSize: 40,
              getTitlesWidget: (double value, TitleMeta meta) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
          ),
          // Hide top titles (to remove the numbers at the top)
          topTitles: const AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          // Hide right titles (optional, if you don't want them on the right)
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
        ),
        gridData: FlGridData(
          show: true,
          horizontalInterval:
              10, // Horizontal lines for every 10 units on Y-axis
          drawVerticalLine: false, // No vertical grid lines
          getDrawingHorizontalLine: (value) {
            return const FlLine(
              color: Colors.grey, // Color of the horizontal lines
              strokeWidth: 1.0, // Width of the horizontal lines
              dashArray: [5, 5], // Dotted lines (optional)
            );
          },
        ),
      ),
    );
  }
}
