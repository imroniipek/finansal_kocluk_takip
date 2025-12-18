import 'package:finansal_kocluk_takip/data/model/expense.dart';
import 'package:finansal_kocluk_takip/data/model/income.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_events/amount_calculator_event.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_states/amount_calculator_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AmountCalculatorBloc extends Bloc<AmountCalculatorEvent,AmountCalculatorStatus>
{
  AmountCalculatorBloc():super(
      AmountCalculatorStatus(numbers: [], tempValue: "0",isButtonSection: true,firstValue: 0.0)) {
    on<AddDigit>((event, emit) {
      final digit = event.digit;
      final current = List<String>.from(state.numbers);

      if (digit == "." && current.contains(".")) {
        return;
      }

      if (current.contains(".")) {
        final dotIndex = current.indexOf(".");
        final decimalsCount = current.length - dotIndex - 1;

        if (decimalsCount >= 2) {
          return;
        }
      }

      current.add(digit);

      final temp = converttoString(current);

      emit(state.copyWith(
        numbers: current,
        tempValue: temp,
      ));
    });


    on<AddOperator>((event, emit) {
      final value = (state.numbers.isEmpty) ? state.firstValue : double.parse(
          state.numbers.join());

      if (state.firstValue == null) {
        emit(state.copyWith(firstValue: value,
            operator: event.operator,
            numbers: [],
            tempValue: state.tempValue));
      }
      else {
        final operator = (state.operator == null) ? event.operator : event
            .operator;

        final newValue = (operator == "*" || operator == "/") ? 1.0 : value;


        final result = _apply(state.firstValue!, newValue!, operator,);

        emit(state.copyWith(
          firstValue: result, operator: event.operator, numbers: [],));
      }
    });

    on<CalculateResult>((event, emit) {
      if (state.firstValue == null || state.operator == null) return;

      final value = double.parse(state.numbers.join());


      final result = (_apply(state.firstValue!, value, state.operator!,) * 100)
          .floor() / 100;

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
      if (value.length == 1 || value == "") {
        emit(state.copyWith(setFirstValueToNull: true,
            setFirstOperator: true,
            numbers: [],
            tempValue: "0",
            isButtonSection: true));
        return;
      }

      var newList = value.split("").sublist(0, value.length - 1);

      if (newList.isNotEmpty && newList.last == ".") {
        newList = newList.sublist(0, newList.length - 1);
      }

      emit(state.copyWith(tempValue: newList.join(),
        numbers: newList,
        setFirstValueToNull: true,
        firstValue: null,
        operator: null,));
    });


    on<ResetTheCalculator>((event, emit) {
      emit(state.copyWith(
          setFirstValueToNull: true,
          setFirstOperator: true,
          numbers: [],
          tempValue: "0",
          isButtonSection: true
      ));
    }

    );
    on<ClickTheButton>((event, emit) {
      (controlOfTempValue(state.tempValue!) == true) ?
      emit(state.copyWith(isButtonSection: false)) : emit(
          state.copyWith(isButtonSection: true));
    });
   on<UpdateTheModel>((event,emit)
    {
      if(event.model is ExpenseModel||event.model is IncomeModel)
        {
          final theModel=event.model;

          List<String>theList=theModel.amount.toString().split("");

          emit(state.copyWith(isButtonSection: true,note:(theModel.note!=null)?theModel.note:null,tempValue: theModel.amount.toString(),numbers:theList));

          return;
        }
    }
    );

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
  bool controlOfTempValue(String tempValue)
  {
    final value=double.parse(tempValue);
    return (value<=0)?false:true;
  }
}