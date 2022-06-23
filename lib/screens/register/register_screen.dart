import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/cubits/registerCubit/cubit.dart';
import 'package:shop_app/cubits/registerCubit/states.dart';
import 'package:shop_app/network/cache_helper.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/screens/homeLayout/home_layout.dart';

class RegisterScreen extends StatefulWidget{

  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey=GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

        return BlocProvider(create: (BuildContext context)=>RegisterCubit()..userRegister(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
            phone: phoneController.text),
          child:  BlocConsumer<RegisterCubit,RegisterStates>(
            listener: (context ,state){
              if (state is RegisterSuccessState){
                if(state.registerModel.status!){
                  Fluttertoast.showToast(
                      msg: '${state.registerModel.message}',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                  CacheHelper.saveData(key: 'token', value: state.registerModel.data!.token!).then((value) => {
                  token=state.registerModel.data!.token!,
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const HomeLayoutScreen()), (route) => false),
                  });
                }}
              },


            builder: (context,state){
              RegisterCubit registerCubit=RegisterCubit.get(context);
              return   Scaffold(
                appBar: AppBar(),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Register",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontSize: 34)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("Register now to discover our offer",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: Colors.grey, fontSize: 18)),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter your name";
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {},
                            obscureText: false,
                            decoration: InputDecoration(
                              label: const Text("Username"),
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
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
                            height: 15,
                          ),
                          TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "password is too short";
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              // if (formKey.currentState!.validate()) {
                              //   loginCubit.userLogin(
                              //       email: emailController.text,
                              //       password: passwordController.text);
                              // }
                            },
                            obscureText: registerCubit.isPassword,
                            decoration: InputDecoration(
                              label: const Text("Password"),
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    registerCubit.changePasswordIcon();
                                  },
                                  icon: registerCubit.icon),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "phone number is too short";
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {

                            },

                            decoration: InputDecoration(
                              label: const Text("Phone"),
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: const Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                            ),
                          ),
                          state is! RegisterLoadingState
                              ? MaterialButton(
                            color: Colors.lightBlue,
                            height: 50.0,
                            minWidth: double.infinity,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                registerCubit.userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text
                                );
                              }
                            },
                            child: Text(
                              "Register",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontSize: 26),
                            ),
                          )
                              : const Center(child: CircularProgressIndicator()),

                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
  }
}