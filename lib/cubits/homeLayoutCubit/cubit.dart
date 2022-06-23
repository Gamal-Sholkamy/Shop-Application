import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/homeLayoutCubit/states.dart';
import 'package:shop_app/screens/categories/categories.dart';
import 'package:shop_app/screens/favorites/favorites.dart';
import 'package:shop_app/screens/products/products.dart';
import 'package:shop_app/screens/settings/settings.dart';
class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutCubit() :super(HomeLayoutInitialState());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  // List<String> bottomScreensTitles=["Products","Categories","Favorites","Settings"];
  int currentIndex = 0;

  void changeCurrentIndex(index) {
    currentIndex = index;
    emit(BottomNavChangeIndexState());
  }
}
