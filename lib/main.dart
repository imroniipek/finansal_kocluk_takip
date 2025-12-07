import 'package:finansal_kocluk_takip/home_page/bloc/home_page_bloc.dart';
import 'package:finansal_kocluk_takip/home_page/view/home_page.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/amount_calculator_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/db_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/view/income_expanse_page.dart';
import 'package:finansal_kocluk_takip/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'income_expense_page/bloc/income_expense_page_bloc.dart';

void main() {

  setupLocator();

  runApp(
    MultiBlocProvider(providers:
    [
      BlocProvider(create: (_) => IncomeExpenseBloc(),),

      BlocProvider(create: (_)=>HomePageBloc()),
      
      BlocProvider(create: (_)=>DbBloc()),
      
      BlocProvider(create: (_)=>AmountCalculatorBloc())
   ],
   child:MyApp()
  ));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home:HomePage()
    );
  }
}


