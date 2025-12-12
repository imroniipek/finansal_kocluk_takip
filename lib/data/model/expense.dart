class ExpenseModel{

  final int ? id;

  final String date;

  final String category;

  final double amount;

  final String? note;

  ExpenseModel({this.id,required this.date,required this.category,required this.amount,this.note});

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
  factory ExpenseModel.fromMap(Map<String,dynamic> map)
  {

    return ExpenseModel(

        id:map["id"],

        date:map["date"],

        category:map["category"],

        amount: (map["amount"] as num).toDouble(),

        note:map["note"]

    );
  }
}