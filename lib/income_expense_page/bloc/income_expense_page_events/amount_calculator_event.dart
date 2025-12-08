
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
class ClickTheButton extends AmountCalculatorEvent
{
  final String ? buttonName;

  final String ?  model;

  ClickTheButton({this.buttonName,this.model});
}

class UpdateTheModel extends AmountCalculatorEvent
{

  //Bu HomePagedeki bir listtile basınca guncellemek silmek icin yapılan bir eventtir//
  final dynamic Model;

  UpdateTheModel({required this.Model});

}