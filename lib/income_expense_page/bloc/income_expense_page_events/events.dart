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

class AddDigit extends IncomeExpenseEvent
{
  final String digit;

  AddDigit(this.digit);
}

class AddOperator extends IncomeExpenseEvent
{
  final String operator;

  AddOperator(this.operator);
}

class CalculateResult extends IncomeExpenseEvent {}

class ResetTheCalculater extends IncomeExpenseEvent {}

class AddNote extends IncomeExpenseEvent{

  final String note;

  AddNote(this.note);

}
class ClearTheDigit extends IncomeExpenseEvent
{

}

class SaveTheValues extends IncomeExpenseEvent
{
  final bool isitIncome;
  final Map<String,dynamic> map;

  SaveTheValues({required this.isitIncome,required this.map});
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






