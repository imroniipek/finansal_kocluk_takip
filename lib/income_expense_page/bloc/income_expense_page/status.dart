abstract class IncomeExpenseState {}

class IncomeExpenseStatus extends IncomeExpenseState {

  final String title;
  IncomeExpenseStatus({required this.title,});

  IncomeExpenseStatus copyWith({String? title}) {
    return IncomeExpenseStatus(
      title: title ?? this.title, //Null olabilir null ise eski title degerini al diyoruz kısacası
    );
  }
}
