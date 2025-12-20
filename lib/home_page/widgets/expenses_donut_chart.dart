import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/sabitler.dart';
import '../../data/model/expense.dart';
import '../../data/model/income.dart';
class ExpensesDonutChart extends StatefulWidget {
  final List<ExpenseModel> expenses;
  final List<IncomeModel>incomes;
  const ExpensesDonutChart({super.key, required this.expenses,required this.incomes});

  @override
  State<ExpensesDonutChart> createState() => _ExpensesDonutChartState();
}

class _ExpensesDonutChartState extends State<ExpensesDonutChart> {
  @override
  Widget build(BuildContext context) {
    if (widget.expenses.isEmpty) {
      return SizedBox(
        height: 250,
        child: Center(child: Text("Henüz herhangi bir veri yok",style:GoogleFonts.poppins(color:Colors.white,fontSize: 18,fontWeight: FontWeight.w400))
      ));
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
                centerSpaceRadius: 63,
                startDegreeOffset: -90,
                sections: map.entries.map((entry) {
                  final percent = (entry.value / total) * 100;
                  return PieChartSectionData(
                    value: entry.value,
                    color: Sabitler.expenseColorsMap[entry.key],
                    title: "${percent.toStringAsFixed(0)}%",
                    titleStyle: const TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold,),
                    radius: 60,
                  );
                }).toList(),
              ),
            ),
          ),

          Positioned(
            top:100,
            left:50,
            child: Column(
              children: [
              Text("+ ${calculateTotalIncomeAmount().toStringAsFixed(2)}₺",style:GoogleFonts.poppins(color:Colors.lightGreenAccent,fontSize: 15,fontWeight: FontWeight.w500)),
              const SizedBox(height: 10),
              Text("- ${calculateTotalExpensesAmount().toStringAsFixed(2)}₺",style:GoogleFonts.poppins(color:Colors.red.shade400,fontSize: 15,fontWeight: FontWeight.w500)),
            ],),
          ),
        ]
    );
  }
  double calculateTotalExpensesAmount() =>widget.expenses.fold(0.0,(first,value)=>first+value.amount);
  double calculateTotalIncomeAmount()=>widget.incomes.fold(0.0,(first,value)=>first+value.amount);

}
