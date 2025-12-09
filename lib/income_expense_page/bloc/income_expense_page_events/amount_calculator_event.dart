abstract class AmountCalculatorEvent{}

class AddDigit extends AmountCalculatorEvent
{
  final String digit;

  AddDigit(this.digit);
}

class AddOperator extends AmountCalculatorEvent
{
  final String operator;

  AddOperator(this.operator);
}

class CalculateResult extends AmountCalculatorEvent{}

class ResetTheCalculator extends AmountCalculatorEvent {}

class AddNote extends AmountCalculatorEvent{

  final String note;

  AddNote(this.note);

}
class ClearTheDigit extends AmountCalculatorEvent
{

}
class ClickTheButton extends AmountCalculatorEvent{}

class UpdateTheModel extends AmountCalculatorEvent
{

  //Bu HomePagedeki bir listtile basınca guncellemek silmek icin yapılan bir eventtir//
  final dynamic model;

  UpdateTheModel({required this.model});

}