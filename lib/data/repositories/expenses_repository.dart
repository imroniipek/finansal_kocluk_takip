
import 'package:finansal_kocluk_takip/data/db/database_helper.dart';

import '../../locator.dart';
import '../model/expense.dart';

class ExpensesRepository{

  final dbHelper=locator<DatabaseHelper>();


 Future<int>addExpense(ExpenseModel model)
  async {

    final db=await dbHelper.database;


    return await db.insert("expenses",model.toMap());
  }

  Future<int>deleteExpense(int modelId)
  async{

    final db=await dbHelper.database;


    return await db.delete("expenses",where:"id=?",whereArgs: [modelId]);
  }
  Future<int>updateExpense(ExpenseModel model)
  async
  {
    final db=await dbHelper.database;


    final i=model.id;

    return await db.update("expenses", model.toMap(),where:"id=?",whereArgs: [i]);

  }

  Future<List<ExpenseModel>>expensesList(String date)
  async {

    final db=await dbHelper.database;

    final thequeryResult=await db.query("expenses",where:"date=?",whereArgs: [date]);


    return thequeryResult.map((e)=>ExpenseModel.fromMap(e)).toList();


  }
  Future<void> printExpensesTable()
  async {
    final db=await dbHelper.database;

    final thequeryResult=db.query("expenses");

    print(thequeryResult);

  }
  Future<double>calculateTheAmountofExpenses(String date)
  async {

    double totalAmount=0.0;

    final db=await dbHelper.database;

    List<Map<String,dynamic>> listofExpenses=await db.query("expenses",where:"date=?",whereArgs: [date]);


    for(var value in listofExpenses)
      {
        totalAmount=totalAmount+value["amount"];
      }

    return totalAmount;
  }

  Future<List<ExpenseModel>> getAllOfExpensesListByMonthNumber(int monthNumber)
  async {
    List<ExpenseModel>expenses=[];
    final db=await dbHelper.database;

    List<Map<String,dynamic>> thequeryResult=await db.query("expenses");

    for(var entry in thequeryResult)
      {
        final parts = entry["date"].split(".").map((e) => e.trim()).toList();

        print("Expensestaki 2.eleman ${parts[1]}");

        if(int.parse(parts[1])==monthNumber)
          {
            final theExpensesModel=ExpenseModel.fromMap(entry);
            expenses.add(theExpensesModel);
          }
      }
    return expenses;
  }
  Future<List<ExpenseModel>> getAllofExpensesListByYear(String year)
  async {
    List<ExpenseModel>expenses=[];
    final db=await dbHelper.database;

    List<Map<String,dynamic>> thequeryResult=await db.query("expenses");

    for(var entry in thequeryResult)
    {
      final parts = entry["date"].split(".").map((e) => e.trim()).toList();

      print("Expensestaki 2.eleman ${parts[2]}");

      if(parts[2]==year)
      {
        final theExpensesModel=ExpenseModel.fromMap(entry);
        expenses.add(theExpensesModel);
      }
    }
    return expenses;
  }
}