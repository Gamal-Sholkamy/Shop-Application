import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/onBoardingCubit/cubit.dart';
import 'package:shop_app/cubits/onBoardingCubit/states.dart';
import 'package:shop_app/network/cache_helper.dart';
import 'package:shop_app/screens/login/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnBoardingScreen extends StatelessWidget {

  var onBoardingController=PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LoginScreen()), (route) => false);
                });

              },
              child: const Text("SKIP"))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(34.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                  controller: onBoardingController,
                  physics: const BouncingScrollPhysics(),

                  onPageChanged: (index){
                    if(index==(OnBoardingCubit.get(context).onBoarding.length-1)){
                      OnBoardingCubit.get(context).changePageLast(index);
                    }

                  },
                  itemBuilder: (context,index)=>buildOnBoardingItem(OnBoardingCubit.get(context).onBoarding[index]),
                  itemCount:OnBoardingCubit.get(context).onBoarding.length ),
            ),
            const SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller:onBoardingController ,
                  count: OnBoardingCubit.get(context).onBoarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.blueGrey,
                    activeDotColor: Colors.lightBlue,
                    dotHeight: 10,
                    expansionFactor: 5,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                ),
                const Spacer(),
                BlocConsumer<OnBoardingCubit,OnBoardingStates>(
                  listener: (context,state){},
                  builder: (context,state){
                   return FloatingActionButton(
                      onPressed: (){
                        print("ffffff:::$state");
                        if(state is OnBoardingLastPageState){
                          CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LoginScreen()), (route) => false);
                          });
                        //  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
                        }
                        else{
                          onBoardingController.nextPage(duration: const Duration(milliseconds: 1000),
                              curve:Curves.easeInToLinear );
                        }
                      },
                      child: const Icon(Icons.arrow_forward_ios),

                    );
                  },

                )
              ],
            ),

          ],
        ),
      ),

    );
  }




  Widget buildOnBoardingItem (model)=>Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
         // fit: BoxFit.cover,

        ),
      ),
       Text("'${model.title}'",
        style: const TextStyle(
          fontSize: 24,fontWeight: FontWeight.bold,
        ),),
      const SizedBox(
        height: 15,),
      Text("'${model.body}'",
        style: const TextStyle(
          fontSize: 18,fontWeight: FontWeight.normal,
        ),),
      const SizedBox(
        height: 5,),
    ],
  );
}
