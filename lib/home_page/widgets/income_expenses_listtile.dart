import 'package:finansal_kocluk_takip/data/model/income.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_bloc/amount_calculator_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_events/amount_calculator_event.dart';
import 'package:finansal_kocluk_takip/income_expense_page/view/income_expanse_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/sabitler.dart';
class IncomeExpensesListtile extends StatelessWidget {
  final Map<String, List<dynamic>> model;

  const IncomeExpensesListtile({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: theCardofValues(model, context),
    );
  }
}
List<Widget> theCardofValues(
    Map<String, List<dynamic>> theMap, BuildContext context) {
  List<Widget> widgets = [];

  for (var entry in theMap.entries) {
    final values = entry.value;

    if (values.isEmpty) continue;

    final firstItem = values.first;

    widgets.add(
      Card(
        elevation: 8,
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              findTheIcon(entry.key, (firstItem is IncomeModel) ? Sabitler.incomeSelections : Sabitler.expensesSelections, (firstItem is IncomeModel) ? Sabitler.incomeColor : Sabitler.expensesColor,),

              Text(entry.key, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500, color: (firstItem is IncomeModel) ? Sabitler.incomeColor : Sabitler.expensesColor,),),

              CircleAvatar(
                radius: 15,
                backgroundColor: (firstItem is IncomeModel) ? Colors.green.shade600 : Colors.red.shade600,
                child: Text(values.length.toString(), style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold,),),),
              Text(values.fold(0.0, (p, element) => p + element.amount).toString(), style: GoogleFonts.poppins(fontSize: 18),),
            ],
          ),
          children: explationOfValues(values, context),
        ),
      ),
    );
  }
  return widgets;
}
Icon findTheIcon(String value, Map<IconData, String> map, Color color) {
  for (var entry in map.entries) {
    if (entry.value == value) {
      return Icon(entry.key, size: 30, color: color);
    }
  }
  return Icon(Icons.category, color: color);
}
List<Widget> explationOfValues(
    List<dynamic> values, BuildContext context) {
  List<Widget> tiles = [];

  if (values.isEmpty) return tiles;

  for (var entry in values) {
    tiles.add(
      InkWell(
        onTap: () {
          context.read<AmountCalculatorBloc>().add(UpdateTheModel(model: entry));

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => IncomeExpansePage(
                isitIncomepage: entry is IncomeModel,
                buttonName: "Kategoriyi Değiştir",
                modelId: entry.id,
              ),
            ),
          );
        },
        child: ListTile(
          leading: CircleAvatar(
            radius: 6,
            backgroundColor: (entry is IncomeModel) ? Colors.green.shade400 : Colors.red.shade400,),
          title: Row(
            children: [
              Text("${entry.amount} ₺", style: GoogleFonts.poppins(color: (entry is IncomeModel) ? Sabitler.incomeColor : Sabitler.expensesColor, fontSize: 18,),),
                const SizedBox(width: 10),
                Expanded(child: returnTheWidget(entry.note)),
            ],
          ),
          trailing: Text(entry.date, style: GoogleFonts.poppins(color: Colors.grey.shade600, fontSize: 16,),),),
      ),
    );
  }
  return tiles;
}
Widget returnTheWidget (String? textValue)=>(textValue!=null)? Text(textValue, overflow: TextOverflow.ellipsis,style:GoogleFonts.poppins(color:Colors.black,fontSize:20)):Container();