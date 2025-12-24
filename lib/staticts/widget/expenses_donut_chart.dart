import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/sabitler.dart';
import '../../data/model/expense.dart';
import '../../data/model/income.dart';

class ExpensesDonutChart extends StatelessWidget {
  final List<ExpenseModel> expenses;
  final List<IncomeModel> incomes;

  const ExpensesDonutChart({super.key, required this.expenses, required this.incomes,});

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return SizedBox(
        height: 260,
        child: Center(
          child: Text(
            "Henüz herhangi bir veri yok",
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    final map = Sabitler.calculateAmountPriceByCategory(expenses);
    final total = map.values.fold(0.0, (a, b) => a + b);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(24),
      ),
      child:
          SizedBox(
            height: 260,
            child: PieChart(
              PieChartData(
                startDegreeOffset: -90,
                sectionsSpace: 2,
                centerSpaceRadius: 72,
                sections: map.entries.map((entry) {
                  final percent = (entry.value / total) * 100;
                  return PieChartSectionData(
                    value: entry.value,
                    radius: 68,
                    color: Sabitler.expenseColorsMap[entry.key],
                    title: "${percent.toStringAsFixed(0)}%",
                    titleStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
    );
  }

  double _totalExpense() =>
      expenses.fold(0.0, (sum, e) => sum + e.amount);

  double _totalIncome() =>
      incomes.fold(0.0, (sum, i) => sum + i.amount);
}
