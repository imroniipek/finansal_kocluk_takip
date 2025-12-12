abstract class HomePageEvent{}

class CalculateCurrentBalance extends HomePageEvent{}

class GetExpensesList extends HomePageEvent{}

class GetIncomeList extends HomePageEvent{}

class CalculateTheValuesFor7Days extends HomePageEvent {}

class CalculateTheValuesForTheMonth extends HomePageEvent
{
  final String monthName;

  CalculateTheValuesForTheMonth({required this.monthName});

}
class CalculateTheValuesForTheYear extends HomePageEvent {}