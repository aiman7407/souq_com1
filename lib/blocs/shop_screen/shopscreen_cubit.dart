import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favories_model.dart';
import 'package:shop_app/models/favorites.dart';

import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/service/cache/cache_helper.dart';
import 'package:shop_app/service/cache/cache_keys.dart';
import 'package:shop_app/service/network/dio_helper.dart';
import 'package:shop_app/service/network/end_points.dart';
import 'package:shop_app/src/constants.dart';
import 'package:shop_app/views/categories_screen.dart';
import 'package:shop_app/views/favorites_screen.dart';
import 'package:shop_app/views/product_screen.dart';
import 'package:shop_app/views/settings_screen.dart';

part 'shopscreen_state.dart';

class ShopScreenCubit extends Cubit<ShopScreenState> {
  ShopScreenCubit() : super(ShopscreenInitial());

  static ShopScreenCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  HomeModel homeModel;
  CategoriesModel categoriesModel;
  ChangeFavoriteModel changeFavoriteModel;
  FavoritesModel favoritesModel;
  LoginModel loginModel;

  Map<int, bool> favorites = {};
  List<Widget> bottomScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  void changeBottom({int index}) {
    currentIndex = index;
    emit(ShopscreenChangeBottomNavBarState());
  }

  Future<void> getHomeData() async {
    emit(ShopscreenLoadingHomeDataState());

    DioHelper.getData(
            url: END_POINTS_HOME,
            token: CacheHelper.getData(key: CACHE_KEY_TOKEN))
        .then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
      emit(ShopscreenSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopscreenErrorHomeDataState());
    });
  }

  void getCategories() {
    DioHelper.getData(
      url: END_POINTS_Get_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopscreenSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopscreenErrorCategoriesaState());
    });
  }

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId];
    emit(ShopscreenFavoritesState());

    DioHelper.postData(
            url: END_POINTS_FAVORITES,
            data: {'product_id': productId},
            token: CacheHelper.getData(key: CACHE_KEY_TOKEN))
        .then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      if (!changeFavoriteModel.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavorites();
      }
      emit(ShopscreenSuccessFavoritesState(model: changeFavoriteModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId];
      emit(ShopscreenErrorFavoritesState());
    });
  }

  void getFavorites() {
    emit(ShopscreenLoadingGetFavoritesState());

    DioHelper.getData(
            url: END_POINTS_FAVORITES,
            token: CacheHelper.getData(key: CACHE_KEY_TOKEN))
        .then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopscreenSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopscreenErrorGetFavoritesState());
    });
  }

  void getUserData() {
    emit(ShopscreenLoadingGetUserDataState());

    DioHelper.getData(
            url: END_POINTS_PROFILE,
            token: CacheHelper.getData(key: CACHE_KEY_TOKEN))
        .then((value) {
      loginModel = LoginModel.fromJson(value.data);

      emit(ShopscreenSuccessGetUserDataState(loginModel: loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopscreenErrorGetUserDataState());
    });
  }

   updateUserData(
      {@required String name, @required String phone, @required String mail}) {
    emit(ShopscreenLoadingUpdateUserDataState());

    DioHelper.putData(
            data: {
              'name':name,
              'email':mail,
              'phone':phone,
            },
            url: END_POINTS_UPDATE_PROFILE,
            token: CacheHelper.getData(key: CACHE_KEY_TOKEN))
        .then((value) {
      loginModel = LoginModel.fromJson(value.data);

      emit(ShopscreenSuccessUpdateUserDataState(loginModel: loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopscreenErrorUpdateUserDataState());
    });
  }
}
