import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../core/sabitler.dart';
import 'income_expense_page_events/events.dart';
import 'income_expense_page_states/status.dart';


class IncomeExpenseBloc extends Bloc<IncomeExpenseEvent, IncomeExpenseStatus> {
  
  IncomeExpenseBloc() : super(IncomeExpenseStatus(title: "Yeni Gelir", date: converttoDate(DateTime.now()) , numbers: [],tempValue: "0"),) {
    on<ChangeType>((event, emit) {
      emit(
          state.copyWith(title: event.isIncome ? "Yeni Gelir" : "Yeni Gider",));
    });

    on<SelectDate>((event, emit) {
      final dayName = Sabitler.days[DateFormat("EEEE").format(event.date)];
      final month = Sabitler.monthMap[event.date.month];
      final day = event.date.day;

      emit(state.copyWith(date: "$dayName, $day $month"));
    });

    on<AddDigit>((event, emit) {
      final newList = List<String>.from(state.numbers)..add(event.digit); //Basılan Tusu buraya gelecem sonra da onu double degerlere donustruecem//


      String A = converttoString(newList);

      print(A);

      emit(state.copyWith(numbers: newList, tempValue: A));
    });

    on<AddOperator>((event, emit) {

      final value = (state.numbers.length == 0) ? 0.0 : double.parse(state.numbers.join());

      if (state.firstValue == null)
      {
        emit(state.copyWith(firstValue: value, operator: event.operator, numbers: [], tempValue: ""));
      }
      else {
        final operator = (state.operator == null) ? event.operator : state.operator;

        final result = _apply(state.firstValue!, value, operator!,);

        emit(state.copyWith(
          firstValue: result, operator: event.operator, numbers: [],));
      }
    });

    on<CalculateResult>((event, emit) {
      if (state.firstValue == null || state.operator == null) return;

      final value = double.parse(state.numbers.join());

      print(value.toString());

      final result = (_apply(state.firstValue!, value, state.operator!,) * 100).floor() / 100;

      print(result.toString());

      emit(state.copyWith(firstValue: result, tempValue: result.toString(), operator: null, numbers: [],));
    });

    on<AddNote>((event, emit) {
      final note = event.note;

      emit(state.copyWith(note: note));
    });


    on<ClearTheDigit>((event, emit)
    {
      final value = state.tempValue ?? "";

      if(value.isEmpty) return;

      if(value.length == 1)
      {
        emit(state.copyWith(tempValue: "0", numbers: []));

        return;
      }

      var newList = value.split("").sublist(0, value.length - 1);

      if(newList.isNotEmpty && newList.last == ".")
      {
        newList = newList.sublist(0, newList.length - 1);
      }

      emit(state.copyWith(tempValue: newList.join(), numbers: newList));

    });
  }

  String converttoString(List<String> number)
  {
    return number.map((e)=>e).join();
  }

  static String converttoDate(DateTime now)
  {
    final month=Sabitler.monthMap[now.month];

    final day=Sabitler.days[DateFormat("EEEE").format(now)];

    return "${day},${now.day} ${month}";


  }

  double _apply(double a, double b, String op) {
    switch (op) {
      case "+": return (a + b);

      case "-": return a - b;

      case "*": return a * b;

      case "/": return a / b;

      default: return a;
    }
  }
}
