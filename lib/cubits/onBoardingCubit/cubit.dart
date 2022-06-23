import 'package:shop_app/cubits/onBoardingCubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class OnBoardingCubit extends Cubit<OnBoardingStates>{
  OnBoardingCubit():super(OnBoardingInitialState());
  static OnBoardingCubit get(context)=>BlocProvider.of(context);
  List<OnBoardingModel>onBoarding=[
    OnBoardingModel(
        image: 'assets/images/shop1.png',title: "Shopping Now",body: "Come and see our hot offers"
    ),
    OnBoardingModel(
        image: 'assets/images/shop2.png',title: "Shopping Now",body: "invite your family to see our app"
    ),
    OnBoardingModel(
        image: 'assets/images/shop1.png',title: "Shopping Now",body: "More than you imagine you will found"
    ),
  ];
  int currentIndex=0;
  void changePageLast(index){
    currentIndex=index;
    emit(OnBoardingNotLastPageState());
    if(currentIndex==onBoarding.length-1){
      emit(OnBoardingLastPageState());
    }


  }
}
class OnBoardingModel{
  final String? image;
  final String? title;
  final String? body;
  OnBoardingModel({
    required this.image,required this.title,required this.body,
  });

}