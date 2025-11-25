import 'package:finansal_kocluk_takip/income_expense_page/view/income_expanse_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'income_expense_page/bloc/general_bloc.dart';

void main() {

  runApp(
    BlocProvider(
      create: (_) => IncomeExpenseBloc(),
      child: MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home:IncomeExpansePage(isitIncomepage: false)
    );
  }
}


