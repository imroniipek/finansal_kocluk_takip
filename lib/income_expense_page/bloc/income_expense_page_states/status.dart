
import 'package:finansal_kocluk_takip/data/model/expense.dart';
import 'package:finansal_kocluk_takip/data/model/income.dart';
import 'package:finansal_kocluk_takip/home_page/widgets/expenses_and_income_buttons.dart';

enum PageStatus{ idle, loading, success, error }

abstract class IncomeExpenseState {}

class IncomeExpenseStatus extends IncomeExpenseState {

  final String title;

  final String date;


  final List<String> numbers;

  final double? firstValue;

  final String? operator;

  final String? tempValue;

  final PageStatus status;

  final String? note;


  IncomeExpenseStatus({
    required this.title,
    required this.date,
    required this.numbers,
    this.firstValue,
    this.operator,
    this.tempValue,
    this.note,
    required this.status,

  });

  IncomeExpenseStatus copyWith({String? title,
    String? date,
    bool setFirstOperator=false,
    bool setFirstValueToNull=false,
    List<String>? numbers,
    double? firstValue,
    String? operator,
    String? tempValue,
    String? note,
    PageStatus ? status,
    List<IncomeModel>? incomes,
    List<ExpenseModel>?expenses

    }) {
    return IncomeExpenseStatus(

      title: title ?? this.title, //Null olabilir null ise eski title degerini al diyoruz kısacası

      date: date ?? this.date,


      numbers: numbers ?? List<String>.from(this.numbers),

      operator: setFirstOperator ? null : (operator ?? this.operator),

      tempValue: tempValue ?? this.tempValue,

      firstValue: setFirstValueToNull ? null : (firstValue ?? this.firstValue),

      note: note ?? this.note,

      status:status??this.status,

    );
  }
}
