import '../../core/sabitler.dart';
class IncomeModel{

  final int ? id;

  final String date;

  final String category;

  final double amount;

  final String? note;

  IncomeModel({this.id,required this.date,required this.category,required this.amount,this.note});

  Map<String,dynamic> toMap()
  {
    return
        {
          "id":id,

          "date":date,

          "category":category,

          "amount":amount,

          "note":note,
        };
  }




  factory IncomeModel.fromMap(Map<String,dynamic> map)
  {
    return IncomeModel(

      id:map["id"],

      date:map["date"],

      category:map["category"],

      amount:(map["amount"] as num).toDouble(),

      note:map["note"]

    );
  }
}