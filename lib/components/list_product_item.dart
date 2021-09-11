import 'package:flutter/material.dart';
import 'package:shop_app/blocs/shop_screen/shopscreen_cubit.dart';
import 'package:shop_app/src/constants.dart';
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

                  image: NetworkImage(favoritesData.product.image),
                  width: 120,
                  height: 120,
                ),
                if (favoritesData.product.discount != 0)
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
                    favoritesData.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, height: 1.3),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${favoritesData.product.price.round()}',
                        maxLines: 2,
                        style: TextStyle(fontSize: 12, color: kDefaultColor),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (favoritesData.product.discount != 0)
                        Text(
                          favoritesData.product.oldPrice.toString(),
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            ShopScreenCubit.get(context).changeFavorites(
                                favoritesData.product.id);
                            print(favoritesData.product.id);
                          },
                          icon: CircleAvatar(
                            backgroundColor: ShopScreenCubit
                                .get(context)
                                .favorites[favoritesData.product.id]
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
