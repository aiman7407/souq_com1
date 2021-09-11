part of 'shopscreen_cubit.dart';

@immutable
abstract class ShopScreenState {}

class ShopscreenInitial extends ShopScreenState {}

class ShopscreenChangeBottomNavBarState extends ShopScreenState {}

class ShopscreenLoadingHomeDataState extends ShopScreenState {}

class ShopscreenSuccessHomeDataState extends ShopScreenState {}

class ShopscreenErrorHomeDataState extends ShopScreenState {}

class ShopscreenSuccessCategoriesState extends ShopScreenState {}

class ShopscreenErrorCategoriesaState extends ShopScreenState {}

class ShopscreenFavoritesState extends ShopScreenState {}

class ShopscreenSuccessFavoritesState extends ShopScreenState {
  final ChangeFavoriteModel model;

  ShopscreenSuccessFavoritesState({this.model});
}

class ShopscreenErrorFavoritesState extends ShopScreenState {}

class ShopscreenSuccessGetFavoritesState extends ShopScreenState {}

class ShopscreenLoadingGetFavoritesState extends ShopScreenState {}

class ShopscreenErrorGetFavoritesState extends ShopScreenState {}

class ShopscreenSuccessGetUserDataState extends ShopScreenState {
  final LoginModel loginModel;

  ShopscreenSuccessGetUserDataState({this.loginModel});
}

class ShopscreenLoadingGetUserDataState extends ShopScreenState {}

class ShopscreenErrorGetUserDataState extends ShopScreenState {}






class ShopscreenSuccessUpdateUserDataState extends ShopScreenState {
  final LoginModel loginModel;

  ShopscreenSuccessUpdateUserDataState({this.loginModel});
}

class ShopscreenLoadingUpdateUserDataState extends ShopScreenState {}

class ShopscreenErrorUpdateUserDataState extends ShopScreenState {}
