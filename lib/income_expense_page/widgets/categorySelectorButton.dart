import 'package:finansal_kocluk_takip/income_expense_page/bloc/amount_calculator_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_events/events.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_states/amount_calculator_status.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_states/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/income_expense_page_events/amount_calculator_event.dart';

class categorySelectorButton extends StatelessWidget {


  final AmountCalculatorStatus state;

  final Color primaryColor;

  String ? buttonName;

 categorySelectorButton({super.key,required this.state,required this.primaryColor,this.buttonName});

  @override
  Widget build(BuildContext context) {
    return

      (state.isButtonSection==false)?Container():

      InkWell(

        onTap: ()
        {
          context.read<AmountCalculatorBloc>().add(clickTheButton(buttonName: buttonName));

        },

        child: Container(

            margin: EdgeInsets.all(10),

            width: MediaQuery.of(context).size.width,

            height: 70,
            decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(5),
              border:Border.all(color:primaryColor,width:3),

            ),
            child: Center(child: (buttonName==null)?Text("Kategori Seçiniz",style:GoogleFonts.poppins(fontSize:30,color:Colors.grey.shade900,fontWeight: FontWeight.w400)):
            Text("${buttonName!} Ekle",style:GoogleFonts.poppins(fontSize:30,color:Colors.grey.shade900,fontWeight: FontWeight.w400)))
        ),
      );
    }

  }

