import 'package:finansal_kocluk_takip/data/model/expense.dart';
import 'package:finansal_kocluk_takip/data/model/income.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/amount_calculator/amount_calculator_event.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/amount_calculator/amount_calculator_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AmountCalculatorBloc extends Bloc<AmountCalculatorEvent,AmountCalculatorStatus>
{
  AmountCalculatorBloc():super(
      AmountCalculatorStatus(numbers: [], tempValue: "0",isButtonSection: true)) {

    on<AddDigit>((event, emit) {
      final digit = event.digit;
      final current = List<String>.from(state.numbers);

      if (digit == "." && current.contains(".")) {return;}

      if (current.contains(".")) {
        final dotIndex = current.indexOf(".");
        final decimalsCount = current.length - dotIndex - 1;
        if (decimalsCount >= 2) {return;}
      }

      current.add(digit);

      final temp = converttoString(current);

      emit(state.copyWith(
        numbers: current,
        tempValue: temp,
      ));
    });

    on<AddNote>((event, emit) {final note = event.note;
      emit(state.copyWith(note: note));
    });
    on<ClearTheDigit>((event, emit) {
      final value = state.tempValue ?? "";
      if (value.length == 1 || value == "") {

        emit(state.copyWith(numbers: [], tempValue: "0", isButtonSection: true));
        return;
      }

      var newList = value.split("").sublist(0, value.length - 1);

      if (newList.isNotEmpty && newList.last == ".") {
        newList = newList.sublist(0, newList.length - 1);
      }

      emit(state.copyWith(tempValue: newList.join(),
        numbers: newList,
        operator: null,));
    });


    on<ResetTheCalculator>((event, emit)
    {
      emit(state.copyWith(numbers: [], tempValue: "0", isButtonSection: true));
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
  bool controlOfTempValue(String tempValue)
  {
    final value=double.parse(tempValue);
    return (value<=0)?false:true;
  }
}