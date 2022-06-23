import 'package:shop_app/screens/login/login_model.dart';

abstract class LoginStates {}
class LoginInitialState extends LoginStates{}
class LoginChangePasswordIcon extends LoginStates{}

class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final LoginModel loginModel;
  LoginSuccessState(this.loginModel);

}
class LoginErrorState extends LoginStates{
  final String error;
  LoginErrorState(this.error);
}
