import 'package:shop_app/screens/favorites/change_favorites_model.dart';
import 'package:shop_app/screens/products/products_model.dart';

import '../../screens/favorites/favorites_model.dart';

abstract class ProductsStates{}
class ProductsInitialState extends ProductsStates{}
class ProductsDataLoadingState extends ProductsStates{}
class ProductsDataSuccessState extends ProductsStates{
  ProductsModel productsModel;
  ProductsDataSuccessState(this.productsModel);

}
class ProductsDataErrorState extends ProductsStates{
  final String error;
  ProductsDataErrorState(this.error);
}

class ProductsChangeFavoritesSuccessState extends ProductsStates{

  ChangeFavoritesModel changeFavoritesModel;
  ProductsChangeFavoritesSuccessState(this.changeFavoritesModel);
}
class ProductsChangeFavoritesErrorState extends ProductsStates{
  final String error;
  ProductsChangeFavoritesErrorState(this.error);

}

class FavoritesDataLoadingState extends ProductsStates{}
class FavoritesDataSuccessState extends ProductsStates{
  FavoritesModel favoritesModel;
  FavoritesDataSuccessState(this.favoritesModel);

}
class FavoritesDataErrorState extends ProductsStates{
  final String error;
  FavoritesDataErrorState(this.error);
}