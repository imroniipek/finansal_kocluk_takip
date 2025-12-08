import 'package:finansal_kocluk_takip/data/db/database_helper.dart';
import '../../locator.dart';
import '../model/income.dart';

class IncomeRepository{


  final dbHelper=locator<DatabaseHelper>();


  Future<int> addIncome(IncomeModel model)
  async
  {

    final db=await dbHelper.database;

    return await db.insert("incomes",model.toMap());
  }

  Future<void> printIncomesTable() async
  {
    final db = await dbHelper.database;

    final data = await db.query("incomes");

    print(data);
  }

  Future<int> deleteIncome(int i)
  async
  {
    final db=await dbHelper.database;

    return await db.delete("incomes",where:"id=?",whereArgs: [i]);

  }
  Future<int>updateIncome(IncomeModel model)
  async
  {
    final db=await dbHelper.database;

    final i=model.id;

    return await db.update("incomes", model.toMap(),where:"id=?",whereArgs: [i]);

  }

  Future<List<IncomeModel>> getAllofIncomesList(String date)
  async{

   final db= await dbHelper.database;

    final List<Map<String,dynamic>>result=await db.query("incomes",where:"date=?",whereArgs:[date]);

    return result.map((e)=>IncomeModel.fromMap(e)).toList();
  }

  Future<double> calculateCurrentAmount(String date)
  async {

    double totalAmount=0.0;

    final db=await dbHelper.database;


    List<Map<String,dynamic>>values=await db.query("incomes",where:"date=? ",whereArgs: [date]);

    final list=values.map((e)=>IncomeModel.fromMap(e)).toList();

    for(var value in list)
      {
        totalAmount=totalAmount+value.amount;
      }

    return totalAmount;

  }
}