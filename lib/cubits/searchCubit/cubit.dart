import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/searchCubit/states.dart';
import 'package:shop_app/network/dio_helper.dart';
import 'package:shop_app/screens/search/search_model.dart';
import '../../network/end_points.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() :super(SearchInitialState());
  static SearchCubit get(context)=>BlocProvider.of(context);
  SearchModel? searchModel;
   void search(String text){
     emit(SearchLoadingState());

     DioHelper.postData(
         url: Search,
         token: token,
         data: {
       'text':text,
     }).then((value) => {
       searchModel=SearchModel.fromJson(value.data),
          emit(SearchSuccessState(searchModel!)),
     }).catchError((error){
        emit(SearchErrorState(error.toString()));
     });
   }
}
