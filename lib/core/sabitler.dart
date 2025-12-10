
import 'package:finansal_kocluk_takip/data/model/period_type.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/model/expense.dart';

class Sabitler{


  static Color incomeColor =Color(0xFF7686C2);

  static Color expensesColor=Color(0xFFE57373);

  static Color generalPrimaryColor=Colors.deepPurple;



  static PeriodType findTheType(int value)
  {
    switch(value)
    {
      case(1):
        return PeriodType.daily;
      case(2):
        return PeriodType.monthly;
      case(3):
        return PeriodType.yearly;
      default:
        return PeriodType.daily;


    }
  }
  static int conevertPeriodTypetoInetegerValue(PeriodType type)
  {
    switch(type)
    {
      case(PeriodType.daily):
        return 1;
      case(PeriodType.monthly):
        return 2;
      case(PeriodType.yearly):
         return 3;
      default:
        return -1;

    }
  }

  static Map<String,String> days={

    "Monday":"Pazartesi",
    "Tuesday":"Salı",
    "Wednesday":"Çarşamba",
    "Thursday":"Perşembe",
    "Friday":"Cuma",
    "Saturday": "Cumartesi",
    "Sunday":"Pazar",

  };
  static Map<int,String> monthMap = {
    1: "Ocak",
    2: "Şubat",
    3: "Mart",
    4: "Nisan",
    5: "Mayıs",
    6: "Haziran",
    7: "Temmuz",
    8: "Ağustos",
    9: "Eylül",
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
    Color(0xFF527483),
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
    Color(0xFFC4BBBB),
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
    "Araba":Color(0xFF527483),
    "Ev":  Color(0xFF7686C2),
    "Gıda":Color(0xFFCDDC39),
    "Eğlence":  Color(0xFF66D1C4),
    "Faturalar":  Color(0xFFE6AE67),
    "Giyim":  Color(0xFFCF7F94),
    "Haberleşme":  Color(0xFFA67C6E),
    "Ulaşım": Color(0xFF9B8CED),
    "Sağlık": Color(0xFF7DA1D5),
    "Evcil Hayvan": Color(0xFF81C784),
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

  static Map<String,dynamic> convertToMap({required String date,required double amount,int? i,required String category})=>{"date":date, "amount":amount, "period_type":i, "category":category};



}