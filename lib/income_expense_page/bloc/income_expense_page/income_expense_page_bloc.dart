import 'package:flutter_bloc/flutter_bloc.dart';
import 'events.dart';
import 'status.dart';
class IncomeExpenseBloc extends Bloc<IncomeExpenseEvent, IncomeExpenseStatus> {
  IncomeExpenseBloc() : super(IncomeExpenseStatus(title: "Yeni Gelir",),)
  {
    on<ChangeType>((event, emit) {
      emit(state.copyWith(
        title: (event.isIncome == true) ? "Yeni Gelir" : "Yeni Gider",));
    });
  }
}
