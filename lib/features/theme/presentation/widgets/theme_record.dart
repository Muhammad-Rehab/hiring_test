import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiring_test/features/theme/presentation/cubit/theme_cubit.dart';
import 'package:hiring_test/features/theme/presentation/cubit/theme_state.dart';

class ThemeRecord extends StatelessWidget {

  const ThemeRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: BlocBuilder<ThemeCubit,ThemeState>(
        builder: (context,state) {
          if(state is LoadedThemeState){
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dark Theme",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Platform.isIOS?
                CupertinoSwitch(value: state.isDark, onChanged: (val){
                  BlocProvider.of<ThemeCubit>(context).toggleTheme(val);
                }):
                Switch(
                  value: state.isDark,
                  onChanged: (val){
                    BlocProvider.of<ThemeCubit>(context).toggleTheme(val);
                  },
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
