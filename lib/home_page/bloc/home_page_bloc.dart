import 'package:finansal_kocluk_takip/data/repositories/expenses_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/sabitler.dart';
import '../../data/repositories/income_repository.dart';
import '../../locator.dart';
import 'home_page_event/home_page_event.dart';
import 'home_page_status/home_page_status.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(
    HomePageState(
      date: Sabitler.converttoDate(DateTime.now()),
      currentBalance: 0.0,
      incomes: [],
      expenses: []
    ),
  ) {

    on<CalculateCurrentBalance>((event, emit) async {
      try {

        final currentIncomeAmount= await locator<IncomeRepository>().calculateCurrentAmount(event.date);

        final currentExpensesAmount=await locator<ExpensesRepository>().calculateTheAmountofExpenses(event.date);

        final currentAmount=currentIncomeAmount-currentExpensesAmount;

        emit(state.copyWith(currentBalance: currentAmount));

        print("toplam miktar: ${currentAmount}");
      }
      catch (e)
      {
        print(e.toString());
      }
    });

    on<getExpensesList>((event,emit)
    async {
      try
      {

        final expensesList=await locator<ExpensesRepository>().expensesList(event.date);

        emit(state.copyWith(expenses: expensesList));

      }
      catch(e)
      {
        print("Hata" +e.toString());
      }

    }
    );

    on<getIncomeList>((event,emit)
    async{

      try
      {
        print(" listeyi getirdeki tarih: mevcut tarih ${state.date}");
        final incomeList=await locator<IncomeRepository>().getAllofIncomesList(event.date);
        print("Listenin uzunlugu : ${incomeList.length}");
        emit(state.copyWith(incomes: incomeList));

      }
      catch(e)
      {
        print("Hata" +e.toString());
      }
    }
    );
    on<ChangeTheDate>((event, emit) {
      final newDate = Sabitler.converttoDate(event.time);

      print("Değiştirilen Tarih: ${newDate}");

      emit(state.copyWith(date: newDate));

      add(CalculateCurrentBalance(date: newDate));

      add(getExpensesList(newDate));

      add(getIncomeList(newDate));

    });




    add(CalculateCurrentBalance(date: state.date),);
    add(getExpensesList(state.date));
    add(getIncomeList(state.date));

  }
}
