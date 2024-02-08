import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hiring_test/core/database/local_database.dart';
import 'package:hiring_test/core/networking/dio_factory.dart';
import 'package:hiring_test/features/get_items/data/recources/local_data.dart';
import 'package:hiring_test/features/get_items/data/recources/remote_data.dart';
import 'package:hiring_test/features/get_items/data/repository_imp/get_item_repository.dart';
import 'package:hiring_test/features/get_items/presentation/cubit/get_item_cubit.dart';
import 'package:hiring_test/features/theme/data/data_resources/local_theme_data.dart';
import 'package:hiring_test/features/theme/data/model/app_theme_model.dart';
import 'package:hiring_test/features/theme/data/repository/theme_repository_imp.dart';
import 'package:hiring_test/features/theme/presentation/cubit/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  // theme
   getIt.registerFactory(() => ThemeCubit(themeRepositoryImp: getIt()));
   getIt.registerLazySingleton(() => ThemeRepositoryImp(localThemeData: getIt()));
   getIt.registerLazySingleton(() => LocalThemeDataImp(sharedPreferences: getIt(), appThemeModel: getIt()));
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() =>sharedPreferences);
  getIt.registerLazySingleton(() => AppThemeModel(themeMode: ThemeMode.system));
}
