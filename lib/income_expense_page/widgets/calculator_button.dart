import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_bloc/amount_calculator_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_bloc/income_expense_page_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_events/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/income_expense_page_events/amount_calculator_event.dart';

class CalculatorButton extends StatelessWidget {

  final String value;

  final Color buttonColor;

  const CalculatorButton({super.key,required this.value,required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return

        InkWell(

            onTap: () {
            if (value == "=") {context.read<AmountCalculatorBloc>().add(CalculateResult());}
            else if (isOperator(value)) {context.read<AmountCalculatorBloc>().add(AddOperator(value));}
           else {context.read<AmountCalculatorBloc>().add(AddDigit(value));}
           },
    child: Container(
              margin: EdgeInsets.all(10),
              width: (MediaQuery.of(context).size.width)/5,
              height: 80,
              decoration: BoxDecoration(color:Colors.white, borderRadius: BorderRadius.circular(5), border: Border.all(color:buttonColor,width: 3),),
            child: Center(child: Text(value,style:GoogleFonts.poppins(fontSize:40,color:Colors.black))),
          ),
        );
  }
  bool isOperator(String v) => "+-*/=".contains(v);
}



