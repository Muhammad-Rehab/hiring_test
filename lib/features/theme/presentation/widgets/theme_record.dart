import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiring_test/features/theme/presentation/cubit/theme_cubit.dart';

class ThemeRecord extends StatefulWidget {

  const ThemeRecord({Key? key}) : super(key: key);

  @override
  State<ThemeRecord> createState() => _ThemeRecordState();
}

class _ThemeRecordState extends State<ThemeRecord> {
  late bool isDark ;
  loadIsDark(){
    isDark = BlocProvider.of<ThemeCubit>(context).isDark;
  }
  @override
  void initState() {
    loadIsDark();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Toggle Theme",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Platform.isIOS?
              CupertinoSwitch(value: isDark, onChanged: (val){
                BlocProvider.of<ThemeCubit>(context).toggleTheme(val);
                setState(() {
                  isDark = val ;
                });
              }):
              Switch(
                value: isDark,
                onChanged: (val){
                  BlocProvider.of<ThemeCubit>(context).toggleTheme(val);
                  setState(() {
                    isDark = val;
                  });
                },
              ),
            ],
      ),
    );
  }
}
