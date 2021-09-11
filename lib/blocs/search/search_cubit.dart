import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/service/cache/cache_helper.dart';
import 'package:shop_app/service/cache/cache_keys.dart';
import 'package:shop_app/service/network/dio_helper.dart';
import 'package:shop_app/service/network/end_points.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel model;

  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: END_POINTS_PRODUCT_SEARCH,
      token: CacheHelper.getData(key: CACHE_KEY_TOKEN),
      data: {
        'text': text,
      },
    ).then((value)
    {
      model = SearchModel.fromJson(value.data);
      emit(SearchSucsessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}

