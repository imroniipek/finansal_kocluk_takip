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



class DeleteTheExpenseModel extends IncomeExpenseEvent
{
  final ExpenseModel model;

  DeleteTheExpenseModel({required this.model});
}

class fromHomePage extends IncomeExpenseEvent
{
  final dynamic model;

  fromHomePage({required this.model});

}






