import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/income_expense_page_bloc.dart';
import '../bloc/income_expense_page_events/events.dart';
import '../bloc/income_expense_page_states/status.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(

      mainAxisAlignment: MainAxisAlignment.center,

      children: [

        IconButton(
            onPressed: () async {
              final date =await showDatePicker(context: context, firstDate: DateTime(2024), lastDate: DateTime(2030),initialDate: DateTime.now());
              context.read<IncomeExpenseBloc>().add(SelectDate(date!));
            },icon: Icon(Icons.calendar_month,size:27,color:Colors.black)
        ),



        BlocBuilder<IncomeExpenseBloc, IncomeExpenseStatus>(
          builder: (context, state) {
            return Text(state.date,style:GoogleFonts.poppins(fontSize:23,color:Colors.black));
          },
        ),



      ],

    );






  }
}
