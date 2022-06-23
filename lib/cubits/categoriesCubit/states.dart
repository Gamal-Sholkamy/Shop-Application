import 'package:shop_app/screens/categories/categories_model.dart';

abstract class CategoriesStates{}
class CategoriesInitialState extends CategoriesStates{}
class CategoriesDataLoadingState extends CategoriesStates{}
class CategoriesDataSuccessState extends CategoriesStates{
  CategoriesModel categoriesModel;
  CategoriesDataSuccessState(this.categoriesModel);

}
class CategoriesDataErrorState extends CategoriesStates{
  final String error;
  CategoriesDataErrorState(this.error);
}