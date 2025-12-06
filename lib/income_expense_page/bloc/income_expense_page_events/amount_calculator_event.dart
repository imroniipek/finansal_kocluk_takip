
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
class clickTheButton extends AmountCalculatorEvent
{
  final String ? buttonName;

  clickTheButton({this.buttonName});
}
