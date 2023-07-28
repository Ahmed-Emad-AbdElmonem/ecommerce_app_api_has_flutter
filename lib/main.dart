import 'package:ecommerce_api_hashim/auth/auth_cubit.dart';
import 'package:ecommerce_api_hashim/auth/register.dart';
import 'package:ecommerce_api_hashim/constants/constants.dart';
import 'package:ecommerce_api_hashim/layout/layout_cubit.dart';
import 'package:ecommerce_api_hashim/screens/home.dart';
import 'package:ecommerce_api_hashim/shared/local_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

 await CacheNetwork.sharedInit();
 token= CacheNetwork.getcache(key: 'token');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(),),
        BlocProvider(create: (context) => LayoutCubit()..getUserData()..getBanners()..getCategories()..getProducts()..getFavourites(),)
      ],
       child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       primarySwatch: Colors.blue,
      ),
      home:token !='' && token!=null ?  HomeScreen()   : RegisterScreen(),
    ));
  }
}
