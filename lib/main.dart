import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/UpdateUserCubit/cubit.dart';
import 'package:shop_app/cubits/categoriesCubit/cubit.dart';
import 'package:shop_app/cubits/favoritesCubit/cubit.dart';
import 'package:shop_app/cubits/homeLayoutCubit/cubit.dart';
import 'package:shop_app/cubits/loginCubit/cubit.dart';
import 'package:shop_app/cubits/onBoardingCubit/cubit.dart';
import 'package:shop_app/cubits/productsCubit/cubit.dart';
import 'package:shop_app/cubits/profileCubit/cubit.dart';
import 'package:shop_app/network/cache_helper.dart';
import 'package:shop_app/network/dio_helper.dart';
import 'package:shop_app/reusable/themes.dart';
import 'package:shop_app/screens/homeLayout/home_layout.dart';
import 'package:shop_app/screens/login/login_screen.dart';
import 'package:shop_app/screens/on_boarding/on_boarding_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool onBoarding=CacheHelper.getData(key: 'onBoarding')??false;
  String? token=CacheHelper.getData(key: 'token');
  Widget openingScreen;
  if(onBoarding){
    if(token!=null){
      openingScreen=const HomeLayoutScreen();}
      else{
      openingScreen=const LoginScreen();}}
  else{
    openingScreen=OnBoardingScreen();}
  runApp( MyApp(openingScreen:openingScreen ));
}
class MyApp extends StatelessWidget {
  // final bool onBoarding;
  // final String? token;
  final Widget openingScreen;

   const MyApp({Key? key, required this.openingScreen}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>OnBoardingCubit()),
        BlocProvider(create: (BuildContext context)=>LoginCubit()),
        BlocProvider(create: (BuildContext context)=>HomeLayoutCubit()),
        BlocProvider(create: (BuildContext context)=>CategoriesCubit()..getCategoriesData()),
        BlocProvider(create: (BuildContext context)=>FavoritesCubit()..getFavoritesData()),
        BlocProvider(create: (BuildContext context)=>ProductsCubit()..getProductsData(FavoritesCubit.get(context))),
        BlocProvider(create: (BuildContext context)=>ProfileCubit()..getUserDate()),
        BlocProvider(create: (BuildContext context)=>UpdateUserCubit()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,

        home: openingScreen//HomeLayoutScreen()
        //onBoarding? const LoginScreen(): OnBoardingScreen(),
      ),
    );
  }
}


