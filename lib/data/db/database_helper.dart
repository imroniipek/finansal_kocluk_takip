import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper
{
  static Database? _database;

  Future<Database> get database async
  {
    //Burdaki Database degerini alarak bazı işlemleri halledecem//

    if(_database!=null)
      {
        return _database!;
      }
    else
    {

      _database = await _initDB("finance.db");
      return _database!;
    }

  }

  Future<Database> _initDB(String fileName)
  async{

    final dbPath=await getDatabasesPath();

    //Flutter uygulamaları veritabanını kafasına göre herhangi bir klasöre yazamaz.Android ve iOS, veritabanı dosyalarının nerede saklanacağını belirleyen özel güvenli klasörler kullanır.


    final path=join(dbPath,fileName);

    return await openDatabase(
        path,
        version:1,
        onCreate: _createDB,
    );


  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    
      CREATE TABLE incomes(
      
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        
        date TEXT NOT NULL,
        
        category TEXT NOT NULL,
        
        amount NUMERIC NOT NULL,
        
        period_type INTEGER NOT NULL,
        
        note TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE expenses(
      
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        
        date TEXT NOT NULL,
        
        category TEXT NOT NULL,
        
        amount NUMERIC NOT NULL,
        
        period_type INTEGER NOT NULL,
        
        note TEXT
      );
    ''');
  }






}