import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/income_expense_page_bloc/amount_calculator_bloc.dart';
import '../bloc/income_expense_page_events/amount_calculator_event.dart';

class CalculatorButton extends StatelessWidget {
  final String value;
  final Color buttonColor;

  const CalculatorButton({
    super.key,
    required this.value,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOperator = "+-*/=".contains(value);

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        if (value == "=") {
          context.read<AmountCalculatorBloc>().add(CalculateResult());
        } else if (isOperator) {
          context.read<AmountCalculatorBloc>().add(AddOperator(value));
        } else {
          context.read<AmountCalculatorBloc>().add(AddDigit(value));
        }
      },
      child: Container(
        margin: const EdgeInsets.all(6),
        width: MediaQuery.of(context).size.width / 4.6,
        height: 64,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.6),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(value, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w500, color: buttonColor,
            ),
          ),
        ),
      ),
    );
  }
}

