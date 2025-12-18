import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_bloc/amount_calculator_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_bloc/db_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/sabitler.dart';
import '../../date/date_bloc/date_bloc.dart';
import '../bloc/income_expense_page_events/amount_calculator_event.dart';
import '../bloc/income_expense_page_events/db_events.dart';
class ContainerOfCategory extends StatelessWidget {
  final IconData icondata;
  final String value;
  final Color primaryColor;
  final bool isitIncomepage;
  int ? modelId;
  ContainerOfCategory({super.key,required this.icondata,required this.value,required this.primaryColor,required this.isitIncomepage,this.modelId});
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: ()
          {
            if(modelId==null)
              {
                final status=context.read<AmountCalculatorBloc>().state;
                final map=Sabitler.convertToMap(date:context.read<DateBloc>().state.dbdate, amount:double.parse(status.tempValue!), category:value,note:status.note);
                context.read<DbBloc>().add(SavetoDb(isitIncome:isitIncomepage,theMap:map));
                context.read<AmountCalculatorBloc>().add(ResetTheCalculator());
              }
            else
              {
                final status=context.read<AmountCalculatorBloc>().state;
                print("not degeri: ${status.note}");
                final map=Sabitler.convertToMap(date:context.read<DateBloc>().state.dbdate, amount:double.parse(status.tempValue!), category:value,note:status.note);

                map["id"]=modelId;
                context.read<DbBloc>().add(UpdatetoDb(theMapForUpdated: map, isitIncome:isitIncomepage, modelId:modelId!));
                context.read<AmountCalculatorBloc>().add(ResetTheCalculator());
              }
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
                Expanded(child: CircleAvatar(radius: 30,backgroundColor:primaryColor,foregroundColor: Colors.white,child: Icon(icondata,size:30,color:Colors.white),)),
                Text(value, style:GoogleFonts.poppins(fontSize:18,color:Colors.black,fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
      );
  }
}