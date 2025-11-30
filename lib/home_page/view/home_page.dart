import 'package:finansal_kocluk_takip/data/model/income.dart';
import 'package:finansal_kocluk_takip/home_page/bloc/home_page_bloc.dart';
import 'package:finansal_kocluk_takip/home_page/bloc/home_page_status/home_page_status.dart';
import 'package:finansal_kocluk_takip/home_page/widgets/current_balance.dart';
import 'package:finansal_kocluk_takip/home_page/widgets/expenses_donut_chart.dart';
import 'package:finansal_kocluk_takip/home_page/widgets/income_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/sabitler.dart';
import '../../data/model/period_type.dart';
import '../../income_expense_page/view/income_expanse_page.dart';
import '../bloc/home_page_event/home_page_event.dart';
import '../widgets/expenses_and_income_buttons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isOpen = false;





  @override
  Widget build(BuildContext context) {

    final expensesList=widgetList(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Sabitler.generalPrimaryColor,
        title: Text("Cüzdanım360", style: GoogleFonts.pacifico(fontSize: 25, color: Colors.white),),
        centerTitle: true,
      ),
      body:
         Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),


              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(context: context, firstDate: DateTime(2024), lastDate: DateTime(2030), initialDate: DateTime.now(),);

                      if (selectedDate != null)
                      {
                        context.read<HomePageBloc>().add(ChangeTheDate(selectedDate));
                      }
                    },
                    icon: Icon(Icons.calendar_month, size: 30, color: Sabitler.generalPrimaryColor,),
                  ),


                  BlocBuilder<HomePageBloc,HomePageState>(
                      builder: (context,state)
                      {
                        return Text(state.date, style: GoogleFonts.poppins(fontSize: 20, color: Colors.black,),);
                      }
                  )


                ],
              ),

              const SizedBox(height: 20),


              BlocBuilder<HomePageBloc,HomePageState>(


                  buildWhen:(previous,current)
                  {
                    return previous.expenses!=current.expenses;
                  },
                  builder:(context,state)
                  {
                    return Container(


                      height:500,


                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: expensesList.sublist(0, 4),
                          ),

                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                expensesList[5],

                                ExpensesDonutChart(expenses:context.read<HomePageBloc>().state.expenses),

                                expensesList[6],

                              ],



                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: expensesList.sublist(0, 4),
                          ),

                        ],
                      ),
                    );




                  }
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: ()
                    {
                      setState(()
                      {
                        isOpen = !isOpen;
                        context.read<HomePageBloc>().add(ShowIncomeList(isOpen),);
                      });


                    },
                    icon: Icon(Icons.menu, size: 45, color: Sabitler.generalPrimaryColor,),
                  ),


                  const CurrentBalance(),

                  Icon(Icons.menu, size: 45, color: Sabitler.generalPrimaryColor,),
                ],
              ),

              const SizedBox(height: 10),

               BlocBuilder<HomePageBloc,HomePageState>(

                 buildWhen:(previous,current)
                   {
                     return previous.date != current.date || previous.incomes != current.incomes;
                   },


                 builder:(context,state)
                   {
                     return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    height: isOpen ? (context.read<HomePageBloc>().state.incomes.length*55 ) : 0.0,
                    child: isOpen ? SingleChildScrollView(
                    child: IncomeListtile(model: theMapSelectedByCategory(context.read<HomePageBloc>().state.incomes) )): Container(),
                      );
                   }
               ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ExpensesandIncomeButtons(icon: Icon(Icons.add, size: 40,color:Sabitler.incomeColor), color: Sabitler.incomeColor, isitIncome: true,),
                    ExpensesandIncomeButtons(icon: Icon(Icons.remove, size: 40,color:Sabitler.expensesColor), color: Sabitler.expensesColor, isitIncome: false,),
                  ],
                ),
              ),
            ],
          )

         );

  }


  Map<String, List<IncomeModel>> theMapSelectedByCategory(List<IncomeModel> list) {
    Map<String,List<IncomeModel>> map={};
    for(var value in list)
    {
      if(map[value.category]==null)
      {
        map[value.category]=(map[value.category]??[])..add(value);
      }
      else
      {
        map[value.category]!.add(value);
      }
    }
    return map;
  }






  List<Widget>widgetList(BuildContext context)
  {

    return Sabitler.expensesSelections.entries.map((entry)
    {
      return IconButton(

        icon:Icon(entry.key,size:45,color:Colors.black87),

        onPressed: ()
        {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>IncomeExpansePage(isitIncomepage: false,type:PeriodType.daily,expensesType: entry.value,)));
        },




      );


    }




    ).toList();



  }




}
