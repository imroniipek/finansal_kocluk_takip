import 'dart:async';
import 'package:finansal_kocluk_takip/data/model/expense.dart';
import 'package:finansal_kocluk_takip/data/repositories/expenses_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helpers/home_page_helpers/drawer_helper.dart';
import '../../../data/model/income.dart';
import '../../../data/repositories/income_repository.dart';
import '../../../date/date_bloc/date_bloc.dart';
import '../../../locator.dart';
import '../home_page_event/home_page_event.dart';
import '../home_page_status/home_page_status.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {

  final DateBloc dateBloc;

  late StreamSubscription datesubriction;

  HomePageBloc(this.dateBloc) : super(
    HomePageState(
      currentBalance: 0.0,
      incomes: [],
      expenses: []
    ),
  )
  {

    datesubriction=dateBloc.stream.listen(
        (dateState)
            {
              add(CalculateCurrentBalance());
              add(GetExpensesList());
              add(GetIncomeList());

            }
    );

    on<CalculateCurrentBalance>((event, emit) async {
      try {

        final theDate=dateBloc.state.dbdate;

        final currentIncomeAmount= await locator<IncomeRepository>().calculateCurrentAmount(theDate);

        final currentExpensesAmount=await locator<ExpensesRepository>().calculateTheAmountofExpenses(theDate);

        final currentAmount=currentIncomeAmount-currentExpensesAmount;

        emit(state.copyWith(currentBalance: currentAmount));

        print("toplam miktar: ${currentAmount}");
      }
      catch (e)
      {
        print(e.toString());
      }
    });

    on<GetExpensesList>((event,emit)
    async {
      try
      {
        final theDate=dateBloc.state.dbdate;

        final expensesList=await locator<ExpensesRepository>().expensesList(theDate);

        emit(state.copyWith(expenses: expensesList));

      }
      catch(e)
      {
        print("Hata" +e.toString());
      }

    }
    );

    on<GetIncomeList>((event,emit)
    async{

      try
      {
        final theDate=dateBloc.state.dbdate;
        print(" listeyi getirdeki tarih: mevcut tarih $theDate");
        final incomeList=await locator<IncomeRepository>().getAllofIncomesList(theDate);
        print("Listenin uzunlugu : ${incomeList.length}");
        emit(state.copyWith(incomes: incomeList));

      }
      catch(e)
      {
        print("Hata" +e.toString());
      }
    }
    );

    on<CalculateTheValuesFor7Days>(
        (event,emit)
        {
          List<IncomeModel>incomes=[];

          List<ExpenseModel>expenses=[];

          final firstDate=DateTime.parse(event.firstDay);

          final lastDate=firstDate.add(Duration(days:7));





        }



    );

  }
  @override
  Future<void> close() {
    datesubriction.cancel();
    return super.close();
  }
}
