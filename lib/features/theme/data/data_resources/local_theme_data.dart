
import 'package:flutter/material.dart';
import 'package:hiring_test/core/util/app_constants.dart';
import 'package:hiring_test/features/theme/data/model/app_theme_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocalThemeDataImp {
  AppThemeModel appThemeModel;

  SharedPreferences sharedPreferences;

  LocalThemeDataImp({required this.sharedPreferences,required this.appThemeModel});

  Future<AppThemeModel> loadLocalTheme() async {
    if (sharedPreferences.getBool(AppConstants.themeKey) == null) {
      appThemeModel.themeMode = ThemeMode.light;
      await sharedPreferences.setBool(AppConstants.themeKey, false);
    } else if (sharedPreferences.getBool(AppConstants.themeKey) == true) {
      appThemeModel.themeMode = ThemeMode.dark;
    } else {
      appThemeModel.themeMode =  ThemeMode.light;
    }
    return appThemeModel;
  }

  Future<AppThemeModel> toggleTheme(bool isDark) async {
    if(appThemeModel.themeMode == ThemeMode.dark && isDark){
      appThemeModel.themeMode = ThemeMode.light;
      await sharedPreferences.setBool(AppConstants.themeKey, false);
    }else{
      appThemeModel.themeMode = ThemeMode.dark;
      await sharedPreferences.setBool(AppConstants.themeKey, true);
    }
    return appThemeModel ;
  }
}
