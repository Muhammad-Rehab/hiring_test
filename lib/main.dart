import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiring_test/core/di/dependancy_injection.dart';
import 'package:hiring_test/core/routing/routes.dart';
import 'package:hiring_test/features/get_items/presentation/cubit/get_item_cubit.dart';
import 'package:hiring_test/features/get_items/presentation/screens/item_info_screen.dart';
import 'package:hiring_test/features/get_items/presentation/screens/items_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetItemCubit>(create: (context) => getIt<GetItemCubit>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          primaryColor: Colors.blue,
          hintColor: Colors.grey,
          shadowColor: Colors.black12,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
          )
        ),
        routes: {
          AppRoutes.itemScreenRoute:(context)=> const ItemsScreen(),
          AppRoutes.itemInfoScreenRoute:(context)=> const ItemInfoScreen(),
        },
        initialRoute: AppRoutes.itemScreenRoute,
      ),
    );
  }
}


