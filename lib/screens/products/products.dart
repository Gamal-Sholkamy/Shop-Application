
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/categoriesCubit/cubit.dart';
import 'package:shop_app/cubits/categoriesCubit/states.dart';
import 'package:shop_app/cubits/productsCubit/cubit.dart';
import 'package:shop_app/cubits/productsCubit/states.dart';
import 'package:shop_app/screens/categories/categories_model.dart';
import 'package:shop_app/screens/products/products_model.dart';


class ProductsScreen extends StatelessWidget{
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit,ProductsStates>(
        builder:(context,state){

          if(state is ProductsDataSuccessState){
          return productModel(state.productsModel,context);}
          else{
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
  Widget productModel(ProductsModel productsModel,context)=>SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: productsModel.data?.banners?.map((e) =>Image(image: NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.cover,), ).toList(),
          options: CarouselOptions(
            height: 220.0,
            initialPage: 0,//هتبدأ من العنصر الكام ف الليست
            enableInfiniteScroll: true, //يفضل يلف
            reverse: false,//لو خلصت الليست وهتعيد ميعكسهاش
             autoPlay: true,
            viewportFraction: 1.0,
            autoPlayInterval: const Duration(seconds:3 ),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),),
        const SizedBox(height: 10,),
        BlocBuilder<CategoriesCubit,CategoriesStates>(builder:(context,state){
          if(state is CategoriesDataSuccessState){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Categories",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5,),
                  Container(
                    height: 100,
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index)=>buildCategoryItem(state.categoriesModel.data!.data[index]),
                        separatorBuilder: (context,index)=>const SizedBox(width: 8,),
                        itemCount: state.categoriesModel.data!.data.length),
                  ),
                  const SizedBox(height: 5,),
                  const Text("New Product",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                ],
              ),
            );
          }
          else {
            return Container(width: double.infinity,height: 100,color: Colors.grey,);
          }
        } ),
        Container(
           color: Colors.grey[300],
           child: GridView.count(
             shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1/1.7 ,
              children: List.generate(
                  productsModel.data!.products!.length,
                      (index) => buildGridProduct(productsModel.data!.products![index],context)
            ),
        ),
         )
    ]
    ),
  );
  Widget buildGridProduct(ProductModel model,context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
           children: [
             Image(image: NetworkImage('${model.image}'),
               width: double.infinity,
               height: 200.0,
               //fit: BoxFit.cover,
             ),
             if(model.discount !=0)
             Container(
               color: Colors.red,
               padding: const EdgeInsets.symmetric(horizontal:5.0 ),
               child: const Text('DISCOUNT',style:TextStyle(
                 fontSize: 8,color: Colors.white) ,),),
           ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text('${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 14.0,height: 1.3),),
              Row(
                children: [
                  Text('${model.price.round()}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.lightBlue,fontSize: 12.0,),),
                  const SizedBox(
                    width: 7,),
                  if(model.discount !=0)
                  Text('${model.price.round()}',
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
  );
  Widget buildCategoryItem(DataModel model)=> Container(
    width: 100,
    height: 100,
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children:  [
         Image(
            height: 100.0,
            width: 100.0,
            fit: BoxFit.cover,
            image: NetworkImage("${model.image}",)),
        Container(
            width: double.infinity,
            color: Colors.black.withOpacity(.8),
            child:  Text("${model.name}",textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,style: const TextStyle(color: Colors.white),)),
      ],
    ),
  );
}