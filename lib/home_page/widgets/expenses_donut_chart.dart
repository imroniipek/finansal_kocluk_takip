import 'package:finansal_kocluk_takip/data/repositories/expenses_repository.dart';
import 'package:finansal_kocluk_takip/data/repositories/income_repository.dart';
import 'package:finansal_kocluk_takip/locator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/sabitler.dart';
import '../../data/model/expense.dart';


class ExpensesDonutChart extends StatefulWidget {

  final List<ExpenseModel> expenses;
  final String date;
  const ExpensesDonutChart({super.key, required this.expenses,required this.date});

  @override
  State<ExpensesDonutChart> createState() => _ExpensesDonutChartState();
}

class _ExpensesDonutChartState extends State<ExpensesDonutChart> {

  double ? totalIncomeAmount;

  double ? totalExpensesAmount;

  @override
  initState() {
    loadAmounts();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    if (widget.expenses.isEmpty) {
      return SizedBox(
        height: 250,
        child: Center(child: Text("Henüz gider yok")),
      );
    }

    final map = Sabitler.calculateAmountPriceByCategory(widget.expenses);
    final total = map.values.fold(0.0, (a, b) => a + b);

    return Stack(
        children: [

          SizedBox(
            height: 250,
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 60,
                startDegreeOffset: -90,

                sections: map.entries.map((entry) {
                  final percent = (entry.value / total) * 100;

                  return PieChartSectionData(
                    value: entry.value,

                    color: Sabitler.expenseColorsMap[entry.key],

                    title: "${percent.toStringAsFixed(0)}%",
                    titleStyle: const TextStyle(fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,),
                    radius: 60,
                  );
                }).toList(),
              ),
            ),
          ),

          Positioned(
            top:100,
            left:60,
            child: Column(

              children: [

              Text("+ ${totalIncomeAmount}₺",style:GoogleFonts.poppins(color:Colors.green,fontSize: 18,fontWeight: FontWeight.w500)),

              const SizedBox(height: 10),

              Text("- ${totalExpensesAmount}₺",style:GoogleFonts.poppins(color:Colors.red.shade900,fontSize: 18,fontWeight: FontWeight.w500)),
            ],),
          ),
        ]
    );
  }

  Future<void> loadAmounts() async {
    final income = await locator<IncomeRepository>().calculateCurrentAmount(
        widget.date);

    final expenses = await locator<ExpensesRepository>()
        .calculateTheAmountofExpenses(widget.date);

    setState(() {
      totalIncomeAmount = income;
      totalExpensesAmount = expenses;
    });
  }
}
