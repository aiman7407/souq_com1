import 'package:flutter/material.dart';
import 'package:shop_app/models/boarding_model.dart';

class OnBoardingItem extends StatelessWidget {

  final BoardingModel item;


  OnBoardingItem({this.item});




  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image(image: AssetImage(item.img),)),
        SizedBox(height: 30,),
        Text(item.title,style: TextStyle(
            fontSize: 24,fontWeight: FontWeight.bold
        ),),


        Text(item.body,style: TextStyle(
            fontSize: 14,fontWeight: FontWeight.bold
        ),)

      ],
    );
  }
}
