import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_bloc/amount_calculator_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_bloc/income_expense_page_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_events/db_events.dart';
import 'package:finansal_kocluk_takip/income_expense_page/widgets/amount_display.dart';
import 'package:finansal_kocluk_takip/income_expense_page/widgets/calculator_pad.dart';
import 'package:finansal_kocluk_takip/income_expense_page/widgets/container_of_category.dart';
import 'package:finansal_kocluk_takip/income_expense_page/widgets/date_selector.dart';
import 'package:finansal_kocluk_takip/income_expense_page/widgets/note_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/sabitler.dart';
import '../../date/date_bloc/date_bloc.dart';
import '../../home_page/bloc/home_page_bloc/home_page_bloc.dart';
import '../../home_page/bloc/home_page_event/home_page_event.dart';
import '../bloc/income_expense_page_bloc/db_bloc.dart';
import '../bloc/income_expense_page_events/amount_calculator_event.dart';
import '../bloc/income_expense_page_events/events.dart';
import '../bloc/income_expense_page_states/amount_calculator_status.dart';
import '../bloc/income_expense_page_states/db_status.dart';
import '../widgets/categorySelectorButton.dart';
class IncomeExpansePage extends StatefulWidget {

  final bool isitIncomepage;
  final Color primaryColor;
  final String? buttonName;
  final int ? modelId;
  final String ? textValue;

  IncomeExpansePage({super.key, required this.isitIncomepage,this.textValue,this.buttonName, Color? primaryColor,this.modelId}) : primaryColor = primaryColor ??
  (isitIncomepage ? Sabitler.incomeColor : Sabitler.expensesColor);


  @override
  State<IncomeExpansePage> createState() => _IncomeExpansePageState();


}

class _IncomeExpansePageState extends State<IncomeExpansePage> {

  @override
  void initState() {

    context.read<IncomeExpenseBloc>().add(ChangeType(widget.isitIncomepage));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar:

      (widget.modelId==null)?

      AppBar(
        leading: IconButton(onPressed:()
        {
              context.read<AmountCalculatorBloc>().add(ResetTheCalculator());

              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back,size:35,color:Colors.white)),

        title:(widget.isitIncomepage==true)?Text("Yeni Gelir",style:GoogleFonts.poppins(fontSize:25,color:Colors.white)):Text("Yeni Gider",style:GoogleFonts.poppins(fontSize:25,color:Colors.white)),
        backgroundColor: widget.primaryColor,
        centerTitle: true,
      ):

      AppBar(
            leading: IconButton(onPressed:()
            {
              context.read<AmountCalculatorBloc>().add(ResetTheCalculator());
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back,size:35,color:Colors.white)
            ),

            title:Text("Düzenle",style:GoogleFonts.poppins(fontSize:25,color:Colors.white)),
            backgroundColor: widget.primaryColor,
            centerTitle: true,

            actions: [

              IconButton(
                icon: Icon(Icons.delete,size:35,color:Colors.white),

                onPressed: ()
                {
                  context.read<DbBloc>().add(DeleteTheModelFromDb(isitIncome: widget.isitIncomepage, modelId: widget.modelId!));
                },
              )
            ],
          ),
      body:
      BlocConsumer<DbBloc, DbStatus>(
       listener: (context, state) async{
         if (state.status == PageStatus.success)
         {
           final newDate = context.read<DateBloc>().state.date;

           context.read<HomePageBloc>().add(GetExpensesList());

           context.read<HomePageBloc>().add(GetIncomeList());

           context.read<HomePageBloc>().add(CalculateCurrentBalance());

           context.read<AmountCalculatorBloc>().add(ResetTheCalculator());

           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
             content: Text("İşleminiz Başarılı Bir şekilde Gerçekleşti",style:TextStyle(color:Colors.white)),
             backgroundColor: Colors.green.shade900,
           ));
           Navigator.pop(context);
         }
      else if (state.status == PageStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Hata oluştu"),
            backgroundColor: Colors.red,
          ),
        );
      }
    },

    builder: (context, state) {
      if (state.status == PageStatus.loading)
      {
        return Center(child: CircularProgressIndicator());
      }

      return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            DateSelector(),
            const SizedBox(height: 20),
            AmountDisplay(primaryColor: widget.primaryColor),
            const SizedBox(height: 10),

            NoteTextfield(
              onTap: (value)
              {
                context.read<AmountCalculatorBloc>().add(AddNote(value));
              },
              textfieldColor: widget.primaryColor,
              initalText: widget.textValue,
            ),

            const SizedBox(height: 20),

            BlocBuilder<AmountCalculatorBloc, AmountCalculatorStatus>(
              buildWhen: (previous, current) =>
              previous.isButtonSection != current.isButtonSection,
              builder: (context, state) {
                return state.isButtonSection
                    ? CalculatorPad(primaryColor: widget.primaryColor)
                    : GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  children: (widget.modelId==null)?categoryContainers(context,null):
                      categoryContainers(context, widget.modelId)
                );
              },
            ),

            CategorySelectorButton(state:context.watch<AmountCalculatorBloc>().state,
              primaryColor: widget.primaryColor,
              buttonName: widget.buttonName,
              isitIncome: widget.isitIncomepage,
              modelId: widget.modelId,
            ),
          ],
        ),
      );
    },
    )
    );
  }
  List<Widget> categoryContainers(BuildContext context,int ? modelId)
  {
    final values=(context.read<IncomeExpenseBloc>().state.title=="Yeni Gelir")?Sabitler.incomeSelections:Sabitler.expensesSelections;

    List<Widget>containers=[];

    for(var entry in values.entries)
    {
      containers.add(
        ContainerOfCategory(icondata: entry.key, value: entry.value, primaryColor: widget.primaryColor, isitIncomepage: widget.isitIncomepage,modelId:modelId)
      );
    }
    return containers;

  }
}
