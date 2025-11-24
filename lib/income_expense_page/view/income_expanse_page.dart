import 'package:finansal_kocluk_takip/income_expense_page/bloc/general_bloc.dart';
import 'package:finansal_kocluk_takip/income_expense_page/bloc/income_expense_page_states/status.dart';
import 'package:finansal_kocluk_takip/income_expense_page/widgets/income_expanse_page_widgets.dart';
import 'package:finansal_kocluk_takip/income_expense_page/widgets/note_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/income_expense_page_events/events.dart';

class IncomeExpansePage extends StatelessWidget {

  final bool isitIncomepage;

  const IncomeExpansePage({super.key,required this.isitIncomepage});

  @override
  Widget build(BuildContext context) {


    context.read<IncomeExpenseBloc>().add(ChangeType(isitIncomepage));
    
    return Scaffold(
      
      appBar: AppBar(


        leading:
            IconButton(onPressed:(){}, icon: Icon(Icons.arrow_back,size:35,color:Colors.white)),
        
        title:Text(context.read<IncomeExpenseBloc>().state.title,style:GoogleFonts.poppins(fontSize:25,color:Colors.white)),

        backgroundColor: Colors.teal,

        centerTitle: true,
      ),

      body:


        SingleChildScrollView(

          child:
            Column(
              children: [

                SizedBox(height: 20,),

                theDateValue(context),

                SizedBox(height: 20,),

                valueContainer(context),

                SizedBox(height: 10,),

                NoteTextfield(
                  onTap:(value)
                    {

                      context.read<IncomeExpenseBloc>().add(AddNote(value));
                    } ,
                ),

                SizedBox(height: 20,),


                Row(
                  children: [
                    CalculatorButton(value: "1"),
                    CalculatorButton(value: "2"),
                    CalculatorButton(value: "3"),
                    CalculatorButton(value: "+")
                  ],
                ),

                Row(
                  children: [
                    CalculatorButton(value: "4"),
                    CalculatorButton(value: "5"),
                    CalculatorButton(value: "6"),
                    CalculatorButton(value: "-")
                  ],
                ),
                Row(
                  children: [
                    CalculatorButton(value: "7"),
                    CalculatorButton(value: "8"),
                    CalculatorButton(value: "9"),
                    CalculatorButton(value: "*")

                  ],
                ),
                Row(
                  children: [
                    CalculatorButton(value: "."),
                    CalculatorButton(value: "0"),
                    CalculatorButton(value: "="),
                    CalculatorButton(value: "/")

                  ],
                ),
                selectionCategory(context)
















              ],








            )










        )

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

        color:Colors.teal,

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


  Container selectionCategory(BuildContext context)
  {
    return Container(

        margin: EdgeInsets.all(10),

        width: MediaQuery.of(context).size.width,

        height: 70,


        decoration: BoxDecoration(

          color:Colors.white,

            borderRadius: BorderRadius.circular(5),

            border:Border.all(color:Colors.teal,width:3),


        ),

      child: Center(child: Text("Kategori Seçiniz",style:GoogleFonts.poppins(fontSize:30,color:Colors.black87))),




    );






        }















}


