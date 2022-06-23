import 'package:shop_app/screens/login/login_model.dart';

abstract class ProfileStates {}
class LogoutInitialState extends ProfileStates{}


class ProfileLoadingState extends ProfileStates{}
class ProfileSuccessState extends ProfileStates{
  final LoginModel userModel;
  ProfileSuccessState(this.userModel);

}
class ProfileErrorState extends ProfileStates{
  final String error;
  ProfileErrorState(this.error);
}

class UpdateUserLoadingState extends ProfileStates{}
class UpdateUserSuccessState extends ProfileStates{
  LoginModel registerModel ;
  UpdateUserSuccessState(this.registerModel);

}
class UpdateUserErrorState extends ProfileStates{
  final String error;
  UpdateUserErrorState(this.error);

}