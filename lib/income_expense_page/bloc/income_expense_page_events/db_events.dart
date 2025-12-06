
abstract class DbEvent
{
  Map<String,dynamic>theMap;

  DbEvent({required this.theMap});
}

class SavetoDb extends DbEvent
{
  final bool isitIncome;

  SavetoDb({required Map<String, dynamic> theMap,required this.isitIncome}):super(theMap: theMap);

}
