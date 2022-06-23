import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/productsCubit/cubit.dart';
import 'package:shop_app/cubits/productsCubit/states.dart';
import 'package:shop_app/screens/favorites/favorites_model.dart';

import 'favorites_model.dart';

class FavoritesScreen extends StatelessWidget{
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit,ProductsStates>(
        listener: (context,state){

        },
      builder: (context,state){
          // final ProductsCubit favoritesCubit=ProductsCubit.get(context);
          if(state is FavoritesDataSuccessState){
             return ListView.separated(
                itemBuilder: (context,index)=>buildFavItem(state.favoritesModel.data!.data![index],context),
                separatorBuilder:(context,index)=> Container(
                  color: Colors.grey,
                  height: 1,
                  width: double.infinity,),
                itemCount: state.favoritesModel.data!.data!.length);
          }
          else {
            return const Center(child:  CircularProgressIndicator());
          }
      }
      ,

    );
  }

  Widget buildFavItem(DataItem model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        children: [

          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
               Image(image: NetworkImage("${model.product!.image}"),
                width: 120.0,
                height: 120.0,
                fit: BoxFit.cover,
              ),

              if(model.product!.discount !=0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal:5.0 ),
                  child: const Text('DISCOUNT',style:TextStyle(
                      fontSize: 8,color: Colors.white) ,),),
            ],
          ),

          const SizedBox(width: 20,),
          Expanded(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('${model.product!.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 14.0,height: 1.3),),
                const Spacer(),
                Row(
                  children: [
                     Text('${model.product!.price}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.lightBlue,fontSize: 12.0,),),
                    const SizedBox(
                      width: 7,),
                    if(model.product!.discount !=0)
                      Text('${model.product!.oldPrice}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:  TextStyle(color: Colors.grey[400],
                            fontSize: 10.0,
                            decoration: TextDecoration.lineThrough
                        ),),
                    const Spacer(),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: ProductsCubit.get(context).favorites[model.id!]!?Colors.lightBlue:Colors.grey,
                      child: IconButton(onPressed: (){
                        ProductsCubit.get(context).changeFavorites(model.id);
                      },
                        icon: const Icon(
                          Icons.favorite_outline,
                          color: Colors.white,
                          size: 14,),),
                    ),
                  ],
                ),
              ],
            ),
          ),



        ],
      ),
    ),
  );
}