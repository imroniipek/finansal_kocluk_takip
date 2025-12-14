import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/model/expense.dart';

class Sabitler{
  static Color incomeColor =Colors.blue.shade900;//Color(0xFF7686C2);

  static Color expensesColor=Colors.red.shade900;//Color(0xFFE57373);

  static Color generalPrimaryColor=Colors.black;

  static Map<String,String> days={

    "Monday":"Pazartesi",
    "Tuesday":"Salı",
    "Wednesday":"Çarşamba",
    "Thursday":"Perşembe",
    "Friday":"Cuma",
    "Saturday": "Cumartesi",
    "Sunday":"Pazar",

  };
  static final List<String> months = [
    "Ocak",
    "Şubat",
    "Mart",
    "Nisan",
    "Mayıs",
    "Haziran",
    "Temmuz",
    "Ağustos",
    "Eylül",
    "Ekim",
    "Kasım",
    "Aralık"
  ];

  static Map<int,String> monthMap = {
    01: "Ocak",
    02: "Şubat",
    03: "Mart",
    04: "Nisan",
    05: "Mayıs",
    06: "Haziran",
    07: "Temmuz",
    08: "Ağustos",
    09: "Eylül",
    10: "Ekim",
    11: "Kasım",
    12: "Aralık",
  };

  static String converttoDate(DateTime time)
  {
    final month=Sabitler.monthMap[time.month];

    final day=Sabitler.days[DateFormat("EEEE").format(time)];

    return "${day}, ${time.day} ${month}";

  }

  static List<Color> get colorsForExpensesButtons => [
    /*Color(0xFF527483),
    Color(0xFF7686C2),
    Colors.lime.shade400,
    Color(0xFF66D1C4),
    Color(0xFFE6AE67),
    Color(0xFFCF7F94),
    Color(0xFFA67C6E),
    Color(0xFF9B8CED),
    Color(0xFF7DA1D5),
    Color(0xFF81C784),
    Color(0xFFEAA96A),
    Color(0xFFC4BBBB),*/
    Colors.green.shade900,
    Colors.deepPurple,
    Colors.red.shade900,
    Colors.brown.shade800,
    Colors.blue.shade900,
    Colors.amber,
    Colors.lime,
    Colors.lightBlueAccent,
    Colors.pink.shade900,
    Colors.deepOrange,
    Colors.lightGreenAccent,
    Colors.brown.shade800
  ];
  static Map<IconData,String> incomeSelections={

    Icons.attach_money:"Maaş",

    Icons.follow_the_signs_outlined:"Mevduatlar",

    Icons.money_outlined:"Tasarruf",


  };

  static Map<IconData, String> expensesSelections = {
    Icons.directions_car_filled_outlined: "Araba",
    Icons.house_rounded: "Ev",
    Icons.local_grocery_store_rounded: "Gıda",
    Icons.celebration_rounded: "Eğlence",
    Icons.receipt_long_rounded: "Faturalar",
    Icons.checkroom_outlined: "Giyim",
    Icons.phone_iphone_rounded: "Haberleşme",
    Icons.directions_bus_filled_rounded: "Ulaşım",
    Icons.medical_services_rounded: "Sağlık",
    Icons.pets_rounded: "Evcil Hayvan",
  };

  static const Map<String, Color> expenseColorsMap = {
    "Araba":Color(0xFF1B5E20),
    "Ev":Color(0xFF673AB7),
    "Gıda": Color(0xFFB71C1C),
    "Eğlence": Color(0xFF3E2723),
    "Faturalar":Color(0xFF0D47A1),
    "Giyim":Color(0xFFFBC02D),
    "Haberleşme":   Color(0xFFCDDC39),
    "Ulaşım": Color(0xFF40C4FF),
    "Sağlık":Color(0xFF880E4F),
    "Evcil Hayvan":Color(0xFFFF5722),
  };
  static Map<String,double>calculateAmountPriceByCategory(List<ExpenseModel>expenses)
  {
    Map<String,double> theMap={};

    for(var expense in expenses)
      {
        if(theMap[expense.category]==null)
          {
            theMap[expense.category]=expense.amount;
          }
        else
          {
            theMap[expense.category]=theMap[expense.category]!+expense.amount;
          }
      }
    return theMap;

  }
  static Map<String,dynamic> convertToMap({required String date,required double amount,int? i,required String category})=>{"date":date, "amount":amount, "category":category};
}