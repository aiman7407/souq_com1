import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/userdata_model.dart';
import 'package:shop_app/service/network/dio_helper.dart';
import 'package:shop_app/service/network/end_points.dart';
part 'login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);

  IconData suffix=Icons.visibility_outlined;
  bool isPasswordShown=true;
  LoginModel loginModel;



  void changePasswordVisibility()
  {
    isPasswordShown=!isPasswordShown;
    suffix=isPasswordShown? Icons.visibility_outlined :Icons.visibility_off_outlined;
    emit(LoginPasswordChangeIConState());
  }

  void userLogin({
  String email,String password
})
  {
    emit(LoginLoadingState());
    DioHelper.postData(
        url: END_POINTS_LOGIN,
        data: {
      'email':email,
      'password':password
    }).then((value) {
      print(value.data);
      loginModel=LoginModel.fromJson(value.data);
      print('the value of token ='+ loginModel.data.token);
      emit(LoginSuccessState(loginModel: loginModel));
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error: error.toString()));
    });
  }




}
