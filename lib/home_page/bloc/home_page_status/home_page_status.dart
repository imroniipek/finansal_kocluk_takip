
import 'package:finansal_kocluk_takip/data/model/income.dart';




class HomePageState
{
  final String date;

  final double currentBalance;


  final List<IncomeModel> incomes;

  HomePageState({required this.date,required this.currentBalance,required this.incomes});


  HomePageState copyWith({String ?date,double ? currentBalance,List<IncomeModel>? incomes})
  {

    return HomePageState(
        date: date?? this.date,
        currentBalance: currentBalance?? this.currentBalance,
        incomes: incomes ??this.incomes
    );



  }



}