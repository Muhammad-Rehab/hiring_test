


import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiring_test/features/theme/data/model/app_theme_model.dart';
import 'package:hiring_test/features/theme/data/repository/theme_repository_imp.dart';
import 'package:hiring_test/features/theme/presentation/cubit/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {

  ThemeRepositoryImp themeRepositoryImp ;
  bool isDark = false ;

  ThemeCubit({required this.themeRepositoryImp}):super(InitialThemeState());

  Future<void> loadTheme() async {
    emit(IsLoadingThemeState());
    Either<Exception,AppThemeModel> response = await themeRepositoryImp.loadTheme();

   emit( response.fold((failure) {
     isDark = false ;
     return FailedThemeState();
   }, (appThemeModel) {
     isDark = appThemeModel.themeMode == ThemeMode.dark;
     return LoadedThemeState(isDark: isDark);
   }));
  }

  Future<void> toggleTheme(bool isDark) async {
    emit(IsLoadingThemeState());
    Either<Exception,AppThemeModel> response = await themeRepositoryImp.toggleTheme(isDark);
    emit(response.fold((failure) => FailedThemeState(), (appThemeModel) {
      isDark = isDark;
      return LoadedThemeState(isDark: isDark);
    }));
  }


}