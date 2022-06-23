import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/homeLayoutCubit/cubit.dart';
import 'package:shop_app/cubits/homeLayoutCubit/states.dart';
import 'package:shop_app/screens/search/search.dart';

class HomeLayoutScreen extends StatelessWidget{
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return BlocBuilder<HomeLayoutCubit,HomeLayoutStates>(
        builder:(context,state){
         final HomeLayoutCubit homeLayoutCubit=HomeLayoutCubit.get(context);
         return Scaffold(
           appBar: AppBar(
             title: Text("Salla",style: Theme.of(context).textTheme.bodyText1,),
             actions: [
               IconButton(onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen()));
               }, icon: const Icon(Icons.search))
             ],
           ),
           body: homeLayoutCubit.bottomScreens[homeLayoutCubit.currentIndex],
           bottomNavigationBar: BottomNavigationBar(
             currentIndex: homeLayoutCubit.currentIndex,
             onTap: (index){
               homeLayoutCubit.changeCurrentIndex(index);
             },
             items: const [
               BottomNavigationBarItem(icon: Icon(Icons.home_rounded),label: "Products",),
               BottomNavigationBarItem(icon: Icon(Icons.apps),label: "Categories",),
               BottomNavigationBarItem(icon: Icon(Icons.favorite_outlined),label: "Favorites",),
               BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings",),
             ],
           ),
         );
        } ,   
   );
  }
}