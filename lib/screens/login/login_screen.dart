import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/cubits/loginCubit/cubit.dart';
import 'package:shop_app/cubits/loginCubit/states.dart';
import 'package:shop_app/network/cache_helper.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/screens/homeLayout/home_layout.dart';
import 'package:shop_app/screens/register/register_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            //todo: navigate to home screen
            if(state.loginModel.status!){
              Fluttertoast.showToast(
                  msg: '${state.loginModel.message}',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value) {
                token=state.loginModel.data!.token!;
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const HomeLayoutScreen()), (route) => false);
              });

              //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
            }
            else {
              Fluttertoast.showToast(
                  msg: '${state.loginModel.message}',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }

        },
        builder: (context, state) {
          final loginCubit = LoginCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Login",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontSize: 34)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Login now to discover our offer",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.grey, fontSize: 18)),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter your email address";
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {},
                      obscureText: false,
                      decoration: InputDecoration(
                        label: const Text("Email Address"),
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password is too short";
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        if (formKey.currentState!.validate()) {
                          loginCubit.userLogin(
                              email: emailController.text,
                              password: passwordController.text);
                        }
                      },
                      obscureText: loginCubit.isPassword,
                      decoration: InputDecoration(
                        label: const Text("Password"),
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                            onPressed: () {
                              loginCubit.changePasswordIcon();
                            },
                            icon: loginCubit.icon),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    state is! LoginLoadingState
                        ? MaterialButton(
                            color: Colors.lightBlue,
                            height: 50.0,
                            minWidth: double.infinity,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                loginCubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            child: Text(
                              "Login",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontSize: 26),
                            ),
                          )
                        : const Center(child: CircularProgressIndicator()),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Don't have an account ?",
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 2.0,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => RegisterScreen()));
                            },
                            child: Text("REGISTER NOW",
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                        fontSize: 16,
                                        color: Colors.lightBlue),),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
