import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/favoritesCubit/cubit.dart';
import 'package:shop_app/cubits/productsCubit/states.dart';
import 'package:shop_app/network/dio_helper.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/screens/favorites/change_favorites_model.dart';
import 'package:shop_app/screens/favorites/favorites_model.dart';
import 'package:shop_app/screens/products/products_model.dart';

class ProductsCubit extends Cubit<ProductsStates> {
  ProductsCubit() :super(ProductsInitialState());

  static ProductsCubit get(context) => BlocProvider.of(context);

  ProductsModel? productsModel;
  FavoritesModel? favoritesModel;
  ChangeFavoritesModel? changeFavoritesModel;
  Map<int,bool>favorites={};
  void getProductsData(FavoritesCubit favoritesCubit){
    emit(ProductsDataLoadingState());
    DioHelper.getData(url: home,token: token).then((value) {
      print('products ::: ${value.data}');
      productsModel=ProductsModel.fromJson(value.data);
      // print(productsModel?.data?.banners?[0]);
      productsModel?.data?.products?.forEach((element) {
        favoritesCubit.favorites.addAll({
          element.id!:element.in_favorites!
        });
        favorites = favoritesCubit.favorites;
      });
       emit(ProductsDataSuccessState(productsModel!));
      //print(homeModel!.data!.products![0].toString());
    }).catchError((error){
      print(error.toString());
      emit(ProductsDataErrorState(error.toString()));
    });

  }
  void changeFavorites(productId){
    favorites[productId]=!favorites[productId]!;
    emit(ProductsChangeFavoritesSuccessState(changeFavoritesModel!));

    DioHelper.postData(
        url: Favorites,
        data: {
          'product_id':productId,
        },
      token: token,
    ).then((value) =>{
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data),
      if(!changeFavoritesModel!.status!){
        favorites[productId]=!favorites[productId]!,
      }else{
        getFavoritesData(),
      },

      emit(ProductsChangeFavoritesSuccessState(changeFavoritesModel!)),
    }
    ).catchError((error){
      favorites[productId]=!favorites[productId]!;
      emit(ProductsChangeFavoritesErrorState(error.toString()));
    });
  }
  void getFavoritesData(){
    emit(FavoritesDataLoadingState());
    DioHelper.getData(url: Favorites,token: token).then((value) {
      print('Favorites ::: ${value.data}');
      favoritesModel=FavoritesModel.fromJson(value.data);
      emit(FavoritesDataSuccessState(favoritesModel!));
    }).catchError((error){
      print(error.toString());
      emit(FavoritesDataErrorState(error.toString()));
    });

  }
}