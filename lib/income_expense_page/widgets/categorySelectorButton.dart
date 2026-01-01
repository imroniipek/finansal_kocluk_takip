import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/sabitler.dart';
import '../../date/date_bloc/date_bloc.dart';
import '../bloc/amount_calculator/amount_calculator_bloc.dart';
import '../bloc/db/db_bloc.dart';
import '../bloc/amount_calculator/amount_calculator_event.dart';
import '../bloc/db/db_events.dart';
import '../bloc/amount_calculator/amount_calculator_status.dart';

class CategorySelectorButton extends StatelessWidget {
  final AmountCalculatorStatus state;
  final Color primaryColor;
  final bool isitIncome;
  final String? buttonName;
  final dynamic modelId;

  const CategorySelectorButton({
    super.key,
    required this.state,
    required this.primaryColor,
    required this.isitIncome,
    this.buttonName,
    this.modelId,
  });

  @override
  Widget build(BuildContext context) {
    if (!state.isButtonSection) return const SizedBox.shrink();

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        if (buttonName != null && modelId == null) {
          final map = Sabitler.convertToMap(
            date: context.read<DateBloc>().state.dbdate,
            amount: double.parse(state.tempValue!),
            category: buttonName!,
            note: state.note,
          );
          context.read<DbBloc>().add(
            SavetoDb(theMap: map, isitIncome: isitIncome),
          );
        } else {
          context.read<AmountCalculatorBloc>().add(ClickTheButton());
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, primaryColor.withOpacity(.85)],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(child: Text(buttonName == null ? "Kategori Seç" : modelId != null ? "Kategoriyi Değiştir" : "$buttonName Ekle", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white,),),),
      ),
    );
  }
}