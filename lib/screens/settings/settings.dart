import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/profileCubit/cubit.dart';
import 'package:shop_app/cubits/profileCubit/states.dart';
import 'package:shop_app/network/cache_helper.dart';
import 'package:shop_app/screens/login/login_screen.dart';

class SettingsScreen extends StatelessWidget{
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey =GlobalKey<FormState>();
    var nameController =TextEditingController();
    var emailController =TextEditingController();
    var phoneController =TextEditingController();
    return BlocConsumer<ProfileCubit,ProfileStates>(
        listener: (context,state){},
        builder: (context,state){
          final ProfileCubit profileCubit=ProfileCubit.get(context);
          var userModel=ProfileCubit.get(context).userModel;
          nameController.text=userModel!.data!.name!;
          emailController.text=userModel.data!.email!;
          phoneController.text=userModel.data!.phone!;
          if(state is ProfileSuccessState){
            return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(

                children: [
                  if(state is ProfileLoadingState)
                  const LinearProgressIndicator(),
                  const SizedBox(
                    height: 20,),
                  TextFormField(
                    controller: nameController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "name must be not empty";
                      }
                      else
                        {
                          return null;
                        }
                    },
                    decoration: InputDecoration(
                      label: Text("Name"),
                      prefixIcon:Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),

                      ),

                    ),


                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: emailController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "email must be not empty";
                      }
                      else
                      {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      label: Text("email"),
                      prefixIcon:Icon(Icons.email_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),

                      ),

                    ),


                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: phoneController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "phone must be not empty";
                      }
                      else
                      {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      label: Text("phone"),
                      prefixIcon:Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),

                      ),

                    ),


                  ),
                  const SizedBox(height: 20,),
                  MaterialButton(
                    onPressed: (){
                   if(formKey.currentState!.validate()){
                     profileCubit.updateUserDate(
                         name: nameController.text,
                         email: emailController.text,
                         phone: phoneController.text);
                   }
                    },
                    color: Colors.lightBlue,
                    height: 45,
                    child: const Text("Update",style: TextStyle(fontSize: 24),),
                  ),
                  const SizedBox(height: 20,),
                  MaterialButton(
                    onPressed: (){
                      CacheHelper.removeData(key: 'token').then((value) => {
                        if(value){
                          Navigator.pushAndRemoveUntil(
                              context, MaterialPageRoute(
                              builder: (context)=>const LoginScreen()),
                                  (route) => false),
                        }
                      });
                    },
                    color: Colors.lightBlue,
                    height: 45,
                    child: const Text("Logout",style: TextStyle(fontSize: 24),),
                  ),
                ],
              ),
            ),
          );}
          else {
            return const Center(child: CircularProgressIndicator());
          }

        },

    );
  }
}