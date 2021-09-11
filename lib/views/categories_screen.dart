import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/shop_screen/shopscreen_cubit.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopScreenCubit,ShopScreenState>(
        listener: (context,state){},
        builder: (context,state)
        {
          var cubit=ShopScreenCubit.get(context);
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            separatorBuilder: (context, index) {
            return SizedBox(height: 20,);
          }, itemCount: cubit.categoriesModel.data.data.length,
            itemBuilder:(context,index){
              return CategoryItem(dataModel: cubit.categoriesModel.data.data[index],);
            },
          );
        },

        );
  }
}


class CategoryItem extends StatelessWidget {

  final DataModel dataModel;


  CategoryItem({this.dataModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Image(
            image: NetworkImage(dataModel.image),
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 20,),
          Text(dataModel.name,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios_rounded)

        ],
      ),
    );
  }
}
