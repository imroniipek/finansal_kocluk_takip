import 'package:finansal_kocluk_takip/data/model/expense.dart';
import 'package:finansal_kocluk_takip/data/model/income.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../../home_page/bloc/home_page_bloc/home_page_bloc.dart' show HomePageBloc;
import '../../home_page/bloc/home_page_status/home_page_status.dart';

class TotalAmountCard extends StatelessWidget {
  final List<ExpenseModel> expenses;
  final List<IncomeModel> incomes;

  const TotalAmountCard({super.key, required this.incomes, required this.expenses});

  @override
  Widget build(BuildContext context) {
    final double netBudget = _totalIncome() - _totalExpense();


    const Color incomeColor = Color(0xFF00E676);
    const Color expenseColor = Color(0xFFFF5252);
    final Color netColor = netBudget >= 0 ? incomeColor : expenseColor;

    return BlocBuilder<HomePageBloc, HomePageState>(
      buildWhen: (p, c) => p.expenses != c.expenses || p.incomes != c.incomes,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Bütçe Özeti", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white70),),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
                  ),
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Net Bakiye", style: GoogleFonts.poppins(color: Colors.white54, fontSize: 13),),
                              const SizedBox(height: 4),
                              Text("${netBudget.toStringAsFixed(2)} ₺", style: GoogleFonts.poppins(  color: netColor, fontSize: 28, fontWeight: FontWeight.bold, ),
                              ),
                            ],
                          ),

                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: netColor.withOpacity(0.1),  shape: BoxShape.circle,  ),
                            child: Icon(Icons.account_balance_wallet_rounded, color: netColor, size: 28),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),


                      Divider(color: Colors.white, thickness: 2),
                      const SizedBox(height: 20),


                      Row(
                        children: [
                          Expanded(child: _miniStat("Gelir", _totalIncome(), incomeColor, Icons.arrow_upward_rounded)),
                          Container(width: 2, height: 40, color: Colors.white),
                          Expanded(child: _miniStat("Gider", _totalExpense(), expenseColor, Icons.arrow_downward_rounded)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            Text("İşlem Geçmişi", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white70,),),
          ],
        );
      },
    );
  }

  Widget _miniStat(String title, double value, Color color, IconData icon) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 4),
            Text(title, style: GoogleFonts.poppins(color: Colors.white38, fontSize: 20)),
          ],
        ),
        const SizedBox(height: 6),
        Text("${value.toStringAsFixed(2)} ₺",style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600,),
        ),
      ],
    );
  }

  double _totalExpense() => expenses.fold(0.0, (sum, e) => sum + e.amount);
  double _totalIncome() => incomes.fold(0.0, (sum, i) => sum + i.amount);
}