import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shop_app/blocs/shop_screen/shopscreen_cubit.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/src/constants.dart';

class ProductBuilder extends StatelessWidget {
  final HomeModel homeModel;
  final CategoriesModel categoryModel;

  ProductBuilder({this.homeModel, this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: homeModel.data.banners
                  .map((e) => Image(
                        image: NetworkImage(e.image),
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ))
                  .toList(),
              options: CarouselOptions(
                  height: 200,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1.0)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                ),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        CategoryItem(dataModel: categoryModel.data.data[index]),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 10.0,
                    ),
                    itemCount: categoryModel.data.data.length,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'New Products',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.grey[300]),
            child: GridView.count(
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.6,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(
                homeModel.data.products.length,
                (index) => GridBuilder(
                  productModel: homeModel.data.products[index],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final DataModel dataModel;

  CategoryItem({this.dataModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(dataModel.image),
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(
            .8,
          ),
          width: 100.0,
          child: Text(
            dataModel.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class GridBuilder extends StatelessWidget {
  final ProductModel productModel;

  GridBuilder({this.productModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(productModel.image),
                width: double.infinity,
                height: 200,
              ),
              if (productModel.discount != 0)
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productModel.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      '${productModel.price.round()}',
                      maxLines: 2,
                      style: TextStyle(fontSize: 12, color: kDefaultColor),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (productModel.discount != 0)
                      Text(
                        productModel.oldPrice.toString(),
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          ShopScreenCubit.get(context).changeFavorites(productModel.id);
                          print(productModel.id);
                        },
                        icon: CircleAvatar(
                          backgroundColor: ShopScreenCubit.get(context)
                                  .favorites[productModel.id]
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
    );
  }
}
