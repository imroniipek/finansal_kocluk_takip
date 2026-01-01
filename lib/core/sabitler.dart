import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/model/expense.dart';

class Sabitler{
  static Color incomeColor =Colors.green.shade900;

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
  static const List<Color> modernColors = [
    Color(0xFF5C6BC0),
    Color(0xFF26A69A),
    Color(0xFFFF7043),
    Color(0xFF66BB6A),
    Color(0xFFAB47BC),
    Color(0xFF29B6F6),
    Color(0xFFFFCA28),
    Color(0xFF78909C),
  ];

  static String converttoDate(DateTime time)
  {
    final month=Sabitler.monthMap[time.month];

    final day=Sabitler.days[DateFormat("EEEE").format(time)];

    return "${day}, ${time.day} ${month}";

  }

  static List<Color> get colorsForExpensesButtons => [
    Color(0xFF5C6BC0),
    Color(0xFF26A69A),
    Color(0xFFFF7043),
    Color(0xFF66BB6A),
    Color(0xFFAB47BC),
    Color(0xFF29B6F6),
    Color(0xFFFFCA28),
    Color(0xFF78909C),
    Color(0xFFEC407A),
    Color(0xFF8D6E63)

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
    "Araba": Color(0xFF5C6BC0),
    "Ev": Color(0xFF26A69A),
    "Gıda": Color(0xFFFF7043),
    "Eğlence": Color(0xFF66BB6A),
    "Giyim": Color(0xFF29B6F6),
    "Faturalar": Color(0xFFAB47BC),
    "Haberleşme": Color(0xFFFFCA28),
    "Ulaşım": Color(0xFF78909C),
    "Sağlık": Color(0xFFEC407A),
    "Evcil Hayvan": Color(0xFF8D6E63),
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
  static Map<String,dynamic> convertToMap({required String date,required double amount,int? i,required String category,required String ? note})=>{"date":date, "amount":amount, "category":category,"note":note};
}