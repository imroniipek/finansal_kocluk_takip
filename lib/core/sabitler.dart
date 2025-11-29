
import 'package:finansal_kocluk_takip/data/model/period_type.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Sabitler{


  static Color incomeColor=Colors.teal;

  static Color expensesColor=Colors.red.shade600;

  static Color generalPrimaryColor=Colors.teal;





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

  static String converttoDate(DateTime now)
  {
    final month=Sabitler.monthMap[now.month];

    final day=Sabitler.days[DateFormat("EEEE").format(now)];

    return "${day},${now.day} ${month}";


  }

  static Map<IconData,String> incomeSelections={

    Icons.attach_money:"Maaş",

    Icons.follow_the_signs_outlined:"Mevduatlar",

    Icons.money_outlined:"Tasarruf",

    Icons.add:"Ekle"

  };

  static Map<IconData,String> expensesSelections={

    Icons.car_rental:"Araba",

    Icons.home_filled:"Ev",

    Icons.local_pizza_outlined:"Gıda",

    Icons.celebration:"Eğlence",

    Icons.receipt:"Faturalar",

    Icons.checkroom:"Giyim",

    Icons.phone:"Haberleşme",

    Icons.bus_alert_sharp:"Ulaşım",

    Icons.medication:"Sağlık",

    Icons.pets_sharp:"Evcil Hayvan",

    Icons.sports_basketball:"Spor",

    Icons.add:"Ekle"

  };












}

