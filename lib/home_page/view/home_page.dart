import 'package:finansal_kocluk_takip/data/repositories/income_repository.dart';
import 'package:finansal_kocluk_takip/home_page/widgets/current_balance.dart';
import 'package:finansal_kocluk_takip/home_page/widgets/expenses_and_income_listtiles.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_events/events.dart';
import 'package:finansal_kocluk_takip/income_expense_page/view/income_expanse_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/sabitler.dart';
import '../../income_expense_page/bloc/general_bloc.dart';
import '../../locator.dart';
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

    final incomes = context.read<IncomeExpenseBloc>().state.incomes;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Sabitler.generalPrimaryColor,
        title: Text("Cüzdanım360", style: GoogleFonts.pacifico(fontSize: 25, color: Colors.white),),
        centerTitle: true,
      ),

      body: Column(
        children: [

          const SizedBox(height: 10),

          Text(context.read<IncomeExpenseBloc>().state.date, style: GoogleFonts.poppins(fontSize: 25, color: Colors.black),),

          const SizedBox(height: 20),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              IconButton(
                onPressed: ()
                {
                  setState(() {

                    isOpen = !isOpen;
                    context.read<IncomeExpenseBloc>().add(ShowIncomeandExpensesList(isOpen));

                  });
                },
                icon: Icon(Icons.menu, size: 45, color: Sabitler.generalPrimaryColor,),
              ),

              CurrentBalance(),


              Icon(Icons.menu, size: 45, color: Sabitler.generalPrimaryColor,),
            ],
          ),

          SizedBox(height: 10),


          AnimatedContainer(
            duration: Duration(milliseconds: 150),
            curve: Curves.easeInOut,
            height: isOpen ? (incomes.length * 75) : 0,
            child: isOpen ?
            ListView.builder(
              shrinkWrap: true,
              physics:BouncingScrollPhysics(),
              itemCount: incomes.length,
              itemBuilder: (context, index)
              {
                return IncomeListtile(model: incomes[index],);
              },
            ) : Container(),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                ExpensesandIncomeButtons(icon: Icon(Icons.add, size: 45, color: Sabitler.incomeColor), color: Sabitler.incomeColor, isitIncome: true,),
                ExpensesandIncomeButtons(icon: Icon(Icons.remove, size: 45, color: Sabitler.expensesColor), color: Sabitler.expensesColor, isitIncome: false,),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
