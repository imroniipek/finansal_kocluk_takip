import 'package:flutter/material.dart';
import 'calculator_button.dart';

class CalculatorPad extends StatelessWidget {
  final Color primaryColor;

  const CalculatorPad({super.key, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF181818),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
            CalculatorButton(value: "1", buttonColor: primaryColor),
            CalculatorButton(value: "2", buttonColor: primaryColor),
            CalculatorButton(value: "3", buttonColor: primaryColor),
          ]),
          Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
            CalculatorButton(value: "4", buttonColor: primaryColor),
            CalculatorButton(value: "5", buttonColor: primaryColor),
            CalculatorButton(value: "6", buttonColor: primaryColor),
          ]),
           Row(
             mainAxisAlignment:MainAxisAlignment.spaceBetween,
               children: [
             CalculatorButton(value: "7", buttonColor: primaryColor),
             CalculatorButton(value: "8", buttonColor: primaryColor),
             CalculatorButton(value: "9", buttonColor: primaryColor),

          ]),
          Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                CalculatorButton(value: ".", buttonColor: primaryColor),
                CalculatorButton(value: "0", buttonColor: primaryColor),
                CalculatorButton(value: "0", buttonColor: primaryColor),
          ]),
        ],
      ),
    );
  }
}
