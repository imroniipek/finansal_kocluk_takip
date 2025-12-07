import '../../../data/model/expense.dart';

abstract class IncomeExpenseEvent {}

class ChangeType extends IncomeExpenseEvent
{
  final bool isIncome;

  ChangeType(this.isIncome);
}

class SelectDate extends IncomeExpenseEvent
{
  final DateTime date;



  SelectDate(this.date);
}








