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
      displayDate: null,
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
        final incomeList=await locator<IncomeRepository>().getAllofIncomesList(theDate);
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
           final formatter = DateFormat("dd.MM.yyyy");

           final firstDate = formatter.parse(dateBloc.state.dbdate);
           final lastDate = firstDate.subtract(const Duration(days: 7));
           List<IncomeModel> incomes = [];
           List<ExpenseModel> expenses = [];
           for (DateTime day = lastDate; day.isBefore(firstDate) || day.isAtSameMomentAs(firstDate); day = day.add(const Duration(days: 1))) {
             final theDay = formatter.format(day);

             final incomeList = await locator<IncomeRepository>().getAllofIncomesList(theDay);
             final expenseList = await locator<ExpensesRepository>().expensesList(theDay);

             incomes.addAll(incomeList);
             expenses.addAll(expenseList);
           }
           final incomeAmount = incomes.fold(0.0, (sum, item) => sum + item.amount);
           final expenseAmount = expenses.fold(0.0, (sum, item) => sum + item.amount);

           emit(state.copyWith(incomes: incomes, expenses: expenses, displayDate: "${formatter.format(lastDate)} - ${formatter.format(firstDate)}", currentBalance: incomeAmount - expenseAmount,),
           );
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
              final incomeList=await locator<IncomeRepository>().getAllOfIncomeModelByMonthNumber(monthNumber);

              final expensesList=await locator<ExpensesRepository>().getAllOfExpensesListByMonthNumber(monthNumber);

              final incomeAmount=incomeList.fold(0.0,(first,item)=>first+item.amount);

              final expenseAmount=expensesList.fold(0.0,(first,item)=>first+item.amount);
              emit(state.copyWith(expenses: expensesList,incomes: incomeList,displayDate: "${event.monthName} Verileri",currentBalance: incomeAmount-expenseAmount));
            }
        }
    );

    on<CalculateTheValuesForTheYear>(
        (event,emit)
        async{
          final incomeList= await locator<IncomeRepository>().getAllOfIncomeModelByYear(DateTime.now().year.toString());
          final expensesList=await locator<ExpensesRepository>().getAllofExpensesListByYear(DateTime.now().year.toString());
          final incomeAmount = incomeList.fold(0.0, (sum, item) => sum + item.amount);
          final expenseAmount = expensesList.fold(0.0, (sum, item) => sum + item.amount);
          emit(state.copyWith(expenses:expensesList,incomes: incomeList,displayDate: DateTime.now().year.toString(),currentBalance: incomeAmount-expenseAmount));
        }
    );
  }
  @override
  Future<void> close() {
    datesubriction.cancel();
    return super.close();
  }
}
