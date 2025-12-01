import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../core/sabitler.dart';
import '../../data/model/expense.dart';

class ExpensesDonutChart extends StatefulWidget {

  final List<ExpenseModel> expenses;

  const ExpensesDonutChart({super.key, required this.expenses});

  @override
  State<ExpensesDonutChart> createState() => _ExpensesDonutChartState();
}

class _ExpensesDonutChartState extends State<ExpensesDonutChart> {
  List<Color> chartColors = Sabitler.colorsForExpensesButtons;

  @override
  Widget build(BuildContext context) {
    if (widget.expenses.isEmpty) {
      return SizedBox(
        height: 250,
        child: Center(child: Text("Henüz gider yok")),
      );
    }


    final total =  Sabitler.calculateAmountPriceByCategory(widget.expenses).entries.fold(0.0, (a, b) => a + b.value);

    int colorIndex = -1;

    return SizedBox(
      height: 300,
      child: PieChart(
        PieChartData(
            sectionsSpace: 0,
            centerSpaceRadius: 75,
            startDegreeOffset: -90,
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: Colors.red,
                width: 3,
              ),
            ),


            sections:
            Sabitler.calculateAmountPriceByCategory(widget.expenses).entries.map((entry)
            {
              colorIndex++;
              return PieChartSectionData(

                  value:(entry.value/total)*100,

                  color:Sabitler.colorsForExpensesButtons[colorIndex%Sabitler.colorsForExpensesButtons.length],

                  title:entry.key,

                  radius:60


              );

            }).toList()
        ),
      ),
    );
  }
}