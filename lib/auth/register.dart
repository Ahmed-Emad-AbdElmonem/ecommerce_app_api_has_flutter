import 'package:ecommerce_api_hashim/auth/auth_cubit.dart';
import 'package:ecommerce_api_hashim/auth/auth_states.dart';
import 'package:ecommerce_api_hashim/screens/home.dart';
import 'package:ecommerce_api_hashim/shared/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});
  
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>AuthCubit(),
    child: BlocConsumer(
      listener: (context, state) {
         if (state is RegisterSuccessState) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return   HomeScreen();
                      },),);
          
        }
        else if (state is RegisterErrorState) {
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              content: Text(state.message,style:const TextStyle(color: Colors.white),),
              backgroundColor: Colors.red,

            );
          },);
          
        }
      },
      builder: (context, state) {
        return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const Text('Sign Up',),
            const SizedBox(height: 20,),
              textFormField(
                
                emailController: nameController,
                 hintText: 'name'),
                 const SizedBox(height: 20,),
                 textFormField(
                emailController: emailController,
                 hintText: 'email'),
                 const SizedBox(height: 20,),
                 textFormField(
                emailController: phoneController,
                 hintText: 'phone'),
                 const SizedBox(height: 20,),
                 textFormField(
                  obscureText: true,
                emailController: passwordController,
                 hintText: 'password',
                 
                 ),
                 const SizedBox(height: 20,),
                 MaterialButton(
                  padding:const EdgeInsets.symmetric(vertical: 12),
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  textColor: Colors.white,
                  minWidth: double.infinity,
              child: state is RegisterLoadingState ? const  CircularProgressIndicator(color: Colors.amber,)   : const Text('register'),
                  onPressed: (){
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<AuthCubit>(context).register(
                        name: nameController.text, 
                        email: emailController.text, 
                        phone: phoneController.text, 
                        password: passwordController.text);
                      
                      
                    }
              
                 }),
              
            ],
          ),
        ),
      ),
    );
      }, ),
    
    );
    
  }
}



