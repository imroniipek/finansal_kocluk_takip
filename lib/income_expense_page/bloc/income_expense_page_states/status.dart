abstract class IncomeExpenseState {}

class IncomeExpenseStatus extends IncomeExpenseState {

  final String title;

  final String date;

  final List<String> numbers;

  final double? firstValue;

  final String? operator;

  String ? tempValue;

  String ? note;




  IncomeExpenseStatus({required this.title, required this.date, required this.numbers, this.firstValue, this.operator,this.tempValue,this.note});

  IncomeExpenseStatus copyWith({String? title, String? date, List<String>? numbers, double? firstValue, String? operator, String ? tempValue, String ? note,}) {
    return IncomeExpenseStatus(

      title: title ?? this.title,

      date: date ?? this.date,

      numbers: numbers ?? List.from(this.numbers),

      firstValue: firstValue ?? this.firstValue,

      operator: operator ?? this.operator,

      tempValue:tempValue ?? this.tempValue,

      note:note ??this.note,
    );
  }








}
