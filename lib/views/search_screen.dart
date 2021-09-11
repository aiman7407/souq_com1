import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/search/search_cubit.dart';
import 'package:shop_app/blocs/shop_screen/shopscreen_cubit.dart';
import 'package:shop_app/components/text_field.dart';
import 'package:shop_app/src/constants.dart';

import 'favorites_screen.dart';

class SearchScreen extends StatelessWidget {

  var formKey=GlobalKey<FormState>();
  TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
        listener:(context,state){},
        builder:(context,state){
          var cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body:Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      textInputType: TextInputType.text,
                      validate: (String value)
                        {
                          if(value.isEmpty)
                            {
                              return 'Enter Text To search';
                            }
                          return null;
                        },
                      label:  'Search',
                      prefixIcon: Icons.search,
                      onSubmited: (String text){
                        print('text is ******** $text');
                        cubit.search(text);
                      }
                    ),
                    SizedBox(height: 10,),
                    if(state is SearchLoadingState)
                    LinearProgressIndicator(),
                    if(state is SearchSucsessState)
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 20,);
                        }, itemCount: cubit.model.data.data.length,
                        itemBuilder: (context, index) {
                          return ListProductsItem(
                            favoritesData: cubit.model.data.data[index],);
                        },
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        },
       );
  }
}

class ListProductsItem extends StatelessWidget {
  final   favoritesData;

  ListProductsItem({this.favoritesData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(

                  image: NetworkImage(favoritesData.image),
                  width: 120,
                  height: 120,
                ),
                if (favoritesData.discount != 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.red,
                    child: Text(
                      'discount'.toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  )
              ],
            ),
            SizedBox(width: 20,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    favoritesData.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, height: 1.3),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${favoritesData.price.round()}',
                        maxLines: 2,
                        style: TextStyle(fontSize: 12, color: kDefaultColor),
                      ),
                      SizedBox(
                        width: 5,
                      ),

                      Spacer(),
                      IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            ShopScreenCubit.get(context).changeFavorites(
                                favoritesData.id);
                            print(favoritesData.id);
                          },
                          icon: CircleAvatar(
                            backgroundColor: ShopScreenCubit
                                .get(context)
                                .favorites[favoritesData.id]
                                ? kDefaultColor
                                : Colors.grey,
                            radius: 15,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}