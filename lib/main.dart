import 'package:finansal_kocluk_takip/analysis/view/analysis_view.dart';
import 'package:finansal_kocluk_takip/core/navigator.dart';
import 'package:finansal_kocluk_takip/home_page/bloc/home_page_bloc/home_page_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/amount_calculator/amount_calculator_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/db/db_bloc.dart';
import 'package:finansal_kocluk_takip/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'date/date_bloc/date_bloc.dart';
import 'income_expense_page/bloc/income_expense_page/income_expense_page_bloc.dart';
void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  setupLocator();

  runApp(
    MultiBlocProvider(providers:
    [
      BlocProvider(create: (_)=>DateBloc()),

      BlocProvider(create: (_) => IncomeExpenseBloc(),),

      BlocProvider(create: (context) => HomePageBloc(context.read<DateBloc>(),),),
      
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
      home:MainScaffold()
    );
  }
}
