import 'package:finansal_kocluk_takip/data/model/income.dart';
import '../../../data/model/expense.dart';
class HomePageState
{
  final double currentBalance;
  final List<IncomeModel> incomes;
  final List<ExpenseModel> expenses;
  String ?displayDate;

  HomePageState({required this.currentBalance,required this.incomes,required this.expenses,this.displayDate});
  HomePageState copyWith({double ? currentBalance,List<IncomeModel>? incomes,List<ExpenseModel> ? expenses,String ? displayDate})
  {
    return HomePageState(
        currentBalance: currentBalance?? this.currentBalance,
        incomes: incomes ??this.incomes,
        expenses:expenses??this.expenses,
        displayDate: displayDate
    );
  }
}