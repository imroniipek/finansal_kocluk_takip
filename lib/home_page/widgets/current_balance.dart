import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/sabitler.dart';

class CurrentBalance extends StatelessWidget {
  const CurrentBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return

        Container(

          width: MediaQuery.of(context).size.width/1.4,

          height: 45,

          decoration: BoxDecoration(

            color:Sabitler.generalPrimaryColor,

            borderRadius: BorderRadius.circular(5),


          ),

          child:Center(child: Text("Bakiye ₺ ",style:GoogleFonts.poppins(fontSize:22,color:Colors.white),)),



        );











  }
}
