import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_events/db_events.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_states/db_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/expense.dart';
import '../../../data/model/income.dart';
import '../../../data/repositories/expenses_repository.dart';
import '../../../data/repositories/income_repository.dart';
import '../../../locator.dart';

class DbBloc extends Bloc<DbEvent,DbStatus>
{
  DbBloc():super(DbStatus(status: PageStatus.idle)) {
    on<SavetoDb>((event, emit) async {
      emit(state.copyWith(PageStatus.loading));

      try {
        if (event.isitIncome == true) {
          final model = IncomeModel.fromMap(event.theMap);

          final id = await locator<IncomeRepository>().addIncome(model);

          if (id > 0) {
            emit(state.copyWith(PageStatus.success));

            emit(state.copyWith(PageStatus.idle));
          }

          else {
            emit(state.copyWith(PageStatus.error));
          }
        }
        else {
          final model = ExpenseModel.fromMap(event.theMap);

          final id = await locator<ExpensesRepository>().addExpense(model);
          if (id > 0) {
            emit(state.copyWith(PageStatus.success));
            emit(state.copyWith(PageStatus.idle));
          }
          else {
            emit(state.copyWith(PageStatus.error));
          }
        }
      }
      catch (e)
      {
        emit(state.copyWith(PageStatus.error));
      }
    });

    on<UpdatetoDb>(
            (event, emit) async {
          try {
            if (event.isitIncome == true) {
              final theUpdateModel = IncomeModel.fromMap(
                  returnTheMap(event.theMapForUpdated, event.modelId));
              (await locator<IncomeRepository>().updateIncome(theUpdateModel) >
                  0) ? emit(state.copyWith(PageStatus.success)) : emit(
                  state.copyWith(PageStatus.error));
            }
            else {
              final theUpdateModel = ExpenseModel.fromMap(
                  returnTheMap(event.theMapForUpdated, event.modelId));
              (await locator<ExpensesRepository>().updateExpense(
                  theUpdateModel) > 0) ? emit(
                  state.copyWith(PageStatus.success)) : emit(
                  state.copyWith(PageStatus.error));
            }
          }
          catch (e) {
            emit(state.copyWith(PageStatus.error));
          }
        }
    );

    on<DeleteTheModelFromDb>(
            (event, emit) async {
          try {
            if (event.isitIncome == true) {
              (await locator<IncomeRepository>().deleteIncome(event.modelId) >
                  0) ? emit(state.copyWith(PageStatus.success)) : emit(
                  state.copyWith(PageStatus.error));
            }
            else {
              (await locator<ExpensesRepository>().deleteExpense(
                  event.modelId) > 0) ? emit(state.copyWith(PageStatus.success)) : emit(state.copyWith(PageStatus.error));
            }
          }
          catch (e)
          {
            emit(state.copyWith(PageStatus.error));
          }
        }
    );
  }
  Map<String,dynamic>returnTheMap(Map<String,dynamic>currentMap,int modelId)
  {
    currentMap["id"]=modelId;
    return currentMap;
  }
}