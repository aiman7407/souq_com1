import 'package:flutter/material.dart';
import 'package:shop_app/components/buttons.dart';
import 'package:shop_app/components/on_boarding_card.dart';
import 'package:shop_app/models/boarding_model.dart';
import 'package:shop_app/service/cache/cache_helper.dart';
import 'package:shop_app/service/cache/cache_keys.dart';
import 'package:shop_app/src/constants.dart';
import 'package:shop_app/views/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding =[
    BoardingModel(
        img: 'assets/images/on_boarding1.png',
      title: 'on board 1 title',
      body: 'On board body 1 '

    ),
    BoardingModel(
        img: 'assets/images/on_boarding2.png',
        title: 'on board 2 title',
        body: 'On board body 2 '

    ),
    BoardingModel(
        img: 'assets/images/on_boarding2.png',
        title: 'on board 3 title',
        body: 'On board body 3 '

    ),
  ];

var boardingController=PageController();

bool isLast=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          DefaultTextButton(text: 'skip'.toUpperCase(),
            action: onSubmit

          ,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(

          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (index){
                  if(index==boarding.length-1)
                    {
                      setState(() {
                        isLast=true;
                      });
                    }
                  else
                    setState(() {
                      isLast=false;
                    });

                },
                controller: boardingController,
                  itemCount: boarding.length,
                  itemBuilder: (context,index){
                    return OnBoardingItem(item: boarding[index],);
                  }),
            ),

            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(controller: boardingController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: kDefaultColor,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                    count: boarding.length),
                Spacer(),
                FloatingActionButton(
                    child: Icon(Icons.arrow_forward_ios_rounded),
                    onPressed: (){

                      if(isLast)
                        onSubmit();
                      else
                      boardingController.nextPage(duration: Duration(
                        milliseconds: 750
                      ), curve: Curves.fastLinearToSlowEaseIn);
                    })
              ],
            )
          ],
        ),
      ),
    );
  }


  onSubmit()
  {
    CacheHelper.saveData(key: CACHE_KEY_On_Boarding_State, value: true).then((value) {
      if(value)
      navigateAndFinish(screen:LoginScreen() ,context: context);
    });

  }

}
