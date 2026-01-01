import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/amount_calculator/amount_calculator_bloc.dart';
import '../bloc/amount_calculator/amount_calculator_event.dart';
import '../bloc/amount_calculator/amount_calculator_status.dart';

class AmountDisplay extends StatelessWidget {
  final Color primaryColor;

  const AmountDisplay({super.key, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor.withOpacity(.8), primaryColor],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(.4),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: BlocBuilder<AmountCalculatorBloc, AmountCalculatorStatus>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(state.tempValue!, style: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.w600, color: Colors.white,),),
              IconButton(
                icon: const Icon(Icons.backspace_outlined, color: Colors.white),
                onPressed: () => context.read<AmountCalculatorBloc>().add(ClearTheDigit()),
              ),
            ],
          );
        },
      ),
    );
  }
}
