


import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppThemeModel extends Equatable{

  ThemeMode themeMode ;
  AppThemeModel({required this.themeMode});

  @override
  List<Object?> get props => [themeMode];
}