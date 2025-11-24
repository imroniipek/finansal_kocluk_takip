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

class ClearAll extends IncomeExpenseEvent {}

class AddNote extends IncomeExpenseEvent{

  final String note;

  AddNote(this.note);

}
class ClearTheDigit extends IncomeExpenseEvent
{

}




