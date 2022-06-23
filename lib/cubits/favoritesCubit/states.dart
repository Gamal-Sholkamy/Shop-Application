import 'package:shop_app/screens/favorites/change_favorites_model.dart';
import 'package:shop_app/screens/favorites/favorites_model.dart';

abstract class FavoritesStates{}
class FavoritesInitialState extends FavoritesStates{}
class FavoritesDataLoadingState extends FavoritesStates{}
class FavoritesDataSuccessState extends FavoritesStates{
  FavoritesModel favoritesModel;
  FavoritesDataSuccessState(this.favoritesModel);

}
class FavoritesDataErrorState extends FavoritesStates{
  final String error;
  FavoritesDataErrorState(this.error);
}

class ChangeFavoritesSuccessState extends FavoritesStates{

ChangeFavoritesModel changeFavoritesModel;
ChangeFavoritesSuccessState(this.changeFavoritesModel);
}
class ChangeFavoritesErrorState extends FavoritesStates{
  final String error;
  ChangeFavoritesErrorState(this.error);

}

