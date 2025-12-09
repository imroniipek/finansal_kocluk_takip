import 'package:finansal_kocluk_takip/date/date_bloc/date_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_bloc/amount_calculator_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_bloc/db_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_states/amount_calculator_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/sabitler.dart';
import '../bloc/income_expense_page_events/amount_calculator_event.dart';
import '../bloc/income_expense_page_events/db_events.dart';

class CategorySelectorButton extends StatelessWidget {

  final AmountCalculatorStatus state;

  final Color primaryColor;

  final bool isitIncome;

  String ? buttonName;

  final dynamic modelId;

 CategorySelectorButton({super.key,required this.state,required this.primaryColor,required this.isitIncome,this.buttonName,this.modelId});

  @override
  Widget build(BuildContext context) {
    return

      (state.isButtonSection==false)?Container():

      InkWell(

        onTap: ()
        {
          if(buttonName!=null&&modelId==null)
            {
              Map<String,dynamic> theMap= Sabitler.convertToMap(date:context.read<DateBloc>().state.dbdate,amount:double.parse(state.tempValue!),i:1,category: buttonName!);
              context.read<DbBloc>().add(SavetoDb(theMap: theMap, isitIncome: isitIncome));
            }
          else
            {
            context.read<AmountCalculatorBloc>().add(ClickTheButton());
            }
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
            child:Container(
              color:primaryColor,
                child: Center(
                    child: returnTheText(buttonName, modelId)))
        ),
      );
    }
}

Text returnTheText(String ? buttonName,dynamic modelId)
{
  if(buttonName==null)
    {
      return Text("Kategori Seçiniz",style:GoogleFonts.poppins(fontSize:30,color:Colors.white,fontWeight: FontWeight.w400));
    }
  else
    {
      return (modelId!=null)?Text("Kategoriyi Değiştir",style:GoogleFonts.poppins(fontSize:30,color:Colors.white,fontWeight: FontWeight.w400)):

          Text("$buttonName Ekle",style:GoogleFonts.poppins(fontSize:30,color:Colors.white,fontWeight: FontWeight.w400));
    }
}


