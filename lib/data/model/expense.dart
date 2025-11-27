
import 'package:finansal_kocluk_takip/data/model/period_type.dart';

import '../../core/sabitler.dart';

class ExpenseModel{

  final int ? id;

  final String date;

  final String category;

  final PeriodType periodType;

  final double amount;

  final String? note;

  ExpenseModel({this.id,required this.date,required this.category,required this.periodType,required this.amount,this.note});

  Map<String,dynamic> toMap()
  {
    return
      {
        "id":id,

        "date":date,

        "category":category,

        "period":Sabitler.conevertPeriodTypetoInetegerValue(periodType),

        "amount":amount,

        "note":note,
      };
  }




  factory ExpenseModel.fromDb(Map<String,dynamic> map)
  {
    final value= Sabitler.findTheType(map["period_type"]);


    return ExpenseModel(

        id:map["id"],

        date:map["date"],

        category:map["category"],

        amount:map["amount"],

        periodType: value,

        note:map["note"]

    );
  }

}