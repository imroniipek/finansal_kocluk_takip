
abstract class DbEvent
{
  final bool isitIncome;


  DbEvent({required this.isitIncome});
}

class SavetoDb extends DbEvent
{
  final Map<String,dynamic> theMap;

  SavetoDb({required this.theMap,required super.isitIncome});

}
class UpdatetoDb extends DbEvent
{
  final Map<String,dynamic> theMapForUpdated;
  final int modelId;
  UpdatetoDb({required this.theMapForUpdated,required super.isitIncome,required this.modelId});
}

class DeleteTheModelFromDb extends DbEvent
{
  final int modelId;
  DeleteTheModelFromDb({required super.isitIncome,required this.modelId});
}

