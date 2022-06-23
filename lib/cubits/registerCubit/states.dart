import 'package:shop_app/screens/login/login_model.dart';

abstract class RegisterStates{}
class RegisterInitialState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{
  LoginModel registerModel ;
  RegisterSuccessState(this.registerModel);

}
class RegisterErrorState extends RegisterStates{
  final String error;
  RegisterErrorState(this.error);

}
class RegisterChangePasswordIconState extends RegisterStates{}