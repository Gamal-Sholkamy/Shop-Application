import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/favoritesCubit/states.dart';
import 'package:shop_app/network/dio_helper.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/screens/favorites/change_favorites_model.dart';
import 'package:shop_app/screens/favorites/favorites_model.dart';

class FavoritesCubit extends Cubit<FavoritesStates>{
  FavoritesCubit():super(FavoritesInitialState());
  static FavoritesCubit get(context) => BlocProvider.of(context);
  FavoritesModel? favoritesModel;
  ChangeFavoritesModel? changeFavoritesModel;
  Map<int, bool>favorites={};
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
  void changeFavorites(productId){
    favorites[productId]=!favorites[productId]!;
    emit(ChangeFavoritesSuccessState(changeFavoritesModel!));

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

      emit(ChangeFavoritesSuccessState(changeFavoritesModel!)),
    }
    ).catchError((error){
      favorites[productId]=!favorites[productId]!;
      emit(ChangeFavoritesErrorState(error.toString()));
    });
  }



}