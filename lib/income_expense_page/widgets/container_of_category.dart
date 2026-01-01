import 'package:finansal_kocluk_takip/date/date_bloc/date_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/amount_calculator/amount_calculator_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/db/db_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/db/db_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/sabitler.dart';
class ContainerOfCategory extends StatelessWidget {
  final IconData icondata;
  final String value;
  final Color primaryColor;
  final bool isitIncomepage;
  final int? modelId;

  const ContainerOfCategory({super.key, required this.icondata, required this.value, required this.primaryColor, required this.isitIncomepage, this.modelId,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: ()
      {
        final state=context.read<AmountCalculatorBloc>().state;
        final amount = double.tryParse(state.tempValue ?? "0") ?? 0.0;

        if (amount <= 0)
        {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Lütfen geçerli bir tutar giriniz")),
          );
          return;
        }

        final map = Sabitler.convertToMap(date: context.read<DateBloc>().state.dbdate, amount: amount, category: value, note: state.note,);
        if (modelId != null)
        {
          context.read<DbBloc>().add(UpdatetoDb(theMapForUpdated: map, isitIncome: isitIncomepage, modelId: modelId!,),);
        } else
        {
          context.read<DbBloc>().add(SavetoDb(theMap: map, isitIncome: isitIncomepage),);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: primaryColor.withOpacity(0.2),
              child: Icon(icondata, color: primaryColor),
            ),
            const SizedBox(height: 10),
            Text(value, style: GoogleFonts.poppins(fontSize: 14, color: Colors.white,),),
          ],
        ),
      ),
    );
  }
}
