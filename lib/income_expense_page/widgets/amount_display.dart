import 'package:finansal_kocluk_takip/income_expense_page/bloc/amount_calculator_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_states/amount_calculator_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/income_expense_page_bloc.dart';
import '../bloc/income_expense_page_events/amount_calculator_event.dart';
import '../bloc/income_expense_page_events/events.dart';
import '../bloc/income_expense_page_states/status.dart';

class AmountDisplay extends StatelessWidget {

  final Color primaryColor;

  const AmountDisplay({super.key,required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return
      Container(

        margin: EdgeInsets.all(10),

        width: MediaQuery.of(context).size.width,

        height: 70,


        decoration: BoxDecoration(

            color:primaryColor,

            borderRadius: BorderRadius.circular(5),

            boxShadow: [
              BoxShadow(color:Colors.grey,blurRadius: 10)
            ]



        ),

        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [

            SizedBox(width:50),


            BlocBuilder<AmountCalculatorBloc,AmountCalculatorStatus>
              (
                builder:(context,state)
                {


                  return (state.tempValue!.contains("."))?Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.tempValue!.split(".")[0],style: GoogleFonts.poppins(fontSize: 40, color: Colors.white),),

                      Text(".", style: GoogleFonts.poppins(fontSize: 30, color: Colors.white),),

                      Text(state.tempValue!.split(".")[1], style: GoogleFonts.poppins(fontSize: 30, color: Colors.white)),
                    ],
                  ):Text(state.tempValue!,style: GoogleFonts.poppins(fontSize: 35, color: Colors.white),);



                }
            ),

            IconButton(onPressed: (){
              context.read<AmountCalculatorBloc>().add(ClearTheDigit());
            }, icon: Icon(Icons.backspace_outlined,size:40,color:Colors.white)),

          ],
        ),






      );




  }
}
