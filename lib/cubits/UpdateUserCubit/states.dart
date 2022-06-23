import 'package:shop_app/screens/login/login_model.dart';

abstract class UpdateUserStates{}
class UpdateUserInitialState extends UpdateUserStates{}
class UpdateUserLoadingState extends UpdateUserStates{}
class UpdateUserSuccessState extends UpdateUserStates{
  LoginModel registerModel ;
  UpdateUserSuccessState(this.registerModel);

}
class UpdateUserErrorState extends UpdateUserStates{
  final String error;
  UpdateUserErrorState(this.error);

}