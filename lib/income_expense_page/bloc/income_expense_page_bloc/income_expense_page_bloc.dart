import 'package:flutter_bloc/flutter_bloc.dart';
import '../income_expense_page_events/events.dart';
import '../income_expense_page_states/status.dart';
class IncomeExpenseBloc extends Bloc<IncomeExpenseEvent, IncomeExpenseStatus> {

  IncomeExpenseBloc() : super(IncomeExpenseStatus(title: "Yeni Gelir",),)

  {
    on<ChangeType>((event, emit) {
      emit(state.copyWith(
        title: (event.isIncome == true) ? "Yeni Gelir" : "Yeni Gider",));
    });

  }
}
