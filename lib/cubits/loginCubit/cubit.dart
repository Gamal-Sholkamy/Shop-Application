import 'package:flutter/material.dart';
import 'package:shop_app/cubits/loginCubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/network/dio_helper.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/screens/login/login_model.dart';
class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(LoginInitialState());
  static LoginCubit get(context)=>BlocProvider.of(context);
  late LoginModel loginModel;

bool isPassword=false;
Icon icon=const Icon(Icons.visibility) ;
void changePasswordIcon(){
  isPassword=!isPassword;
  isPassword?icon=const Icon(Icons.visibility):icon= const Icon(Icons.visibility_off);
  emit(LoginChangePasswordIcon());
}

void userLogin({
  required String email,
  required String password,

}){
  emit(LoginLoadingState());
  DioHelper.postData(
      url: login,
      data: {
        'email':email,
        'password':password,
      }).then((value) {
    print(value.data);
    loginModel=LoginModel.fromJson(value.data);
    emit(LoginSuccessState(loginModel));
    print("SSSSSSSSS:::: $state");
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
      print(error.toString());
  });
}

}