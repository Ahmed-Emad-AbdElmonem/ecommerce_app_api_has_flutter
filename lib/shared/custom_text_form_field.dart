
import 'package:flutter/material.dart';

class textFormField extends StatelessWidget {
   textFormField({
    super.key,
    required this.emailController,
    required this.hintText,
    this.obscureText=false,
  });

  final TextEditingController emailController;
  final String? hintText;
  bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:obscureText ,
      controller: emailController,
     validator: (value) {
       if (emailController.text.isEmpty) {
        return'$hintText is required';
         
       }else{
        return null;
       }
     },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
        
        
      ),
    );
  }
}