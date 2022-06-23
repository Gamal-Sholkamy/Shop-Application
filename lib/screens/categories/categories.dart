import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/categoriesCubit/cubit.dart';
import 'package:shop_app/cubits/categoriesCubit/states.dart';
import 'package:shop_app/screens/categories/categories_model.dart';

class CategoriesScreen extends StatelessWidget{
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit,CategoriesStates>(
        builder: (context,state){
          if(state is CategoriesDataSuccessState){
      return ListView.separated(

          itemBuilder:(context,index)=>buildCatItem(state.categoriesModel.data!.data[index]) ,
          separatorBuilder:(context,index)=> Container(
            height: 1,width: double.infinity,color: Colors.grey,),
          itemCount: state.categoriesModel.data!.data.length);}
          return const Center(child: CircularProgressIndicator());
    });


  }
  Widget buildCatItem(DataModel model)=>Padding(
    padding: const EdgeInsets.all(18.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage("${model.image}"),
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 20,),
        Text("${model.name}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}