import 'package:finansal_kocluk_takip/data/model/period_type.dart';
import 'package:flutter/material.dart';

import '../../income_expense_page/view/income_expanse_page.dart';

class ExpensesandIncomeButtons extends StatelessWidget {

  final Icon icon;

  final Color color;

  final bool isitIncome;


  const ExpensesandIncomeButtons({super.key,required this.icon,required this.isitIncome,required this.color});

  @override
  Widget build(BuildContext context) {
    return

      InkWell(

        onTap: ()
        {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>IncomeExpansePage(isitIncomepage:isitIncome,type:PeriodType.daily)));
        },

        child: Container(

          height: 120,

          width: 120,

          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(100),

              color:Colors.white,

              border:Border.all(color:color,width: 10)
          ),

          child:Center(child: icon),

        ),
      );





  }
}
