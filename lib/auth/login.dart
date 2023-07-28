import 'package:ecommerce_api_hashim/auth/auth_cubit.dart';
import 'package:ecommerce_api_hashim/auth/auth_states.dart';
import 'package:ecommerce_api_hashim/screens/home.dart';
import 'package:ecommerce_api_hashim/shared/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey =GlobalKey<FormState>();
   LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assetName'),
            fit: BoxFit.fill,
          ),
        ),
        child: BlocConsumer<AuthCubit,AuthStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return   HomeScreen();
                      },),);

                      
              
            }if (state is LoginErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(
                height: 50,
                child: Center(child: Text(state.message)),
              )));
              
            }

            
             
            
          },
          builder: (context, state) {
            return Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(
                  bottom: 50,
                ),
                child: const Text(
                  'login to continue proccess',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 179, 168, 18),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      const Text(
                        'login',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      textFormField(
                        
                        emailController: emailController,
                        hintText: 'email',
                
                      ),
                      const SizedBox(height: 15,),
                       textFormField(
                        emailController: passwordController,
                        hintText: 'password',
                        obscureText: true,
                
                      ),
                      const SizedBox(height: 15,),
                      MaterialButton(onPressed: (){

                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).login(email: emailController.text, password: passwordController.text);
                          
                        }
                      },
                      minWidth: double.infinity,
                      color: Colors.blue,
                      textColor: Colors.white,
                      child:  state is LoginLoadingState ?const CircularProgressIndicator()   :const Text('login'),
                      ),
                     const SizedBox(height: 20,),
                      RichText(
                        text:const TextSpan(
                        children: [
                          TextSpan(text: 'forget your password? ',style: TextStyle(
                            color: Colors.black,
                          ),),
                          TextSpan(text: 'click here',style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),),
                        ]
                      ),),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
          } ),
      ),
    );
  }
}
