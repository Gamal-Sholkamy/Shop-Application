import 'package:shop_app/screens/search/search_model.dart';

abstract class SearchStates{}
class SearchInitialState extends SearchStates{}
class SearchLoadingState extends SearchStates{}
class SearchSuccessState extends SearchStates{
  SearchModel searchModel;
  SearchSuccessState(this.searchModel);
}
class SearchErrorState extends SearchStates{
  final String error;
  SearchErrorState(this.error);
}
