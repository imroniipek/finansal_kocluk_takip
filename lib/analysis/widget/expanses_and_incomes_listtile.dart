import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/sabitler.dart';
import '../../data/model/income.dart';
import '../../income_expense_page/bloc/amount_calculator/amount_calculator_bloc.dart';
import '../../income_expense_page/bloc/amount_calculator/amount_calculator_event.dart';
import '../../income_expense_page/view/income_expanse_page.dart';

class ExpansesAndIncomeListTile extends StatelessWidget {
  final Map<String, List<dynamic>> model;
  const ExpansesAndIncomeListTile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: theCardofValues(model, context),
    );
  }

  List<Widget> theCardofValues(Map<String, List<dynamic>> theMap, BuildContext context) {
    List<Widget> widgets = [];

    for (var entry in theMap.entries) {
      final values = entry.value;
      if (values.isEmpty) continue;

      final firstItem = values.first;
      final bool isIncome = firstItem is IncomeModel;


      final Color accentColor = isIncome ? const Color(0xFF00E676) : const Color(0xFFFF5252);
      final double totalAmount = values.fold(0.0, (p, element) => p + element.amount);

      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white60, width: 2),),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    leading: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [accentColor.withOpacity(0.2), accentColor.withOpacity(0.05)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: findTheIcon(entry.key, isIncome ? Sabitler.incomeSelections : Sabitler.expensesSelections, accentColor),
                    ),
                    title: Text(entry.key, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),),
                    subtitle: Text("${values.length} İşlem", style: GoogleFonts.poppins(fontSize: 12, color: Colors.white, letterSpacing: 0.5),),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${totalAmount.toStringAsFixed(2)} ₺",
                          style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.bold, color: accentColor,),
                        ),
                        const Icon(Icons.expand_more_rounded, color: Colors.grey, size: 20),
                      ],
                    ),
                    children: explationOfValues(values, context, accentColor),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return widgets;
  }

  Icon findTheIcon(String value, Map<IconData, String> map, Color color) {
    for (var entry in map.entries) {
      if (entry.value == value) {
        return Icon(entry.key, size: 24, color: color);
      }
    }
    return Icon(Icons.category_rounded, size: 24, color: color);
  }

  List<Widget> explationOfValues(List<dynamic> values, BuildContext context, Color accentColor) {
    return values.map((entry) {
      final bool isIncome = entry is IncomeModel;

      return InkWell(
        onTap: () {
          context.read<AmountCalculatorBloc>().add(UpdateTheModel(model: entry));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => IncomeExpansePage(
                isitIncomepage: isIncome,
                buttonName: "Kategoriyi Değiştir",
                modelId: entry.id,
                textValue: entry.note,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(color: accentColor, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: accentColor.withOpacity(0.5), blurRadius: 4)],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (entry.note != null && entry.note!.isNotEmpty) ? entry.note! : "Açıklama yok",
                      style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.9), fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      entry.date,
                      style: GoogleFonts.poppins(color: Colors.white30, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Text(
                "${entry.amount} ₺",
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 10),
              Icon(Icons.arrow_forward_ios_rounded, size: 12, color: Colors.white.withOpacity(0.1)),
            ],
          ),
        ),
      );
    }).toList();
  }
}