
import 'package:finansal_kocluk_takip/data/model/income.dart';

import '../../../data/model/expense.dart';




class HomePageState
{
  final String date;

  final double currentBalance;


  final List<IncomeModel> incomes;

  final List<ExpenseModel> expenses;

  HomePageState({required this.date,required this.currentBalance,required this.incomes,required this.expenses});


  HomePageState copyWith({String ?date,double ? currentBalance,List<IncomeModel>? incomes,List<ExpenseModel> ? expenses})
  {

    return HomePageState(
        date: date?? this.date,
        currentBalance: currentBalance?? this.currentBalance,
        incomes: incomes ??this.incomes,
        expenses:expenses??this.expenses
    );



  }



}