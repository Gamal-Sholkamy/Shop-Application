import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/categoriesCubit/states.dart';
import 'package:shop_app/network/dio_helper.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/screens/categories/categories_model.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  CategoriesCubit() :super(CategoriesInitialState());

  static CategoriesCubit get(context) => BlocProvider.of(context);

  CategoriesModel? categoriesModel;
  void getCategoriesData(){
    emit(CategoriesDataLoadingState());
    DioHelper.getData(url: categories).then((value) {
       categoriesModel=CategoriesModel.fromJson(value.data);
       print(categoriesModel?.data!.data[1]);
      emit(CategoriesDataSuccessState(categoriesModel!));
    }).catchError((error){
      print(error.toString());
      emit(CategoriesDataErrorState(error.toString()));
    });

  }
}

