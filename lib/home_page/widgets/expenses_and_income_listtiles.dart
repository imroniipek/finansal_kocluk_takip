import 'package:finansal_kocluk_takip/data/model/income.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/sabitler.dart';

class IncomeListtile extends StatelessWidget {
  final IncomeModel model;

  const IncomeListtile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {

    final primaryColor = Sabitler.incomeColor;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Expanded(
              child: Row(
                children: [
                  CircleAvatar(backgroundColor: Colors.white, radius: 20, child: Icon(getTheIcon(model.category), size: 24, color: primaryColor,),),

                  SizedBox(width: 12),

                  Flexible(
                    child: Text(
                      model.category, style: GoogleFonts.poppins(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w600,),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            Text("₺ ${model.amount.toStringAsFixed(2)}", style: GoogleFonts.poppins(fontSize: 20, color: primaryColor, fontWeight: FontWeight.w700,),
            ),
          ],
        ),
        ),
      ),
    );
  }

  IconData getTheIcon(String theValue)
  {
    for (var entry in Sabitler.incomeSelections.entries)
    {
      if (entry.value == theValue) {
        return entry.key;
      }
    }
    return Icons.block;
  }
}