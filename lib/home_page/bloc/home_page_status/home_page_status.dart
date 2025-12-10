import 'package:finansal_kocluk_takip/data/model/income.dart';
import '../../../data/model/expense.dart';

class HomePageState
{
  final double currentBalance;
  final List<IncomeModel> incomes;
  final List<ExpenseModel> expenses;
  HomePageState({required this.currentBalance,required this.incomes,required this.expenses});
  HomePageState copyWith({double ? currentBalance,List<IncomeModel>? incomes,List<ExpenseModel> ? expenses})
  {
    return HomePageState(
        currentBalance: currentBalance?? this.currentBalance,
        incomes: incomes ??this.incomes,
        expenses:expenses??this.expenses
    );

  }
}