import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_toast.dart';
import 'package:shop_app/service/cache/cache_helper.dart';
import 'package:shop_app/service/cache/cache_keys.dart';
import 'package:shop_app/views/login_screen.dart';

const kDefaultColor = Colors.blue;
String token = '';

void navigateTo({context, screen}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

void navigateAndFinish({context, screen}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => screen,
    ),
    (route) => false,
  );
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); //800 is size of each chunck
  pattern.allMatches(text).forEach((match) {
    print(match.group(0));
  });
}

void signOut(context)
{

  showToast(
      msg:' hahahhahah', toastStates: ToastStates.ERROR);
  CacheHelper.removeData(key: CACHE_KEY_TOKEN).
  then((value) {
    if(value)
      navigateAndFinish(screen: LoginScreen(),context:context );
  });

}