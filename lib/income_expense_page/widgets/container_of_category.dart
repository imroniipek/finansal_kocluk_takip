import 'package:finansal_kocluk_takip/data/model/period_type.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/amount_calculator_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/db_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_states/amount_calculator_status.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_states/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/sabitler.dart';
import '../bloc/income_expense_page_bloc.dart';
import '../bloc/income_expense_page_events/amount_calculator_event.dart';
import '../bloc/income_expense_page_events/db_events.dart';
import '../bloc/income_expense_page_events/events.dart';

class ContainerOfCategory extends StatelessWidget {

  final IconData icondata;

  final String value;

  final Color primaryColor;

  final bool isitIncomepage;

  final PeriodType type;

  final IncomeExpenseStatus state;


  const ContainerOfCategory({super.key,required this.icondata,required this.value,required this.primaryColor,required this.isitIncomepage,required this.type,required this.state});

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(

          onTap: ()
          {
            final status=context.read<AmountCalculatorBloc>().state;

            int i=Sabitler.conevertPeriodTypetoInetegerValue(type);

            print("--------------DB kaydedilen Değerler-------------------");

            print("tarih: ${state.date}");

            print("amount: ${status.tempValue}");

            print("period_type: ${i}");

            print("category ${value}");

            print("---------------------------------");

            final map=convertToMap(state.date, double.parse(status.tempValue!), i, value);

            context.read<DbBloc>().add(SavetoDb(isitIncome:isitIncomepage,theMap:map));

            context.read<AmountCalculatorBloc>().add(ResetTheCalculator());



          },



          child: Container(
            width: (MediaQuery.of(context).size.width/5),

            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color:primaryColor,width:3,),
              borderRadius: BorderRadius.circular(10),

            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: CircleAvatar(child: Icon(icondata,size:30,color:Colors.white),radius: 30,backgroundColor:primaryColor,foregroundColor: Colors.white,)),
                Text(value, style:GoogleFonts.poppins(fontSize:18,color:Colors.black,fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
      );
  }
}

convertToMap(String date,double amount,int i,String value)=>{"date":date, "amount":amount, "period_type":i, "category":value};
