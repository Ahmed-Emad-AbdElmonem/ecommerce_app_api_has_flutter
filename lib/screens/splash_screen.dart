import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);


  

  @override
  State<SplashScreen> createState() => _SplashScreenState();
  
}

class _SplashScreenState extends State<SplashScreen> {

 Future durationSplash()async{
 await Future.delayed(Duration(seconds: 2));
}
  @override
  void initState() {
  durationSplash();
  super.initState();
  
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:const [
          Expanded(child: Text('splash screen'),),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text('splash screen',),
          ),

        ],
      ),
    );
  }
}