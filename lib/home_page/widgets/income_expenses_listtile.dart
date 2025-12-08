import 'package:finansal_kocluk_takip/data/model/income.dart';
import 'package:finansal_kocluk_takip/data/model/period_type.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/amount_calculator_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_events/amount_calculator_event.dart';
import 'package:finansal_kocluk_takip/income_expense_page/view/income_expanse_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/sabitler.dart';
import '../../income_expense_page/bloc/income_expense_page_events/events.dart';

class IncomeExpensesListtile extends StatelessWidget {

  final Map<String,List<dynamic>> model;

  const IncomeExpensesListtile({super.key,required this.model});

  @override
  Widget build(BuildContext context) {
    return
        Column(children: theCardofValues(model,context));
  }
}

List<Widget> theCardofValues(Map<String,List<dynamic>> theMap,BuildContext context)
{
  List<Widget> listWidget=[];

  for(var entry in theMap.entries)
    {

      listWidget.add(Card(

        elevation: 8,

        child:ExpansionTile(
            title: Row(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [


                (entry.value.first is IncomeModel)?findTheIcon(entry.key,Sabitler.incomeSelections,Sabitler.incomeColor):findTheIcon(entry.key,Sabitler.expensesSelections,Sabitler.expensesColor),
                const SizedBox(width:10),
                Text(entry.key,style:GoogleFonts.poppins(fontSize:20,fontWeight:FontWeight.w500,color:(entry.value.first is IncomeModel)?Sabitler.incomeColor:Sabitler.expensesColor)),

                const SizedBox(width:10),

                Container(
                    height: 30,
                    width:30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color:(entry.value.first is IncomeModel) ? Colors.green.shade500:Colors.red.shade400
                    ),
                    child: Center(child:Text(entry.value.length.toString(),style:GoogleFonts.poppins(fontSize:20,fontWeight:FontWeight.bold,color:Colors.white)))),
                const SizedBox(width:10),
                Text(entry.value.fold(0.0,(first,value)=>first+value.amount).toString(),style:GoogleFonts.poppins(fontSize:20,color:Colors.black)),
              ],
            ),
          children: explationOfValues(entry.value,context),
        )
      ));

    }

  return listWidget;
}


Icon findTheIcon(String value,Map<IconData,String> theMap,Color color)
{
  for(var entry in theMap.entries)
    {
      if(entry.value==value)
        {
          return Icon(entry.key,size:30,color:color);
        }
    }

  return Icon(Icons.block);

}


List<Widget> explationOfValues(List<dynamic> theMapValue,BuildContext context) {

  List<Widget> tiles = [];

  for (var entry in theMapValue) {
    tiles.add(
        InkWell(

          onTap: ()
          {
            context.read<IncomeExpenseBloc>().add(SelectDate(entry.date));

            Navigator.push(context,MaterialPageRoute(builder: (context)=>IncomeExpansePage(isitIncomepage:(entry is IncomeModel)?true:false, type:PeriodType.daily,buttonName:"Kategoriyi Değiştir")));

          },


          child: ListTile(
            leading: Container(height: 10, width: 10, decoration:BoxDecoration(color: (entry is IncomeModel) ? Colors.green.shade300 : Colors.red.shade400,borderRadius: BorderRadius.circular(100))),
            title: (entry.note==null)? Text("${entry.amount} ₺", style: GoogleFonts.poppins(color:(entry is IncomeModel)?Sabitler.incomeColor:Sabitler.expensesColor, fontSize: 20,fontWeight: FontWeight.w400),):

                Row(

                  children: [

                    Text("${entry.amount} ₺", style: GoogleFonts.poppins(color:(entry is IncomeModel)?Sabitler.incomeColor:Sabitler.expensesColor, fontSize: 20,fontWeight: FontWeight.w400),),

                    const SizedBox(width:10),

                    Expanded(child: Text(entry.text))

                  ],


                ),

            trailing: Text(entry.date.split(",")[1], style: GoogleFonts.poppins(color: Colors.grey.shade600, fontSize: 20,),),
          ),
        ),
    );
  }

  return tiles;
}

