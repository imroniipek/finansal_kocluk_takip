import 'dart:async';
import 'package:finansal_kocluk_takip/data/model/expense.dart';
import 'package:finansal_kocluk_takip/data/repositories/expenses_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/sabitler.dart';
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
      expenses: [],
      displayDate: null
    ),
  )
  {
    datesubriction = dateBloc.stream.listen((dateState)
    {
       {
        add(CalculateCurrentBalance());
        add(GetExpensesList());
        add(GetIncomeList());
      }
    });

    on<CalculateCurrentBalance>((event, emit) async {
      try {

        final theDate=dateBloc.state.dbdate;

        final currentIncomeAmount= await locator<IncomeRepository>().calculateCurrentAmount(theDate);

        final currentExpensesAmount=await locator<ExpensesRepository>().calculateTheAmountofExpenses(theDate);

        final currentAmount=currentIncomeAmount-currentExpensesAmount;

        emit(state.copyWith(currentBalance: currentAmount,displayDate: null));

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

        emit(state.copyWith(expenses: expensesList,displayDate: null));

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
        emit(state.copyWith(incomes: incomeList,displayDate: null));

      }
      catch(e)
      {
        print("Hata" +e.toString());
      }
    }
    );

    on<CalculateTheValuesFor7Days>(
        (event,emit)
       async {
          List<IncomeModel>incomes=[];

          List<ExpenseModel>expenses=[];

          final firstDate=DateFormat("dd.MM.yyyy").parse(dateBloc.state.dbdate);

          final lastDate=firstDate.subtract(Duration(days:7));

          for(DateTime day=lastDate;day.isBefore(firstDate)||day.isAtSameMomentAs(firstDate);day=day.add(Duration(days:1)))
            {
              final theDay=DateFormat("dd.MM.yyyy").format(day);

              final IncomeListFromDb=await  locator<IncomeRepository>().getAllofIncomesList(theDay);

              final ExpensesListFromDb= await locator<ExpensesRepository>().expensesList(theDay);
              for (var item in IncomeListFromDb)
                {
                  incomes.add(item);
                }
              for(var item in ExpensesListFromDb)
                {
                  expenses.add(item);
                }

            }
          final formattedFirst = DateFormat("dd.MM.yyyy").format(firstDate);
          final formattedLast = DateFormat("dd.MM.yyyy").format(lastDate);

          emit(state.copyWith(expenses: expenses, incomes: incomes, displayDate: "$formattedLast - $formattedFirst",),);
        }

    );

    on<CalculateTheValuesForTheMonth>(
        (event,emit)
        async {
          int ? monthNumber;
          for(var entry in Sabitler.monthMap.entries)
            {
              if(entry.value==event.monthName)
                {
                  monthNumber=entry.key;
                }
            }
          if(monthNumber!=null)
            {
              final  expensesList=await locator<IncomeRepository>().getAllOfIncomeModelByMonthNumber(monthNumber);
            
            }
        }
    );
  }
  @override
  Future<void> close() {
    datesubriction.cancel();
    return super.close();
  }
}
