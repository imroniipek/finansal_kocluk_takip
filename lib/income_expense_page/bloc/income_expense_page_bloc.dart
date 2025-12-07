import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../core/sabitler.dart';
import 'income_expense_page_events/events.dart';
import 'income_expense_page_states/status.dart';


class IncomeExpenseBloc extends Bloc<IncomeExpenseEvent, IncomeExpenseStatus> {

  IncomeExpenseBloc() : super(IncomeExpenseStatus(

      title: "Yeni Gelir",
      date: Sabitler.converttoDate(DateTime.now())

  ),

  ) {
    on<ChangeType>((event, emit) {
      emit(state.copyWith(
        title: (event.isIncome == true) ? "Yeni Gelir" : "Yeni Gider",));
    });

    on<SelectDate>((event, emit) {
      final dayName = Sabitler.days[DateFormat("EEEE").format(event.date)];
      final month = Sabitler.monthMap[event.date.month];
      final day = event.date.day;

      emit(state.copyWith(date: "$dayName, $day $month"));

      print(state.date);
    });

  }

}
