import 'package:finansal_kocluk_takip/data/model/income.dart';
import 'package:finansal_kocluk_takip/home_page/bloc/home_page_bloc.dart';
import 'package:finansal_kocluk_takip/home_page/bloc/home_page_status/home_page_status.dart';
import 'package:finansal_kocluk_takip/home_page/widgets/current_balance.dart';
import 'package:finansal_kocluk_takip/home_page/widgets/expenses_donut_chart.dart';
import 'package:finansal_kocluk_takip/home_page/widgets/income_expenses_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/sabitler.dart';
import '../../data/model/expense.dart';
import '../../data/model/period_type.dart';
import '../../income_expense_page/view/income_expanse_page.dart';
import '../../locator.dart';
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

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Sabitler.generalPrimaryColor,
          title: Text("Cüzdanım360", style: GoogleFonts.pacifico(fontSize: 25, color: Colors.white),),
          centerTitle: true,
        ),
        body:
        SingleChildScrollView(

          child: Column(
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
          
              (isOpen) ?Container(): BlocBuilder<HomePageBloc,HomePageState>(
          
          
                  buildWhen:(previous,current)
                  {
                    return (previous.expenses!=current.expenses)||(previous.date!=current.date);
                  },
                  builder:(context,state)
                  {
                    final expensesList=expensesButtonList(context);

                    return Container(
          
          
                      height:500,
          
          
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: expensesList.sublist(0, 4),
                          ),
                          const SizedBox(width:10),
          
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
                              children: [
                                expensesList[4],
          
                                ExpensesDonutChart(expenses:context.read<HomePageBloc>().state.expenses,date:context.read<HomePageBloc>().state.date),
                                expensesList[5],
                              ],
          
                            ),
                          ),
                          const SizedBox(width:10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: expensesList.sublist(6, 10),
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
          
          
                   CurrentBalance(),

                  Expanded(
                    child: IconButton(
                      onPressed: ()
                      {
                        setState(()
                        {
                          isOpen = !isOpen;
                          context.read<HomePageBloc>().add(ShowIncomeList(isOpen),);
                        });


                      },
                      icon: Icon(Icons.menu, size: 45, color: Sabitler.generalPrimaryColor,)),
                  ),
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
                      height: isOpen ? (context.read<HomePageBloc>().state.incomes.length)+(context.read<HomePageBloc>().state.expenses.length)*80 : 0.0,
                      child: isOpen ? SingleChildScrollView(
                          child: IncomeExpensesListtile(model: theMapSelectedByCategory(context.read<HomePageBloc>().state.incomes,context.read<HomePageBloc>().state.expenses))): Container(),
                    );
                  }
              ),
          
              const SizedBox(height:20),
          
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
          ),
        )

    );

  }



   List<Widget> expensesButtonList(BuildContext context) {

    return Sabitler.expensesSelections.entries.toList().asMap().entries.map((indexedEntry)
    {
      final i = indexedEntry.key;
      final entry = indexedEntry.value;

     final theValue=calculatethePercentbyExpenses(context.read<HomePageBloc>().state.expenses, entry.value);


      return Column(
        children: [
          IconButton(
            icon: Icon(entry.key, size: 45, color: Sabitler.colorsForExpensesButtons[i],),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => IncomeExpansePage(isitIncomepage: false, type: PeriodType.daily, buttonName: entry.value,primaryColor:Sabitler.colorsForExpensesButtons[i] ,),),);
            },
          ),

          (theValue==0.0)?Container():Text(" % ${theValue.toStringAsFixed(2)} \n ${entry.value}",style:GoogleFonts.poppins(fontSize:15,color:Sabitler.colorsForExpensesButtons[i],fontWeight: FontWeight.w400))
        ],
      );
    }).toList();
  }
  double calculatethePercentbyExpenses(List<ExpenseModel> expensesList, String categoryofExpense) {
    double totalAmount = 0.0;

    double categoryAmount = 0.0;

    for (var expense in expensesList) {
      totalAmount += expense.amount;

      if (expense.category == categoryofExpense) {
        categoryAmount += expense.amount;
      }
    }

    return (totalAmount == 0.0) ?0.0:(categoryAmount / totalAmount)*100;

  }

  Map<String, List<dynamic>> theMapSelectedByCategory(List<IncomeModel> incomelist,List<ExpenseModel>expenselist) {


    Map<String,List<dynamic>> map={};
    for(var value in incomelist)
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

    for(var value in expenselist)
      {
        if(map[value.category]==null)
          {
            map[value.category]=[]..add(value);
          }
        else
          {
            map[value.category]!.add(value);
          }
      }


    return map;
  }
}