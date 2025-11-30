
abstract class HomePageEvent{}


class CalculateCurrentBalance extends HomePageEvent
{

  final String date;

  CalculateCurrentBalance({required this.date});

}

class ChangeTheDate extends HomePageEvent
{

  final DateTime time;

  ChangeTheDate(this.time);
}

class ShowIncomeList extends HomePageEvent
{

  final bool isOpenned;

  ShowIncomeList(this.isOpenned);

}

class getExpensesList extends HomePageEvent
{
  final String date;

  getExpensesList(this.date);



}

