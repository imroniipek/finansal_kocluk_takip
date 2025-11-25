
import 'package:flutter/material.dart';

class Sabitler{


  static Color incomeColor=Colors.teal;

  static Color expensesColor=Colors.deepPurple;

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

  static Map<Icon,String> incomeSelections={

    Icon(Icons.attach_money):"Maaş",

    Icon(Icons.follow_the_signs_outlined):"Mevduatlar",

    Icon(Icons.money_outlined):"Tasarruf",

    Icon(Icons.add):"Ekle"

  };

  static Map<Icon,String> expensesSelections={

    Icon(Icons.car_rental):"Araba",

    Icon(Icons.home_filled):"Ev",

    Icon(Icons.local_pizza_outlined):"Gıda",

    Icon(Icons.celebration):"Eğlence",

    Icon(Icons.receipt):"Faturalar",

    Icon(Icons.checkroom):"Giyim",

    Icon(Icons.phone):"Haberleşme",

    Icon(Icons.bus_alert_sharp):"Ulaşım",

    Icon(Icons.medication):"Sağlık",

    Icon(Icons.pets_sharp):"Evcil Hayvan",

    Icon(Icons.sports_basketball):"Spor",

    Icon(Icons.add):"Ekle"

  };












}

