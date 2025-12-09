import '../../../data/model/expense.dart';
import '../../../data/model/income.dart';
class HomePageHelper{
  static double calculatethePercentbyExpenses(List<ExpenseModel> expensesList, String categoryofExpense) {
    double totalAmount = 0.0;

    double categoryAmount = 0.0;

    for (var expense in expensesList) {
      totalAmount += expense.amount;

      if (expense.category == categoryofExpense) {
        categoryAmount += expense.amount;
      }
    }

    return (totalAmount == 0.0) ?0.0:(categoryAmount / totalAmount)*100;

  }
  static Map<String, List<dynamic>> theMapSelectedByCategory(List<IncomeModel> incomelist,List<ExpenseModel>expenselist) {
    Map<String,List<dynamic>> map={};
    for(var value in incomelist)
    {
      if(map[value.category]==null)
      {
        map[value.category]=(map[value.category]??[])..add(value);
      }
      else
      {
        map[value.category]!.add(value);
      }
    }

    for(var value in expenselist)
    {
      if(map[value.category]==null)
      {
        map[value.category]=[]..add(value);
      }
      else
      {
        map[value.category]!.add(value);
      }
    }
    return map;
  }
}