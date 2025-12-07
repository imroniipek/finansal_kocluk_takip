
import 'package:flutter/material.dart';

import 'calculator_button.dart';

class CalculatorPad extends StatelessWidget {

  final Color primaryColor;

  const CalculatorPad({super.key,required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Row(
          children: [
            CalculatorButton(value: "1",buttonColor:primaryColor),
            CalculatorButton(value: "2",buttonColor:primaryColor),
            CalculatorButton(value: "3",buttonColor:primaryColor),
            CalculatorButton(value: "+",buttonColor:primaryColor)
          ],
        ),
        Row(
          children: [
            CalculatorButton(value: "4",buttonColor:primaryColor),
            CalculatorButton(value: "5",buttonColor:primaryColor),
            CalculatorButton(value: "6",buttonColor:primaryColor),
            CalculatorButton(value: "-",buttonColor:primaryColor)
          ],
        ),
        Row(
          children: [
            CalculatorButton(value: "7",buttonColor:primaryColor),
            CalculatorButton(value: "8",buttonColor:primaryColor),
            CalculatorButton(value: "9",buttonColor:primaryColor),
            CalculatorButton(value: "*",buttonColor:primaryColor)

          ],
        ),
        Row(
          children: [
            CalculatorButton(value: ".",buttonColor:primaryColor),
            CalculatorButton(value: "0",buttonColor:primaryColor),
            CalculatorButton(value: "=",buttonColor:primaryColor),
            CalculatorButton(value: "/",buttonColor:primaryColor)

          ],
        ),

      ],
    );
  }
}
