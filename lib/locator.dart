import 'package:finansal_kocluk_takip/data/db/database_helper.dart';
import 'package:finansal_kocluk_takip/data/repositories/income_repository.dart';
import 'package:get_it/get_it.dart';


GetIt locator = GetIt.instance;


void setupLocator()
{
  locator.registerLazySingleton(()=>IncomeRepository());

  locator.registerLazySingleton(()=>DatabaseHelper());


}
