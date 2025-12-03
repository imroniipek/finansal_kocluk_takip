import 'package:finansal_kocluk_takip/data/repositories/expenses_repository.dart';
import 'package:finansal_kocluk_takip/data/repositories/income_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../core/sabitler.dart';
import '../../data/model/expense.dart' show ExpenseModel;
import '../../data/model/income.dart';
import '../../locator.dart';
import 'income_expense_page_events/events.dart';
import 'income_expense_page_states/status.dart';


class IncomeExpenseBloc extends Bloc<IncomeExpenseEvent, IncomeExpenseStatus> {

  IncomeExpenseBloc() : super(IncomeExpenseStatus(

      title: "Yeni Gelir",
      date: Sabitler.converttoDate(DateTime.now()) ,
      numbers: [],
      tempValue: "0",
      status:PageStatus.idle,


  ),

  )
  {
    on<ChangeType>((event, emit)
    {
      emit(state.copyWith(title: (event.isIncome==true) ? "Yeni Gelir" : "Yeni Gider",));
    });

    on<SelectDate>((event, emit)
    {

      final dayName = Sabitler.days[DateFormat("EEEE").format(event.date)];
      final month = Sabitler.monthMap[event.date.month];
      final day = event.date.day;

      emit(state.copyWith(date: "$dayName, $day $month"));

      print(state.date);
    });


    on<AddDigit>((event, emit) {

      final newList = List<String>.from(state.numbers)..add(event.digit); //Basılan Tusu buraya gelecem sonra da onu double degerlere donustruecem//
      String A = converttoString(newList);

      emit(state.copyWith(numbers: newList, tempValue: A));
    });

    on<AddOperator>((event, emit)
    {
      final value = (state.numbers.isEmpty) ? 0.0 : double.parse(state.numbers.join());

      if (state.firstValue == null)
      {
        emit(state.copyWith(firstValue: value,
            operator: event.operator,
            numbers: [],
            tempValue: state.tempValue));
      }
      else {
        final operator = (state.operator == null) ? event.operator : state.operator;

        final newValue = (operator == "*" || operator == "/") ? 1.0 : value;


        final result = _apply(state.firstValue!, newValue, operator!,);

        emit(state.copyWith(
          firstValue: result, operator: event.operator, numbers: [],));
      }
    });

    on<CalculateResult>((event, emit) {
      if (state.firstValue == null || state.operator == null) return;

      final value = double.parse(state.numbers.join());


      final result = (_apply(state.firstValue!, value, state.operator!,) * 100).floor() / 100;

      emit(state.copyWith(firstValue: result,
        tempValue: result.toString(),
        setFirstOperator: true,
        operator: null,
        numbers: [],));
    });

    on<AddNote>((event, emit) {
      final note = event.note;

      emit(state.copyWith(note: note));
    });


    on<ClearTheDigit>((event, emit) {
      final value = state.tempValue ?? "";

      if (value=="") return;

      if (value.length == 1) {
        emit(state.copyWith(
          tempValue: "0", numbers: [], firstValue: 0.0, operator: null,));
        return;
      }

      var newList = value.split("").sublist(0, value.length - 1);

      if (newList.isNotEmpty && newList.last == ".")
      {
        newList = newList.sublist(0, newList.length - 1);
      }

      double first_value = double.parse(newList.join());

      emit(state.copyWith(tempValue: newList.join(), numbers: newList, setFirstValueToNull: true, firstValue: null, operator: null,));
    });


    on<SaveTheValues>((event,emit)
    async{

      emit(state.copyWith(status:PageStatus.loading));

      try{

        if(event.isitIncome==true)
        {
          final model = IncomeModel.fromMap(event.map);

          final id = await locator<IncomeRepository>().addIncome(model);

          if (id != null && id > 0) {

            print("Gelirler---------------");
            await locator<IncomeRepository>().printIncomesTable();


            emit(state.copyWith(status: PageStatus.success,));

            emit(state.copyWith(status: PageStatus.idle));
          }

          else
            {
              emit(state.copyWith(status:PageStatus.error));
            }
        }
        else

        {
          final model =ExpenseModel.fromMap(event.map);

          final id=await locator<ExpensesRepository>().addExpense(model);

              if (id != null && id > 0)
              {
                print("Giderler---------------");
                await locator<ExpensesRepository>().printExpensesTable();

                emit(state.copyWith(status: PageStatus.success,));

                emit(state.copyWith(status: PageStatus.idle));


              }
              else
                {
                  emit(state.copyWith(status:PageStatus.error));
                }

        }

      }
      catch(e)
      {

        print(e.toString());
        emit(state.copyWith(status:PageStatus.error));

      }
    });


    on<ResetTheCalculater>((event,emit)
    {

      emit(state.copyWith(
        setFirstValueToNull: true,

        setFirstOperator: true,

        numbers:[],

        tempValue: "0"
      ));


    }

    );

    on<DeleteTheExpenseModel>(
        (event,emit)
        async {
          final id=await locator<ExpensesRepository>().deleteExpense(event.model);

          try
          {
            if (id != null && id > 0)
              {

                emit(state.copyWith(status:PageStatus.success));
                return;
              }
            emit(state.copyWith(status:PageStatus.error));
          }
          catch(e)
          {
            print(e.toString());
            emit(state.copyWith(status:PageStatus.error));
          };
        }
    );

    on<fromHomePage>((event,emit)
    {
      if(event.model is IncomeModel||event.model is ExpenseModel)
        {

          emit(state.copyWith(date:event.model.date,tempValue:event.model.amount.toString(),setFirstValueToNull:true,setFirstOperator:true,numbers:event.model.amount.toString().split("") ));

        }
    });



  }


  String converttoString(List<String> number) =>number.map((e)=>e).join();
  double _apply(double a, double b, String op) {

   if(op=="+")
     {
       return a+b;
    }
   else if(op=="-")
     {
       return a-b;
     }
   else if(op=="*")
     {
       return a*b;
     }
   else if(op=="/")
     {
       return a/b;
     }
   else
     {
       return a;
     }
  }





}
