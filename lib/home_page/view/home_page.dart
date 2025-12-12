import 'package:finansal_kocluk_takip/core/helpers/home_page_helpers/home_page_helper.dart';
import 'package:finansal_kocluk_takip/date/date_bloc/date_bloc.dart';
import 'package:finansal_kocluk_takip/date/date_event/date_event.dart';
import 'package:finansal_kocluk_takip/home_page/bloc/home_page_status/home_page_status.dart';
import 'package:finansal_kocluk_takip/home_page/widgets/current_balance.dart';
import 'package:finansal_kocluk_takip/home_page/widgets/drawer.dart';
import 'package:finansal_kocluk_takip/home_page/widgets/expenses_donut_chart.dart';
import 'package:finansal_kocluk_takip/home_page/widgets/income_expenses_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/sabitler.dart';
import '../../date/date_status/date_status.dart';
import '../../income_expense_page/view/income_expanse_page.dart';
import '../bloc/home_page_bloc/home_page_bloc.dart';
import '../widgets/expenses_and_income_buttons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    context.read<DateBloc>().add(DateEvent(date: DateTime.now()));
    super.initState();
  }

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        drawer: MyDrawer(),

        appBar: AppBar(

          iconTheme: IconThemeData(color: Colors.white, size: 30,),

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
                        context.read<DateBloc>().add(DateEvent(date:selectedDate));
                      }
                    },
                    icon: Icon(Icons.calendar_month, size: 30, color: Sabitler.generalPrimaryColor,),
                  ),


                  BlocBuilder<DateBloc, DateState>(
                    builder: (context, dateState) {
                      return BlocBuilder<HomePageBloc, HomePageState>(
                        buildWhen: (prev, curr) => prev.displayDate != curr.displayDate,
                        builder: (context, homeState) {
                          if (homeState.displayDate != null) {
                            return Text(homeState.displayDate!, style: GoogleFonts.poppins(fontSize: 20),);
                          }
                          return Text(dateState.date, style: GoogleFonts.poppins(fontSize: 20),);
                        },
                      );
                    },
                  ),

                ],
              ),

              const SizedBox(height: 20),

              (isOpen) ?Container(): BlocBuilder<HomePageBloc,HomePageState>(


                  buildWhen:(previous,current)
                  {
                    return (previous.expenses!=current.expenses);
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

                                ExpensesDonutChart(expenses: state.expenses, date: context.read<DateBloc>().state.dbdate),
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: ()
                    {
                      setState(()
                      {
                        isOpen = !isOpen;
                      });


                    },
                    icon: Icon(Icons.menu, size: 45, color: Sabitler.generalPrimaryColor,),
                  ),


                  CurrentBalance(),

                  IconButton(
                      onPressed: ()
                      {
                        setState(()
                        {
                          isOpen = !isOpen;
                        });

                      },
                      icon: Icon(Icons.menu, size: 45, color: Sabitler.generalPrimaryColor,)),
                ],
              ),

              const SizedBox(height: 5),

              BlocBuilder<HomePageBloc,HomePageState>(

                  buildWhen:(previous,current)
                  {
                    return (previous.incomes != current.incomes)||(previous.expenses!=current.expenses);
                  },
                  builder:(context,state)
                  {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      height: isOpen ? ((context.read<HomePageBloc>().state.incomes.length)+(context.read<HomePageBloc>().state.expenses.length))*120 : 0.0,
                      child: isOpen ? SingleChildScrollView(
                          child: IncomeExpensesListtile(model: HomePageHelper.theMapSelectedByCategory(context.read<HomePageBloc>().state.incomes,context.read<HomePageBloc>().state.expenses))): Container(),
                    );
                  }
              ),

              const SizedBox(height:5),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ExpensesandIncomeButtons(icon: Icon(Icons.add, size: 40,color:Sabitler.incomeColor), color: Sabitler.incomeColor, isitIncome: true),
                  const SizedBox(width:100),
                  ExpensesandIncomeButtons(icon: Icon(Icons.remove, size: 40,color:Sabitler.expensesColor), color: Sabitler.expensesColor, isitIncome: false),
                ],
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

      final theValue=HomePageHelper.calculatethePercentbyExpenses(context.watch<HomePageBloc>().state.expenses, entry.value);


      return Column(
        children: [
          IconButton(
            icon: Icon(entry.key, size: 45, color: Sabitler.colorsForExpensesButtons[i],),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => IncomeExpansePage(isitIncomepage: false, buttonName: entry.value,primaryColor:Sabitler.colorsForExpensesButtons[i] ,),),);
            },
          ),

          (theValue==0.0)?Container():Text(" % ${theValue.toStringAsFixed(2)} \n ${entry.value}",style:GoogleFonts.poppins(fontSize:15,color:Sabitler.colorsForExpensesButtons[i],fontWeight: FontWeight.w400))
        ],
      );
    }).toList();
  }
}