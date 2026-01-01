
class AmountCalculatorStatus{

  final List<String> numbers;

  final String? operator;

  final String? tempValue;

  final String? note;

  final bool isButtonSection;

  AmountCalculatorStatus({required this.numbers, this.operator, this.tempValue,this.note,  required this.isButtonSection

});

AmountCalculatorStatus copyWith({
  List<String>? numbers,
  String? operator,
  String? tempValue,
  String? note,
  bool? isButtonSection
})
{
  return AmountCalculatorStatus(
    numbers: numbers ?? List<String>.from(this.numbers),
      tempValue: tempValue ?? this.tempValue,
      note:note??this.note,
      isButtonSection: isButtonSection??this.isButtonSection,
  );
}
}