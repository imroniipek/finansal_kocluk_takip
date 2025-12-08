
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
class UpdatetoDb extends DbEvent
{
  final bool isitIncome;

  final String modelId;

  UpdatetoDb({required Map<String,dynamic> theMapForUpdated,required this.isitIncome,required this.modelId}):super(theMap:theMapForUpdated);

}
