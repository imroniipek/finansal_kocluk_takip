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

        return ;
      }
      catch(e)
      {
        print("Hata" +e.toString());
      }

    }
    );



    on<ShowIncomeList>((event, emit)
    async
    {
      if (event.isOpenned == true) {
        try{
          final incomes = await locator<IncomeRepository>().getAllofIncomesList(state.date);

          emit(state.copyWith(incomes: incomes));

          return ;
        }
        catch(e)
      {
        print(e.toString());
      }
      }
    });

    on<ChangeTheDate>((event, emit) {
      final newDate = Sabitler.converttoDate(event.time);

      emit(state.copyWith(date: newDate));

      add(CalculateCurrentBalance(date: newDate));

      add(getExpensesList(newDate));

    });


    add(CalculateCurrentBalance(
      date: Sabitler.converttoDate(DateTime.now()),
    ));


    add(getExpensesList(
        Sabitler.converttoDate(DateTime.now())
    ));

  }
}
