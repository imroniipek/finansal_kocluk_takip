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
    ),
  ) {

    on<CalculateCurrentBalance>((event, emit) async {
      try {
        final currentAmount = await locator<IncomeRepository>().calculateCurrentAmount(event.date);

        print("Mevcut guncel bakiye: ${currentAmount.toString()}");

        emit(state.copyWith(currentBalance: currentAmount));
      } catch (e) {
        print(e.toString());
      }
    });

    on<ShowIncomeList>((event, emit) async {
      if (event.isOpenned == true) {
        try{
          print(state.date);
          final incomes = await locator<IncomeRepository>().getAllofIncomesList(state.date);

          print(incomes[0]);
          emit(state.copyWith(incomes: incomes));
          print("İşlem bAşarılı");
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
    });


    add(CalculateCurrentBalance(
      date: Sabitler.converttoDate(DateTime.now()),
    ));

  }
}
