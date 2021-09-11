import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/blocs/login/login_cubit.dart';
import 'package:shop_app/components/buttons.dart';
import 'package:shop_app/components/custom_toast.dart';
import 'package:shop_app/components/text_field.dart';
import 'package:shop_app/service/cache/cache_helper.dart';
import 'package:shop_app/service/cache/cache_keys.dart';
import 'package:shop_app/src/constants.dart';
import 'package:shop_app/views/regist_screen.dart';
import 'package:shop_app/views/shop_screen.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (state.loginModel.status) {
            CacheHelper.saveData(
                    key: CACHE_KEY_TOKEN, value: state.loginModel.data.token)
                .then((value) {

              navigateAndFinish(context: context, screen: ShopScreen());
            });
            print(state.loginModel.data.token);
          } else {
            print(state.loginModel.message);
            showToast(
                msg: 'error', toastStates: ToastStates.ERROR);
          }
        }

      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        'Login now to browse our hot offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter you email';
                            }
                          },
                          label: 'Email',
                          prefixIcon: Icons.email_outlined),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        obscureText: cubit.isPasswordShown,
                        controller: passwordController,
                        textInputType: TextInputType.visiblePassword,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'please enter you password';
                          }
                        },
                        label: 'Password',
                        prefixIcon: Icons.lock_outline,
                        suffix: cubit.suffix,
                        suffixAction: () {
                          cubit.changePasswordVisibility();
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => DefaultButton(
                                size: 20.0,
                                text: 'Login'.toUpperCase(),
                                action: () {
                                  if (formKey.currentState.validate()) {
                                    LoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                              ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator())),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account ?'),
                          DefaultTextButton(
                            text: 'register'.toUpperCase(),
                            action: () {
                              navigateTo(
                                  context: context, screen: RegisterScreen());
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
