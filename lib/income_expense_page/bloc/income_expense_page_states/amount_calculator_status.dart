
class AmountCalculatorStatus{

  final List<String> numbers;

  final double? firstValue;

  final String? operator;

  final String? tempValue;

  final String? note;

  final bool isButtonSection;

  AmountCalculatorStatus({required this.numbers, this.firstValue, this.operator, this.tempValue,this.note,  required this.isButtonSection

});

AmountCalculatorStatus copyWith({
  bool setFirstOperator=false,
  bool setFirstValueToNull=false,
  List<String>? numbers,
  double? firstValue,
  String? operator,
  String? tempValue,
  String?note,
  bool ?isButtonSection


})
{
  return AmountCalculatorStatus(
    numbers: numbers ?? List<String>.from(this.numbers),

    operator: setFirstOperator ? null : (operator ?? this.operator),

    tempValue: tempValue ?? this.tempValue,

    firstValue: setFirstValueToNull ? null : (firstValue ?? this.firstValue),

      note:note??this.note,

      isButtonSection: isButtonSection??this.isButtonSection,


  );

}

}



