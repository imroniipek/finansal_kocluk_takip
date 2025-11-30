import 'package:finansal_kocluk_takip/income_expense_page/view/income_expanse_page.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../../core/sabitler.dart';
import '../../data/model/period_type.dart';

class ExpensesButton extends StatelessWidget {

  const ExpensesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return

  }


  List<Widget>widgetList(BuildContext context)
  {

    return Sabitler.expensesSelections.entries.map((entry)
        {
          return IconButton(

            icon:Icon(entry.key),

            onPressed: ()
            {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>IncomeExpansePage(isitIncomepage: false,type:PeriodType.daily,expensesType: entry.value,)));
            },




          );


        }




    ).toList();



  }





}
