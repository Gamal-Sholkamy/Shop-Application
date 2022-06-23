import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/profileCubit/states.dart';
import 'package:shop_app/network/dio_helper.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/screens/login/login_model.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() :super(LogoutInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);
   LoginModel? userModel;
   void getUserDate(){
     emit(ProfileLoadingState());
     DioHelper.getData(url: profile,token: token
     ).then((value) => {
       userModel=LoginModel.fromJson(value.data),
       emit(ProfileSuccessState(userModel!)),

     }).catchError((error){
       emit(ProfileErrorState(error.toString()));
     });
   }
  LoginModel? updateModel;
  void updateUserDate({
    required String name,
    required String email,
    required String phone,
  }){
    emit(UpdateUserLoadingState());
    DioHelper.putData(url: updateProfile,token: token, data: {
      'name':name,
      'email':email,
      'phone':phone,
    }
    ).then((value) => {
      updateModel=LoginModel.fromJson(value.data),
      emit(UpdateUserSuccessState(updateModel!)),

    }).catchError((error){
      emit(UpdateUserErrorState(error.toString()));
    });
  }
}