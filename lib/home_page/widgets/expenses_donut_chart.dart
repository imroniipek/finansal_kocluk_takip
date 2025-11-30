import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../data/model/expense.dart';

class ExpensesDonutChart extends StatelessWidget {
  final List<ExpenseModel> expenses;

  ExpensesDonutChart({super.key, required this.expenses});

  static const List<Color> chartColors = [
    Colors.red,
    Colors.green,
    Colors.deepPurpleAccent,
    Colors.deepOrangeAccent,
    Colors.lightBlueAccent,
    Colors.amber,
    Colors.pinkAccent,
    Colors.teal,
  ];

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return SizedBox(
        height: 250,
        child: Center(child: Text("Henüz gider yok")),
      );
    }

    final grouped = groupExpensesByCategory(expenses);
    final total = grouped.values.fold(0.0, (a, b) => a + b);

    int colorIndex = 0;

    return SizedBox(
      height: 300,
      child: PieChart(
        PieChartData(
          sectionsSpace: 0,
          centerSpaceRadius: 60,
          startDegreeOffset: -90,
          borderData: FlBorderData(show: false),
          sections: grouped.entries.map((entry) {
            final amount = entry.value;
            final percent = (amount / total) * 100;

            final color = chartColors[colorIndex % chartColors.length];
            colorIndex++;

            return PieChartSectionData(
              color: color,
              radius: 60,
              value: amount,
              title: entry.key,
              titleStyle: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold,),


            );
          }).toList(),
        ),
      ),
    );
  }
}

Map<String, double> groupExpensesByCategory(List<ExpenseModel> expenses) {
  final map = <String, double>{};

  for (var expense in expenses) {
    map[expense.category] = (map[expense.category] ?? 0) + expense.amount;
  }

  return map;
}



