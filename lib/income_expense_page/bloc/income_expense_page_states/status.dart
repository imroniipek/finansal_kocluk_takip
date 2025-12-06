abstract class IncomeExpenseState {}

class IncomeExpenseStatus extends IncomeExpenseState {

  final String title;

  final String date;


  IncomeExpenseStatus({
    required this.title,
    required this.date,

  });

  IncomeExpenseStatus copyWith({String? title, String? date,
    }) {
    return IncomeExpenseStatus(

      title: title ?? this.title, //Null olabilir null ise eski title degerini al diyoruz kısacası

      date: date ?? this.date,

    );
  }
}
