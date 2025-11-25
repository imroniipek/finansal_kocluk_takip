abstract class IncomeExpenseState {}

class IncomeExpenseStatus extends IncomeExpenseState {
  final String title;

  final String date;

  final List<String> numbers;

  final double? firstValue;

  final String? operator;

  final String? tempValue;

  final String? note;

  IncomeExpenseStatus({required this.title, required this.date, required this.numbers, this.firstValue, this.operator, this.tempValue, this.note,});

  IncomeExpenseStatus copyWith({String? title, String? date,bool setFirstOperator=false,bool setFirstValueToNull=false, List<String>? numbers, double? firstValue, String? operator, String? tempValue, String? note,}) {
    return IncomeExpenseStatus(
      title: title ?? this.title,

      date: date ?? this.date,

      numbers: numbers ?? List<String>.from(this.numbers),

      operator: setFirstOperator ? null : (operator ?? this.operator),

      tempValue: tempValue ?? this.tempValue,

      firstValue: setFirstValueToNull ? null : (firstValue ?? this.firstValue),

      note: note ?? this.note,
    );
  }
}
