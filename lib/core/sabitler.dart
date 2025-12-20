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
    Colors.green.shade400,
    Colors.deepPurple.shade300,
    Colors.red.shade900,
    Colors.brown.shade300,
    Colors.blue.shade800,
    Colors.amber.shade500,
    Colors.lime.shade400,
    Colors.lightBlue.shade300,
    Colors.pink.shade300,
    Colors.deepOrange.shade300,
    Colors.lightGreen.shade300,
    Colors.brown.shade300,
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
    "Araba": Color(0xFF66BB6A),        // soft green
    "Ev": Color(0xFF9575CD),           // soft deep purple
    "Gıda": Color(0xFF7F0000),         // soft red
    "Eğlence": Color(0xFFA1887F),      // soft brown
    "Faturalar": Color(0xFF1565C0), // soft blue
    "Giyim": Color(0xFFFFD54F),        // soft amber
    "Haberleşme": Color(0xFFDCE775),   // soft lime
    "Ulaşım": Color(0xFF81D4FA),       // soft light blue
    "Sağlık": Color(0xFFF06292),       // soft pink
    "Evcil Hayvan": Color(0xFFFF8A65), // soft deep orange
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