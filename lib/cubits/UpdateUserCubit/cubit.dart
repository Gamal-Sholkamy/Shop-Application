import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/UpdateUserCubit/states.dart';

import 'package:shop_app/network/dio_helper.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/screens/login/login_model.dart';

class UpdateUserCubit extends Cubit<UpdateUserStates>{
  UpdateUserCubit():super(UpdateUserInitialState());
  static UpdateUserCubit get(context)=>BlocProvider.of(context);
  LoginModel? updateModel;
  void getUserDate({
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


