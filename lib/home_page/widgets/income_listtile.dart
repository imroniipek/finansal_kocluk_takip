import 'package:finansal_kocluk_takip/data/model/income.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/sabitler.dart';

class IncomeListtile extends StatelessWidget {

  final Map<String, List<IncomeModel>> model;

  const IncomeListtile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return
      (model.isEmpty)? Center(child:Text("Belirtilen Gün içimn Kayıt Bulunamamaktadır")):
      Column(
      children: ListWidget(model),
    );
  }

  List<Widget> ListWidget(Map<String, List<IncomeModel>> models) {
    List<Widget> widgetList = [];

    for (var entry in models.entries) {
      widgetList.add(
        Card(
          elevation: 6,
          shadowColor: Sabitler.incomeColor.withOpacity(0.25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.white,
          child: ExpansionTile(
            tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            collapsedIconColor: Sabitler.incomeColor,
            iconColor: Sabitler.incomeColor,

            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                findTheIcon(entry.value.first.category),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(entry.key, style: GoogleFonts.poppins(fontSize: 20, color: Sabitler.incomeColor, fontWeight: FontWeight.w600,),),

                        const SizedBox(width:10),
                        Container(width: 30, height: 30, decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.green.shade500,),
                          child: Center(child: Text(entry.value.length.toString(), style: GoogleFonts.poppins(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold,),),),),
                      ],
                    ),
                  ),
                ),



                const SizedBox(width:15),
                
                
                Text("₺ ${calculatetotalAmountsByCategory(entry.value).toString()}", style:GoogleFonts.poppins(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500,)),
                

              ],
            ),

            children: entry.value.map((e) => incomeValue(e)).toList(),
          ),
        ),
      );
    }

    return widgetList;
  }


  calculatetotalAmountsByCategory(List<IncomeModel> incomes)
  {
    double totalAmount=0.0;

    for(var income in incomes)
    {
      totalAmount+=income.amount;
    }

    return totalAmount;

  }


  Widget incomeValue(IncomeModel value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(width:20),

              Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  color: Colors.green.shade400,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(color: Colors.green.withOpacity(0.4), blurRadius: 4, offset: Offset(0, 2),)
                  ],
                ),
              ),

              const SizedBox(width:20),

              Text("₺ ${value.amount.toStringAsFixed(2)}", style: GoogleFonts.poppins(fontSize: 22, color: Colors.black87, fontWeight: FontWeight.w500,)),

              const SizedBox(width:100),
            ],
          ),

          Text(splitTheValue(value.date),style: GoogleFonts.poppins(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w400,)),

        ],
      ),
    );
  }

 
  Icon findTheIcon(String category) {
    for (var entry in Sabitler.incomeSelections.entries) {
      if (entry.value == category) {
        return Icon(entry.key, size: 40, color: Sabitler.incomeColor,);
      }
    }
    return Icon(Icons.block, color: Colors.red);
  }


  String splitTheValue(String date)=> date.split(",")[1];

  




}
