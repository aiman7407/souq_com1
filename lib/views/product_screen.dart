import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/shop_screen/shopscreen_cubit.dart';
import 'package:shop_app/components/custom_toast.dart';
import 'package:shop_app/components/products_builder.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopScreenCubit,ShopScreenState>(
      listener: (context,state){
        if(state is ShopscreenSuccessFavoritesState)
          {

            
            showToast(msg: state.model.message,
                toastStates: state.model.status? ToastStates.SUCCESS:ToastStates.ERROR
            );


          }
      },
    builder: (context,state){
      var cubit=ShopScreenCubit.get(context);

      return ConditionalBuilder(
            condition: cubit.homeModel!=null && cubit.categoriesModel!=null,
            fallback: (context)=>Center(child: CircularProgressIndicator()) ,
            builder:(context)=> ProductBuilder(homeModel: cubit.homeModel,categoryModel: cubit.categoriesModel,)

        ) ;
    },
    );
  }
}
