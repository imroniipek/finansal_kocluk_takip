
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_events/db_events.dart';

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

  final DbEvent ? dbEvent;

  clickTheButton({this.buttonName,this.dbEvent});
}

class UpdateTheModel extends AmountCalculatorEvent
{

  final dynamic Model;

  UpdateTheModel({required this.Model});

}