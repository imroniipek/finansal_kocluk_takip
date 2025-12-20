import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/home_page_bloc/home_page_bloc.dart';
import '../bloc/home_page_status/home_page_status.dart';

class CurrentBalance extends StatelessWidget {
  const CurrentBalance({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      buildWhen: (previous, current) => previous.currentBalance != current.currentBalance,
      builder: (context, state) {
        return Container(
          width: MediaQuery.of(context).size.width / 1.6,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(5),
            border:Border.all(color:Colors.white,width: 3)
          ),
          child: Center(
            child: Text("Bakiye ${state.currentBalance.toStringAsFixed(2)} ₺ ", style: GoogleFonts.poppins(fontSize: 22, color: Colors.white),),
          ),
        );
      },
    );
  }
}