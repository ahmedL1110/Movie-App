import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photoplayuikit/layout/Cubit/CubitBloc.dart';
import 'package:photoplayuikit/layout/Cubit/StateBloc.dart';
import 'package:photoplayuikit/layout/LayoutScreen.dart';
import 'package:photoplayuikit/modules/Login/LoginScreen.dart';
import 'package:photoplayuikit/shared/components/constants.dart';
import 'package:photoplayuikit/shared/network/remote/cache_helper.dart';
import 'package:photoplayuikit/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  if (CacheHelper.getData(key: 'dark') != null) {
    dark = CacheHelper.getData(key: 'dark');
  }
  uId = CacheHelper.getData(key: 'uId');
  Widget? startWidget;
  if (uId != null && uId !='-1')
    startWidget = LayoutScreen();
  else
    startWidget = LoginScreen();
  runApp(MyApp(
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({super.key, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        print(uId);
        if (uId != null && uId !='-1')
          return LayoutCubit()
            ..getNowPlayingMovie()
            ..getGenresList()
            ..getPersonList()
            ..getUserData(uId: uId!);
        return LayoutCubit()
          ..getNowPlayingMovie()
          ..getGenresList()
          ..getPersonList();
      },
      child: BlocConsumer<LayoutCubit, LayoutState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ligthTheme(context),
            darkTheme: darkTheme(context),
            themeMode: dark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
