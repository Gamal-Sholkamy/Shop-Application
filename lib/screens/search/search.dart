import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/productsCubit/cubit.dart';
import 'package:shop_app/cubits/searchCubit/cubit.dart';
import 'package:shop_app/cubits/searchCubit/states.dart';
import 'package:shop_app/screens/search/search_model.dart';

class SearchScreen extends StatelessWidget{
   SearchScreen({Key? key}) : super(key: key);
  final formKey=GlobalKey<FormState>();
  final searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
     return BlocProvider(create: (BuildContext context)=>SearchCubit(),
    child:  BlocConsumer<SearchCubit,SearchStates>(
      listener: (context,state){},
      builder: (context,state){
        final SearchCubit searchCubit=SearchCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body:Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  TextFormField(
                    validator: (v){
                      if (v!.isEmpty){return "can not search with nothing";}
                      else{return null;}
                    },
                    controller: searchController,
                    // onChanged: (value){},
                    onFieldSubmitted: (value){
                      searchCubit.search(value);
                    },
                    decoration:  InputDecoration (
                      label: Text("Search"),
                       suffixIcon: IconButton(
                         onPressed: (){},
                         icon: Icon(Icons.search),
                       ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      )
                    ),
                  ),
                  const SizedBox(
                    height: 10,),
                  if(state is SearchLoadingState)
                    const LinearProgressIndicator(),
                  if(state is SearchSuccessState)
                  Expanded(
                  child:  ListView.separated(
                      itemBuilder: (context,index)=>buildSearchItem(state.searchModel.data!.data[index], context),
                      separatorBuilder:(context,index)=> Container(
                        color: Colors.grey,
                        height: 1,
                        width: double.infinity,),
                      itemCount: state.searchModel.data!.data.length),)
                ],
              ),
            ),
          ) ,
        );
      },
    ),);
  }

   Widget buildSearchItem(SearchDataItem model,context)=>Padding(
     padding: const EdgeInsets.all(20.0),
     child: Container(
       height: 120,
       child: Row(
         children: [

           Stack(
             alignment: AlignmentDirectional.bottomStart,
             children: [
               Image(image: NetworkImage("${model.image}"),
                 width: 120.0,
                 height: 120.0,
                 fit: BoxFit.cover,
               ),

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
                 Text('${model.name}',
                   maxLines: 2,
                   overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 14.0,height: 1.3),),
                 const Spacer(),
                 Row(
                   children: [
                     Text('${model.price}',
                       maxLines: 2,
                       overflow: TextOverflow.ellipsis,
                       style: const TextStyle(color: Colors.lightBlue,fontSize: 12.0,),),
                     const SizedBox(
                       width: 7,),

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