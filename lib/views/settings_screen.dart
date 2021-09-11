import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/shop_screen/shopscreen_cubit.dart';
import 'package:shop_app/components/buttons.dart';
import 'package:shop_app/components/text_field.dart';
import 'package:shop_app/src/constants.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopScreenCubit, ShopScreenState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopScreenCubit.get(context);
        var model = cubit.loginModel;



        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;
        return ConditionalBuilder(
          condition: cubit.loginModel != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                children: [

                  if(state is ShopscreenLoadingUpdateUserDataState)
                    LinearProgressIndicator(),
                  SizedBox(height: 20,),
                  defaultFormField(
                      controller: nameController,
                      textInputType: TextInputType.name,
                      label: 'Name',
                      prefixIcon: Icons.person,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'you must enter name ';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      label: 'Email',
                      prefixIcon: Icons.email_outlined,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'you must enter Email ';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      textInputType: TextInputType.phone,
                      label: 'Phone',
                      prefixIcon: Icons.phone,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'you must enter Phone ';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  DefaultButton(
                      size: 16.0,
                      text: 'Update info'.toUpperCase(),
                      action: () {
                        if (formKey.currentState.validate()) {
                          cubit.updateUserData(
                              name: nameController.text,
                              phone: phoneController.text,
                              mail: emailController.text);
                        }
                      }),
                  DefaultButton(
                    size: 16.0,
                    text: 'Sign out'.toUpperCase(),
                    action: () => signOut,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
