

import 'package:dartz/dartz.dart';
import 'package:hiring_test/core/errors/cash_errors.dart';
import 'package:hiring_test/features/theme/data/data_resources/local_theme_data.dart';
import 'package:hiring_test/features/theme/data/model/app_theme_model.dart';

class ThemeRepositoryImp {

  LocalThemeDataImp localThemeData ;
  ThemeRepositoryImp({required this.localThemeData});

  Future<Either<Exception, AppThemeModel>> loadTheme() async {
    try{
      return Right(await localThemeData.loadLocalTheme());
    }catch (e){
     return Left(CashError());
    }
  }

  Future<Either<Exception, AppThemeModel>> toggleTheme(bool isDark) async{
    try{
      return Right(await localThemeData.toggleTheme(isDark));
    }catch(e){
      return Left(CashError());
    }
  }

}