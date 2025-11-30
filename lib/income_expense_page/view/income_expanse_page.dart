import 'package:finansal_kocluk_takip/data/model/period_type.dart';
import 'package:finansal_kocluk_takip/home_page/view/home_page.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_states/status.dart';
import 'package:finansal_kocluk_takip/income_expense_page/widgets/income_expanse_page_widgets.dart';
import 'package:finansal_kocluk_takip/income_expense_page/widgets/note_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/sabitler.dart';
import '../bloc/income_expense_page_events/events.dart';

class IncomeExpansePage extends StatefulWidget {

  final bool isitIncomepage;

  final Color primaryColor;

  final PeriodType type;

  String ? expensesType;


   IncomeExpansePage({super.key,required this.isitIncomepage,required this.type,this.expensesType}):primaryColor = (isitIncomepage) ? Sabitler.incomeColor : Sabitler.expensesColor;

  @override
  State<IncomeExpansePage> createState() => _IncomeExpansePageState();


}

class _IncomeExpansePageState extends State<IncomeExpansePage> {

  bool isitButtonsSection=true;

  @override
  Widget build(BuildContext context) {

    context.read<IncomeExpenseBloc>().add(ChangeType(widget.isitIncomepage));

    return Scaffold(

      appBar: AppBar(


        leading:
            IconButton(onPressed:(){

              Navigator.pop(context);



            }, icon: Icon(Icons.arrow_back,size:35,color:Colors.white)),

        title:Text(context.read<IncomeExpenseBloc>().state.title,style:GoogleFonts.poppins(fontSize:25,color:Colors.white)),

        backgroundColor: widget.primaryColor,

        centerTitle: true,
      ),

      body:

      BlocConsumer<IncomeExpenseBloc, IncomeExpenseStatus>(


       listener: (context, state) {

      if (state.status == PageStatus.success)
      {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("İşlem başarıyla gerçekleşti"),
            backgroundColor: Colors.green,
          ),
        );

        Future.delayed(Duration(milliseconds: 400), ()
        {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()),
                (Route<dynamic> route) => false,
          );
        });

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

        //Normalde ise duzgun bir sekilde UI lerimi ekranda yazdırmak istiyorum bu sekilde kullanacam

    builder: (context, state) {

      if (state.status == PageStatus.loading)
      {
        return Center(child: CircularProgressIndicator());
      }

      return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            theDateValue(context),
            SizedBox(height: 20),
            valueContainer(context),
            SizedBox(height: 10),

            NoteTextfield(
              onTap: (value)
              {
                context.read<IncomeExpenseBloc>().add(AddNote(value));
              },
              textfieldColor: widget.primaryColor,
            ),

            SizedBox(height: 20),

            (isitButtonsSection) ? AllButtons() : GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              children: categoryContainers(context),
            ),

            (isitButtonsSection) ? selectionCategory(context) : Container(),
          ],
        ),
      );
    },
    )
    );

  }

  Column AllButtons()
  {
    return Column(
      children: [

        Row(
          children: [
            CalculatorButton(value: "1",buttonColor:widget.primaryColor),
            CalculatorButton(value: "2",buttonColor:widget.primaryColor),
            CalculatorButton(value: "3",buttonColor:widget.primaryColor),
            CalculatorButton(value: "+",buttonColor:widget.primaryColor)
          ],
        ),
        Row(
          children: [
            CalculatorButton(value: "4",buttonColor:widget.primaryColor),
            CalculatorButton(value: "5",buttonColor:widget.primaryColor),
            CalculatorButton(value: "6",buttonColor:widget.primaryColor),
            CalculatorButton(value: "-",buttonColor:widget.primaryColor)
          ],
        ),
        Row(
          children: [
            CalculatorButton(value: "7",buttonColor:widget.primaryColor),
            CalculatorButton(value: "8",buttonColor:widget.primaryColor),
            CalculatorButton(value: "9",buttonColor:widget.primaryColor),
            CalculatorButton(value: "*",buttonColor:widget.primaryColor)

          ],
        ),
        Row(
          children: [
            CalculatorButton(value: ".",buttonColor:widget.primaryColor),
            CalculatorButton(value: "0",buttonColor:widget.primaryColor),
            CalculatorButton(value: "=",buttonColor:widget.primaryColor),
            CalculatorButton(value: "/",buttonColor:widget.primaryColor)

          ],
        ),

      ],
    );

  }

  Row theDateValue(BuildContext context)
  {
    return Row(


      mainAxisAlignment: MainAxisAlignment.center,

      children: [

        IconButton(
            onPressed: () async {
             final date =await showDatePicker(context: context, firstDate: DateTime(2024), lastDate: DateTime(2030),initialDate: DateTime.now());
             context.read<IncomeExpenseBloc>().add(SelectDate(date!));
          },icon: Icon(Icons.calendar_month,size:27,color:Colors.black)
        ),



        BlocBuilder<IncomeExpenseBloc, IncomeExpenseStatus>(
          builder: (context, state) {
            return Text(state.date,style:GoogleFonts.poppins(fontSize:23,color:Colors.black));
          },
        ),



      ],

    );




  }

  Container valueContainer(BuildContext context)
  {
    return Container(

      margin: EdgeInsets.all(10),

      width: MediaQuery.of(context).size.width,

      height: 70,


      decoration: BoxDecoration(

        color:widget.primaryColor,

        borderRadius: BorderRadius.circular(5),

        boxShadow: [
          BoxShadow(color:Colors.grey,blurRadius: 10)
        ]



      ),

      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [

          SizedBox(width:50),


          BlocBuilder<IncomeExpenseBloc,IncomeExpenseStatus>
            (
              builder:(context,state)
                  {


                    return (state.tempValue!.contains("."))?Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.tempValue!.split(".")[0],style: GoogleFonts.poppins(fontSize: 40, color: Colors.white),),
                        Text(".", style: GoogleFonts.poppins(fontSize: 30, color: Colors.white),),
                        Text(state.tempValue!.split(".")[1], style: GoogleFonts.poppins(fontSize: 30, color: Colors.white)),
                      ],
                    ):Text(state.tempValue!,style: GoogleFonts.poppins(fontSize: 35, color: Colors.white),);



                  }
          ),

          IconButton(onPressed: (){
            context.read<IncomeExpenseBloc>().add(ClearTheDigit());
          }, icon: Icon(Icons.backspace_outlined,size:40,color:Colors.white)),

        ],
      ),






    );





  }

  Widget selectionCategory(BuildContext context)
  {
    return InkWell(

      onTap: ()
      {
        if(widget.expensesType==null)
        {
          setState(() {
            if((controloftheValue(context)==true))
            {
              isitButtonsSection=false;
            }
          });
        }
        else
          {




          }
      },



      child: Container(

          margin: EdgeInsets.all(10),

          width: MediaQuery.of(context).size.width,

          height: 70,


          decoration: BoxDecoration(

            color:Colors.white,

              borderRadius: BorderRadius.circular(5),

              border:Border.all(color:widget.primaryColor,width:3),


          ),

        child: Center(child: (widget.expensesType==null)?Text("Kategori Seçiniz",style:GoogleFonts.poppins(fontSize:30,color:Colors.grey.shade900,fontWeight: FontWeight.w400)):

          Text("${widget.expensesType} Ekle",style:GoogleFonts.poppins(fontSize:30,color:Colors.grey.shade900,fontWeight: FontWeight.w400)))





      ),
    );






  }


 List<Widget> categoryContainers(BuildContext context)
 {
   final values=(context.read<IncomeExpenseBloc>().state.title=="Yeni Gelir")?Sabitler.incomeSelections:Sabitler.expensesSelections;

   List<Widget>containers=[];

   for(var entry in values.entries)
     {
       containers.add(
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: InkWell(

             onTap: ()
             {
               final status=context.read<IncomeExpenseBloc>().state;

               int i=Sabitler.conevertPeriodTypetoInetegerValue(widget.type);

               final map={

                 "date":status.date,

                 "amount":double.parse(status.tempValue!),

                 "period_type":i,

                 "category":entry.value

               };

               context.read<IncomeExpenseBloc>().add(SaveTheValues(isitIncome:widget.isitIncomepage, map:map));

               context.read<IncomeExpenseBloc>().add(ResetTheCalculater());


             },



             child: Container(
               width: (MediaQuery.of(context).size.width/5),
             
               height: 50,
               decoration: BoxDecoration(
                 border: Border.all(color:widget.primaryColor,width:3,),
                 borderRadius: BorderRadius.circular(10),
             
               ),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Expanded(child: CircleAvatar(child: Icon(entry.key,size:30,color:Colors.white),radius: 30,backgroundColor: widget.primaryColor,foregroundColor: Colors.white,)),
                   Text(entry.value, style:GoogleFonts.poppins(fontSize:18,color:Colors.black,fontWeight: FontWeight.w500)),
                 ],
               ),
             ),
           ),
         ),
       );
     }


   return containers;

 }



   bool  controloftheValue(BuildContext context)
   {
     final value=double.parse(context.read<IncomeExpenseBloc>().state.tempValue!);

     return (value<=0)? false:true;
   }





}


