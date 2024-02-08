import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hiring_test/core/database/local_database.dart';
import 'package:hiring_test/core/networking/dio_factory.dart';
import 'package:hiring_test/features/get_items/data/recources/local_data.dart';
import 'package:hiring_test/features/get_items/data/recources/remote_data.dart';
import 'package:hiring_test/features/get_items/data/repository_imp/get_item_repository.dart';
import 'package:hiring_test/features/get_items/presentation/cubit/get_item_cubit.dart';
import 'package:sqflite/sqflite.dart';

var getIt = GetIt.instance;

 initGetIt() async {
  // dio and local database
  Dio dio = DioFactory.getDio();
  Database database = await LocalDataBase.getDataBase();
  getIt.registerLazySingleton(() => dio);
  getIt.registerLazySingleton(() => database);

  // get items
  getIt.registerFactory(() => GetItemCubit(getItemRepository: getIt()));
  getIt.registerLazySingleton(
    () => GetItemRepository(
      connectivity: getIt(),
      getItemsLocalResource: getIt(),
      getItemRemoteRecourse: getIt(),
    ),
  );
  getIt.registerLazySingleton(() => Connectivity());
  getIt.registerLazySingleton(() => GetItemsLocalResource(database: getIt()));
  getIt.registerLazySingleton(() => GetItemRemoteRecourse(dio: getIt()));
}
