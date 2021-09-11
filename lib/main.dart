import 'package:flutter/material.dart';
import 'package:shop_app/service/cache/cache_helper.dart';
import 'package:shop_app/service/cache/cache_keys.dart';
import 'package:shop_app/service/network/dio_helper.dart';
import 'package:shop_app/src/app_root.dart';
import 'package:shop_app/src/constants.dart';
import 'package:shop_app/views/login_screen.dart';
import 'package:shop_app/views/on_boarding.dart';
import 'package:shop_app/views/shop_screen.dart';

void main() async{


  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();


  bool onBoardingState=CacheHelper.getData(key: CACHE_KEY_On_Boarding_State);
   token=CacheHelper.getData(key: CACHE_KEY_TOKEN);
  Widget startWidget;

  if(onBoardingState!=null)
    {
      if(token!=null)
        startWidget=ShopScreen();
      else
        startWidget=LoginScreen();
    }
  else
    startWidget=OnBoardingScreen();


  print(onBoardingState);
  print(token);
  runApp(AppRoot(startWidget: startWidget,));
}
