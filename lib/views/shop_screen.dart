import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/shop_screen/shopscreen_cubit.dart';
import 'package:shop_app/components/buttons.dart';
import 'package:shop_app/components/custom_toast.dart';
import 'package:shop_app/service/cache/cache_helper.dart';
import 'package:shop_app/service/cache/cache_keys.dart';
import 'package:shop_app/src/constants.dart';
import 'package:shop_app/views/login_screen.dart';
import 'package:shop_app/views/search_screen.dart';

class ShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopScreenCubit, ShopScreenState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopScreenCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Your Trade! '),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    navigateTo(screen: SearchScreen(), context: context);
                  })
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottom(index: index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
        );
      },
    );
  }

  void signOut(context) {
    showToast(msg: ' hahahhahah', toastStates: ToastStates.ERROR);
    CacheHelper.removeData(key: CACHE_KEY_TOKEN).then((value) {
      if (value) navigateAndFinish(screen: LoginScreen(), context: context);
    });
  }
}
