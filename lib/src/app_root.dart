import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/login/login_cubit.dart';
import 'package:shop_app/blocs/search/search_cubit.dart';
import 'package:shop_app/blocs/shop_screen/shopscreen_cubit.dart';
import 'package:shop_app/src/themes.dart';
import 'package:shop_app/views/login_screen.dart';
import 'package:shop_app/views/on_boarding.dart';

class AppRoot extends StatelessWidget {
  final Widget startWidget;

  AppRoot({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => ShopScreenCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorites()
                ..getUserData()
        ),
        BlocProvider(create: (BuildContext context) => LoginCubit()),
        BlocProvider(create: (BuildContext context) => SearchCubit()),

      ],
      child: MaterialApp(
        theme: kLightTheme,
        darkTheme: kDarkTheme,
        home: startWidget,
      ),
    );
  }
}
