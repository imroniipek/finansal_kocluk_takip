abstract class HomePageEvent{}

class CalculateCurrentBalance extends HomePageEvent{}

class GetExpensesList extends HomePageEvent{}

class GetIncomeList extends HomePageEvent{}

class CalculateTheValuesFor7Days extends HomePageEvent{
  final String firstDay;
  CalculateTheValuesFor7Days({required this.firstDay});
}